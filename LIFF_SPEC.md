# THE LUNII IMAGE FILE FORMAT
Reversed specification Version 1.0, 2025.10.31 – [github.com/o-daneel/lif](https://github.com/o-daneel/lif) – oDaneel

> **THE QUITE OK IMAGE FORMAT**  
Specification Version 1.0, 2022.01.05 – qoiformat.org – Dominic Szablewski


A LIFF file is derived from a QOI file format, with some optimisation for embedded.  
TL;DR here are differences identified against the QOI format. They will be emphasized in the spec with 💢
1) Format has been ligthen to fit embedded devices with smaller pixel encodings (1 byte saved)  
Pixels are generally encoded with 8bits per color. Red / Green / Blue makes RGB 888 (3 bytes) or RGBA 8888 (4 bytes) if alpha channel is available.  
      * RGB**888** -> RGB**565** 
      * RGBA**8888** -> RGBA**5658**
1) RBG565 is enconded on two bytes. The Flam hardware has a wrong handling (volunteer ? bug ?) of endianess.  
   (more details in [LIFF\_OP\_RGB565](#liff_op_rgb565-) or [LIFF\_OP\_RGBA5658](#liff_op_rgba5658-) and [here](./LIFF_BYTEORDER.png))  
2) Blue and Red color components have been inverted on opcodes. I suspect wrong handling again (volunteer ? bug ?)  
   [LIFF\_OP\_INDEX](#liff_op_index-), [LIFF\_OP\_DIFF](#liff_op_diff-), [LIFF\_OP\_LUMA](#liff_op_luma-)

A LIFF file consists of a 💢 13-byte header, followed by any number of
data “chunks” and an 8-byte end marker.

```c
liff_header {
    char magic[4];    // magic bytes "liff"
    uint32_t width;   // image width in pixels (BE)
    uint32_t height;  // image height in pixels (BE)
    uint8_t channels; // A2 = RGB565
};
```

Images are encoded row by row, left to right, top to bottom. The decoder and encoder start with **{r: 0, g: 0, b: 0, a: 255}** as the previous pixel value. An image is complete when all pixels specified by **width** * **height** have been covered. Pixels are encoded as:

* a run of the previous pixel
* an index into an array of previously seen pixels
* a difference to the previous pixel value in r,g,b
* full r,g,b or r,g,b,a values

The color channels are assumed to not be premultiplied with the
alpha channel (“un-premultiplied alpha”).
  
A running **array[64]** (zero-initialized) of previously seen pixel values is maintained by the encoder and decoder. Each pixel that is seen by the encoder and decoder is put into this array at the position formed by a hash function of the color value. In the encoder, if the pixel value at the index matches the current pixel, this index position is written to the stream as `LIFF_OP_INDEX`. 

The hash function for the index is:

    index_position = (r * 7 + g * 5 + b * 3 + a * 0) % 64

> **💢 NOTE :** here we can notice that the polynomial values are almost the same except that Blue and Red are inverted, and Alpha is ignored

Each chunk starts with a 2- or 8-bit tag, followed by a number of data bits. The bit length of chunks is divisible by 8 - i.e. all chunks are byte aligned. All values encoded in these data bits have the most significant bit on the left. The 8-bit tags have precedence over the 2-bit tags. A decoder must check for the presence of an 8-bit tag first.  

The byte stream's end is marked with **7 0x00** bytes followed by a **single 0x01** byte.

The possible chunks are:
- [THE LUNII IMAGE FILE FORMAT](#the-lunii-image-file-format)
  - [LIFF\_OP\_RGB565 ✅](#liff_op_rgb565-)
  - [LIFF\_OP\_RGBA5658 ✅](#liff_op_rgba5658-)
  - [LIFF\_OP\_INDEX ✅](#liff_op_index-)
  - [LIFF\_OP\_DIFF ✅](#liff_op_diff-)
  - [LIFF\_OP\_LUMA ✅](#liff_op_luma-)
  - [LIFF\_OP\_RUN ✅](#liff_op_run-)


## LIFF_OP_RGB565 ✅
```
┌─ LIFF_OP_RGB565 ┬──────────────────┬──────────────────┐
│     Byte[0]     │      Byte[1]     │      Byte[2]     │
│ 7 6 5 4 3 2 1 0 │  7 6 5 4 3 2 1 0 │  7 6 5 4 3 2 1 0 │
│─────────────────┼───────┼──────────┼───────────┼──────│
│ 1 1 1 1 1 1 1 0 │ green │   blue   │    red    │ green│
└─────────────────┴───────┴──────────┴───────────┴──────┘
```
- 8-bit tag b11111110
- 5-bit red channel value
- 6-bit green channel value
- 5-bit blue channel value

The alpha value remains unchanged from the previous pixel.

> **💢 NOTE :** here the Byte[1] and Byte[2] are written with a wrong byte order (little endian instead of big). Switching back make a classical RGB565 (Byte[0], Byte[2], Byte[1])  
>  The most significant bits for the green are stored on Byte[2] and least significant bits on Byte[1]

## LIFF_OP_RGBA5658 ✅
```
┌─ LIFF_OP_RGB565 ┬──────────────────┬───────────────────┬──────────┐
│     Byte[0]     │      Byte[1]     │      Byte[2]      │  Byte[3] │
│ 7 6 5 4 3 2 1 0 │  7 6 5 4 3 2 1 0 │  7 6 5 4 3 2 1 0  │  7 .. 0  │
│─────────────────┼───────┼──────────┼───────────┼───────┼──────────│
│ 1 1 1 1 1 1 1 1 │ green │   blue   │    red    │ green │   alpha  │
└─────────────────┴───────┴──────────┴───────────┴───────┴──────────┘
```
- 8-bit tag b11111111
- 5-bit red channel value
- 6-bit green channel value
- 5-bit blue channel value
- 8-bit alpha channel value

> **💢 NOTE :** here the Byte[1] and Byte[2] are written with a wrong byte order (little endian instead of big). Switching back make a classical RGB565 (Byte[0], Byte[2], Byte[1])  
>  The most significant bits for the green are stored on Byte[2] and least significant bits on Byte[1]

## LIFF_OP_INDEX ✅
```
┌─ LIFF_OP_INDEX ─────────┐
│         Byte[0]         │
│  7  6  5  4  3  2  1  0 │
│───────┼─────────────────│
│  0  0 │      index      │
└───────┴─────────────────┘
```
- 2-bit tag b00
- 6-bit index into the color index array: 0..63

A valid encoder must not issue 2 or more consecutive `LIFF_OP_INDEX` chunks to the same index. `LIFF_OP_RUN` should be used instead.

## LIFF_OP_DIFF ✅
```
┌─ LIFF_OP_DIFF ──────────┐
│         Byte[0]         │
│  7  6  5  4  3  2  1  0 │
│───────┼─────┼─────┼─────│
│  0  1 │  db │  dg │  dr │
└───────┴─────┴─────┴─────┘
```
- 2-bit tag b01
- 2-bit blue channel difference from the previous pixel -2..1
- 2-bit green channel difference from the previous pixel -2..1
- 2-bit red channel difference from the previous pixel -2..1

> **💢 NOTE :** dr and db are swaped compared to QOI format

The difference to the current channel values are using a wraparound operation, so 1 - 2 will result in 255, while 255 + 1 will result in 0.

Values are stored as unsigned integers with a bias of 2. E.g. -2 is stored as 0 (b00). 1 is stored as 3 (b11).

The alpha value remains unchanged from the previous pixel.

## LIFF_OP_LUMA ✅
```
┌─ LIFF_OP_LUMA ──────────┬─────────────────────────┐
│         Byte[0]         │          Byte[1]        │
│  7  6  5  4  3  2  1  0 │  7  6  5  4  3  2  1  0 │
│───────┼─────────────────┼─────────────┼───────────│
│  1  0 │    diff green   │   db - dg   │  dr - dg  │
└───────┴─────────────────┴─────────────┴───────────┘
```
- 2-bit tag b10
- 6-bit green channel difference from the previous pixel -32..31
- 4-bit red channel difference minus green channel difference -8..7
- 4-bit blue channel difference minus green channel difference -8..7

> **💢 NOTE :** dr-dg and db-dg are swaped compared to QOI format

The green channel is used to indicate the general direction of change and is encoded in 6 bits. The red and blue channels (dr and db) base their diffs off of the green channel difference. I.e.:

    dr_dg = (cur_px.r - prev_px.r) - (cur_px.g - prev_px.g)
    db_dg = (cur_px.b - prev_px.b) - (cur_px.g - prev_px.g)

The difference to the current channel values are using a wraparound operation, so 10 - 13 will result in 253, while 250 + 7 will result in 1.

Values are stored as unsigned integers with a bias of 32 for the green channel and a bias of 8 for the red and blue channel. 

The alpha value remains unchanged from the previous pixel.

## LIFF_OP_RUN ✅
```
┌─ LIFF_OP_RUN ───────────┐
│ Byte[0]                 │
│ 7  6  5  4  3  2  1  0  │
│──────┼──────────────────│
│ 1  1 │       run        │
└──────┴──────────────────┘
```

- 2-bit tag b11
- 6-bit run-length repeating the previous pixel: 1..62

The run-length is stored with a bias of **-1**. Note that the run-lengths **63** and **64** (**b111110** and **b111111**) are illegal as they are occupied by the `LIFF_OP_RGB565` and `LIFF_OP_RGBA5658` tags.