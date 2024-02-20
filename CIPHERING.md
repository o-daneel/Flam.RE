- [TL;DR](#tldr)
  - [Open questions](#open-questions)
  - [Facts](#facts)
  - [Assumptions](#assumptions)
  - [Attack path](#attack-path)
- [Keys (x3)](#keys-x3)
  - [Device Key](#device-key)
  - [Story Key](#story-key)
  - [Firmware Signature ?](#firmware-signature-)


# TL;DR

**Flam still stand...**  


## Open questions
1. modifications on mdf ?

## Facts
* Wifi added networks is not creating a new file on SDCard (might be directly stored in dedicated WIFI ESP32 chip)
* Key file can be the same for all stories
* No Key do not prevent story selection. Info are incorrectly deciphered


## Assumptions 
1.  `.mdf` file seems to reuse same strucute as `.md` from Lunii v3  
    (means ciphered part of mdf is made of twice the SNU)
2.  `key` file contains Story AES Key & IV, but ciphered with device key
3.  Audio files are not encrypted
3.  Images files are not encrypted (reading liff header)

## Attack path
1. `info` file : Using info displayed upon story selection

### 1. Info file
* Using `.mdf` as ciphered known plain text as key file, to generate a ciphered info file and determine where is located story title.  
This offers a tool to decipher story ciphered data.
* Decipher first 0x10 of `main.lsf`


# Keys (x3)

* ❓ Device Key + IV (AES 128)   
  (almost confirmed)
* ❓ Story  Key + IV (AES 128)   
  (almost confirmed)
* ❓ Update Signature


## Device Key

Applies to following contents:
* second part of `.mdf`
* `key` file
  
Applies to a specific device

## Story Key
 
Applies to following contents:
* `info` file
  
Applies to all stories

## Firmware Signature ?

**NOTE** :   
Thanks to *public* key, we can only `verify()` the signature. Computing it, `sign()` requires the *private* key