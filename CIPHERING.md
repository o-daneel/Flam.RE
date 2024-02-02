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
* ..


## Assumptions 

1. 
## Attack path



# Keys (x3)

* ❓ Device Key + IV (AES 128) 
* ❓ Story  Key 
* ❓ Update Signature


## Device Key

Applies to:
* ...
  
Applies to a specific device

## Story Key

 
Applies to:
* ...
  
Applies to all stories

## Firmware Signature ?

**NOTE** :   
Thanks to *public* key, we can only `verify()` the signature. Computing it, `sign()` requires the *private* key