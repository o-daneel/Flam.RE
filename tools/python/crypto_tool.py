from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
import hexdump

BLOCK_SIZE = 16

raw_dev_key = b'\x11\x22....'
raw_dev_iv  = b'\x33\x44....'

plain_text = "LIGNE_N1\nLIGNE_N2\nLIGNE_N3\nLIGNE_N4\nLIGNE_N5\nLIGNE_N6\nLIGNE_N7\nLIGNE_N8\nLIGNE_N9".encode('utf-8')
plain_text = "Pwned ! Flam caught a cold ?".encode('utf-8')

hexdump.hexdump(raw_dev_key)
hexdump.hexdump(raw_dev_iv)
hexdump.hexdump(plain_text)

print()
aes = AES.new(raw_dev_key, AES.MODE_CBC, raw_dev_iv)

with open("info", "wb") as fp:
    # prepare bytes for info file
    ciphered = aes.encrypt(pad(plain_text, BLOCK_SIZE))
    fp.write(ciphered)

print()
hexdump.hexdump(ciphered)


# ciphering lua_write_file
with open("lua_write_file.lua", "rb") as fp:
    lua_script = fp.read()
    ciphered = aes.encrypt(pad(lua_script, BLOCK_SIZE))

    with open("main.lsf", "wb") as fp_lsf:
        fp_lsf.write(ciphered)

print()
hexdump.hexdump(ciphered)
