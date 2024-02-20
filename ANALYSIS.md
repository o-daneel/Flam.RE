# Summary
- [Summary](#summary)
- [Firmwares](#firmwares)
  - [Memory layout](#memory-layout)
  - [Bootloader Firmware](#bootloader-firmware)
    - [Upgrade steps (TBC)](#upgrade-steps-tbc)
  - [Main Firmware](#main-firmware)
  - [Comm Firmware](#comm-firmware)
- [Test Mode](#test-mode)
  - [How to enable ?](#how-to-enable-)
  - [Behavior](#behavior)
  - [Debug commands](#debug-commands)
- [Wifi](#wifi)
  - [Get Wifi PSK](#get-wifi-psk)
  - [DHCP](#dhcp)
  - [Communicate with Lunii](#communicate-with-lunii)
  - [Making a fake Lunii](#making-a-fake-lunii)
  - [Messages](#messages)
    - [LINK\_FAH](#link_fah)
    - [SCAN\_WIFI](#scan_wifi)
    - [LIST\_WIFI](#list_wifi)
    - [ADD\_WIFI](#add_wifi)
    - [REMOVE\_WIFI](#remove_wifi)
    - [FACTORY\_RESET](#factory_reset)
- [Backend](#backend)
  - [Functions](#functions)
  - [Endpoints](#endpoints)
    - [User Info](#user-info)
    - [Registration](#registration)
    - [Sign In](#sign-in)
    - [Sign Out](#sign-out)
    - [Audio Books](#audio-books)
- [Onboarding](#onboarding)
  - [Process](#process)
- [Security study](#security-study)
  - [Ghidra Project](#ghidra-project)
    - [How to import](#how-to-import)
- [Crypt-Analysis](#crypt-analysis)
  - [Keys](#keys)
    - [Story Key](#story-key)
    - [Device Key](#device-key)
- [Resources](#resources)
  - [Internal res](#internal-res)
    - [Bitmaps](#bitmaps)
    - [MP3](#mp3)
  - [SD structure \& Files](#sd-structure--files)
    - [1. Very first boot](#1-very-first-boot)
    - [2. After sync](#2-after-sync)
    - [3. After reboot](#3-after-reboot)
  - [Stories Format](#stories-format)
    - [Resources : LIF](#resources--lif)
    - [Audio : MP3](#audio--mp3)
  - [Files Format](#files-format)
    - [.mdf](#mdf)
    - [/etc/bluetooth/config/active](#etcbluetoothconfigactive)
    - [/etc/bluetooth/config/last\_device](#etcbluetoothconfiglast_device)
    - [/etc/bluetooth/devices/0](#etcbluetoothdevices0)
    - [/etc/onboarding/force\_update](#etconboardingforce_update)
    - [/etc/library/list](#etclibrarylist)
    - [/etc/wifi/config/active](#etcwificonfigactive)
    - [/str/UUID\_v4/key](#struuid_v4key)
    - [/str/UUID\_v4/info](#struuid_v4info)
    - [/str/UUID\_v4/main.lsf](#struuid_v4mainlsf)
    - [/str/UUID\_v4/version](#struuid_v4version)
    - [/str/UUID\_v4/img](#struuid_v4img)
    - [/str/UUID\_v4/scripts](#struuid_v4scripts)
    - [/str/UUID\_v4/sounds](#struuid_v4sounds)
    - [/tmp/cable\_update\_complete](#tmpcable_update_complete)
  - [Story UUIDs](#story-uuids)
    - [Full story database](#full-story-database)
- [Links](#links)


# Firmwares
##  Memory layout
Three of them are of interest:

## Bootloader Firmware 
...


### Upgrade steps (TBC)
Bootloader process as following:
...



## Main Firmware
The main firmware ! located at `0x????????`  
**Version :** 1.11.27-a058b58   
**Last Update :** 1.11.27-a058b58      
**Note :** This firmware can be updated / ? downgraded ?

## Comm Firmware
The comm firmware ! might be located at `0x????????`     
**Version :** 1.9.8-0562361  
**Last Update :** 1.9.8-0562361      
**Note :** This firmware can be updated / ? downgraded ?

# Test Mode

## How to enable ?
no NFC chip
## Behavior

## Debug commands

# Wifi
**(huge thanks to @ToToL)**

Those commands are to be sent on **Lunii-3040012345** hotspot, on server **192.168.4.1:3334**  
TODO : add pictures / ref

## Get Wifi PSK

Wifi PSK is given in the Android APK if the APK can't connect to the WIFI. It
display the message "Se connecter manuellement au WiFi" and give the PSK for
your Lunii. PSK is different for each Lunii.

This Wifi PSK came from
https://server-backend-prod.lunii.com/factory/products/30023040012345 
key json.wap.secret

#### Request
**TODO** : 
* @ToTol to get the request that generates this answer
* Anyone to help finding how to get the JWT token from Lunii online credentials (objective is to have a **curl** command to get Auth token to get it's own wifi psk)

#### Response

```JSON 
{
    "serialNumber": "30023040001234",
    "reference": "LUN7P_01_FR_STD",
    "version": "da7",
    "createdAt": "2023-12-20T07: 33: 51.803Z",
    "updatedAt": "2023-12-20T07: 33: 51.803Z",
    "wap": {
        "ssid": "Lunii-3040001234",
        "secret": "lilou378"
    }
}
```

## DHCP

It seems that there is a DHCP that give you IP on range 192.168.4.2-254.
TODO : Need to be more tested

## Communicate with Lunii

A simple "telnet 192.168.4.1 3334" is enough to send commands.

Requests are always JSON like:
```JSON 
{
  "id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": "1699754392",
  "message" : {
    "key1": "value1",
    "key2": "value2",
    ...
  }
}
```

- id: seems to be a uniq ID just to link with the answer
- timestamp: the timestamp 😆, it seems that old timestamps works
- message: keys/values for the command

Answers are always in two parts:
#### First part: Command ACK
> a JSON to indicate if the command is OK or not
```JSON 
{
  "source_id": "f3f61d43-8130-11ee-b0ad-cd0c2f4a20b4",
  "timestamp":1699775774,
  "type":0,
  "status":0
}
```
  - source_id: the same id as the request
  - timestamp: maybe the timestamp of the request. It seems to be identical
  - type: 0 for first response, 1 for second response
  - status: 0 for OK, -1 for KO

#### Second part: Response Data
> a JSON with the returned data of the command, if the command
  return a data
```JSON
{
  "source_id": "f3f61d43-8130-11ee-b0ad-cd0c2f4a20b4",
  "timestamp":1699775774,
  "type":1,
  "status":0,
  "data": the_data
}
```
- source_id: the same id as the request
- timestamp: maybe the timestamp of the request. It seems to be identical
- type: 0 for first response, 1 for second response
- status: 0 for OK, -1 for KO
- data: the data, maybe array [] or dictionnary {}

## Making a fake Lunii

You can write a simple TCP server that correctly respond to commands to
simulate a Lunii for the Android APK

## Messages
Commands are defined a JSON format with those commands supported:

- LINK_FAH  
- SCAN_WIFI
- LIST_WIFI  
- ADD_WIFI  
- REMOVE_WIFI  
- FACTORY_RESET  

### LINK_FAH 
Initiates the process of pairing a remote Lunii account with a device. This is a two step process:
1. A token is sent from remote server to the Lunii storyteller.   
   (this token will be associated to the online account)
2. The Lunii device will cipher the token and return it as a JSON payload along with SNU  
   (this allows the remote server to retrieve the device key from SNU and check that original token is genuine)

#### Request
 
```JSON 
{
  "id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": "1699754392",
  "message" : {
    "command" : "LINK_FAH",
    "ssid"    : "wifi_ssid",
    "password": "wifi_password",
    "token"   : "base64_encoded_token"
  }
}
```

#### Response

**TODO** : How to generate this command ?

To be filled based on Ghidra
### SCAN_WIFI

Scan for Wifi the Lunii can see

#### Request

```JSON 
{
  "id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": "1699754392",
  "message" : {
    "command": "SCAN_WIFI"
  }
}
```

#### Response

```JSON 
{
  "source_id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": 1699754392,
  "type":0,
  "status":0
}
{
  "source_id":"c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "type":1,
  "status":0,
  "timestamp":1699754392,
  "data": {
    "scan_duration": 2,
    "networks": [
      {
        "ssid": "HOME",
        "bssid": "XX:XX:XX:XX:XX:XX",
        "secure": 4,
        "rssi": -40
      },
      {
        "ssid": "OpenWifi",
        "bssid": "XX:XX:XX:XX:XX:XX",
        "secure": 4,
        "rssi": -40
      }
    ]
  }
}
```

### LIST_WIFI 

Returns the list of configured wifi in the Lunii 

#### Request

```JSON 
{
  "id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": "1699754392",
  "message" : {
    "command": "LIST_WIFI"
  }
}
```

#### Response

```JSON 
{
  "source_id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": 1699754392,
  "type":0,
  "status":0
}
{
  "source_id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "type": 1,
  "status": 0,
  "timestamp": 1699754392,
  "data": [
    {"bssid":"%s","ssid":"%s"},
    {"bssid":"%s","ssid":"%s"},
    ...
  ]
}
```

### ADD_WIFI

Tries to connect, if success, it adds the network if it was not existing, or it updates the existing one.  

#### Request

```JSON 
{
  "id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": "1699754392",
  "message" : {
    "command" : "ADD_WIFI",
    "ssid"    : "wifi_ssid",
    "bssid"   : "wifi_bssid",
    "password": "wifi_password",
  }
}
```

#### Response

```JSON 
{
  "source_id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": 1699754392,
  "type":0,
  "status":0
}
```

Then the Lunii connect to the Wifi

### REMOVE_WIFI  
Removes a Wifi conf entry based on a BSSID

#### Request

```JSON 
{
  "id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": "1699754392",
  "message" : {
    "command": "REMOVE_WIFI",
    "bssid"  : "wifi_bssid",
  }
}
```

#### Response

```JSON 
{
  "source_id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": 1699754392,
  "type":0,
  "status":0
}
{
  "source_id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": 1699754392,
  "type":1,
  "status":0
}
```

### FACTORY_RESET  
Performs a factory reset

#### Request

```JSON 
{
  "id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": "1699754392",
  "message" : {
    "command": "FACTORY_RESET"
  }
}
```

#### Response

```JSON 
{
  "source_id": "c5c96de5-39d6-4133-8301-b33cd1afa5ac",
  "timestamp": "1699754392",
  "type": "0",
  "status": "0",
}
```

# Backend
## Functions
    backend_authtoken_ready
    backend_pairing_device
    backend_signin
    backend_signout
    backend_synchro
    backend_synchronisation_request
    backend_upload_progress

## Endpoints
    - GET  https://server-backend-prod.lunii.com/user/devices
    - GET  https://server-backend-prod.lunii.com/user/audiobooks
      POST https://server-backend-prod.lunii.com/user/sync/devices/UUID + body items

    - GET https://server-backend-prod.lunii.com/factory/products/_SNU_14_CHARS_ 
    
    - POST https://server-backend-prod.lunii.com/devices/_SNU_14_CHARS_/signin?link=usb + body signin
    - GET  https://server-backend-prod.lunii.com/devices/_SNU_14_CHARS_/signout
    - POST https://server-backend-prod.lunii.com/devices + body snu + body pairingToken
      POST https://server-backend-prod.lunii.com/devices/_SNU_14_CHARS_/audiobooks/ + body items
      GET  https://server-backend-prod.lunii.com/devices/_SNU_14_CHARS_/audiobooks/c4139d59-872a-4d15-8cf1-76d34cdf38c6
      PUT  https://server-backend-prod.lunii.com/devices/_SNU_14_CHARS_/audiobooks/c4139d59-872a-4d15-8cf1-76d34cdf38c6 + body progress
    - GET  https://server-backend-prod.lunii.com/devices/_SNU_14_CHARS_/firmware?installed=3.1.2
      GET  https://server-backend-prod.lunii.com/devices/_SNU_14_CHARS_/avatar
    - GET  https://server-backend-prod.lunii.com/devices/_SNU_14_CHARS_/settings
    - GET  https://server-backend-prod.lunii.com/devices/_SNU_14_CHARS_/boot?command=[RESET, ONBOARDED]
  
(all of them are listed in com.lunii.sdk.feature.backend packages)

### User Info
#### Payload
#### Request
```bash
curl -x socks5://localhost:9050 \
  --header 'Authorization: Bearer eyJ0eXA.USER.TOKEN...' \
  --request GET \
  https://server-backend-prod.lunii.com/user/devices
```

#### Response
```JSON
[
  {
    "id": "....................",
    "name": "Fabrique 1",
    "reference": "LUNII - 2 FR RETAIL",
    "version": "v2",
    "packId": "....................",
    "serialNumber": "0020121234567890",
    "serialNumberTypedByUser": false,
    "illustrationUrl": "/public/images/hardwares/icons/v2.png",
    "createdAt": "2003-06-13T18:10:00.189Z",
    "updatedAt": "2004-06-13T18:10:00.189Z",
    "theme": {
        "name": "green",
        "hardware_color_300": "007371",
        "hardware_color_200": "047B79",
        "hardware_color_100": "038987",
        "hardware_color_50": "CEE6E6"
    },
    "metadata": {
        "deviceId": "....................",
        "vendorId": "0x0483",
        "productId": "0xa341",
        "firmwareVersion": "-1.-1_2.22",
        "sdCardSize": 7939817472,
        "createdAt": "1970-01-01T00:00:00.000Z",
        "updatedAt": "1970-01-01T00:00:00.000Z"
    },
    "associationStatus": "DONE"
  },
]
```  

### Registration
Receive token, ciphered with dev key and sent back to server as JSON data

#### Payload
```JSON
{
  "serialNumber" : "23023031234567",
  "pairingToken" : "XXX_base64_endcode_XXX"
}
```  

#### Request

```bash
curl -x socks5://localhost:9050 \
  --header "Content-Type: application/json" \
  --header "User-Agent: FaHv3"\
  --request POST \
  --data '{"serialNumber" : "23023031234567", "pairingToken" : "XXX_base64_endcode_XXX"}' \ 
  https://server-backend-prod.lunii.com/devices/
```
#### Response

### Sign In 
#### Payload
```JSON
{
    "vendorId": "0x0483",
    "productId": "0xa341",
    "firmwareVersion": "3.1.2",
    "sdCardSize": 1024,
    "sdCardFree": 1000,
    "sdCardUsed": 24,
    "batteryLevel": 95,
    "batteryCharging": false,
    "wifiLevel": 5,
    "wifiSsid": "LUNII_AP"
}
```

#### Request

```bash
    curl -x socks5://localhost:9050 \
      --header "Content-Type: application/json" \
      --header "User-Agent: FaHv3"\
      --request POST \
      --data '{"vendorId": "0x0483", "productId": "0xa341", "firmwareVersion": "3.1.2", "sdCardSize": 1024, "sdCardFree": 1000, "sdCardUsed": 24,"batteryLevel": 95, "batteryCharging": False, "wifiLevel": 5, "wifiSsid": "LUNII_AP"}' \
      https://server-backend-prod.lunii.com/devices/23023031234567/signin
```

#### Response
```bash
    {"challenge":"oMjxuoautvnhMYbJDMcPx2nMmO7T1YRMPP_s9kOxf4w","isUpdateAvailable":false}
    # b64 : oMjxuoautvnhMYbJDMcPx2nMmO7T1YRMPP_s9kOxf4w
    # hex : A0C8F1BA86AEB6F9E13186C90CC70FC769CC98EED3D5844C3CFB3D90EC5FE3
    # txt : lunii: ???????
```

### Sign Out
TBF 

### Audio Books
TBF

# Onboarding

## Process

# Security study

## Ghidra Project

You will find Ghidra archive in this repo. These archives contains all the work performed on understanding, renaming, decompiling the Lunii Firmware.

### How to import
1. Open Ghidra
2. Ensure that there is no active project
3. File / Restore Project
4. Pick `...something.../Flam.RE/ghidra/Flam_2023_MM_DD.gar` in Archive File
5. **Restore Directory** & **Project Name** must be filled automatically with
   * `...something.../Flam.RE/ghidra`
   * `Flam`


# Crypt-Analysis 
[Here](CIPHERING.md)

## Keys
It looks like there is one Story Key that is common to **ALL** Flams.

### Story Key
### Device Key

# Resources

## Internal res

### Bitmaps

### MP3 

## SD structure & Files 

### 1. Very first boot
```
/
+--- .mdf
+--- etc
|   +--- bluetooth
|   |   +--- config
|   |   |   +--- active
|   +--- onboarding
|   |   +--- active
|   +--- wifi
|   |   +--- config
|   |   |   +--- active
+--- test
|   +--- 1000.mp3
|   +--- 1000.mp3map
|   +--- 10000.mp3
|   +--- 10000.mp3map
|   +--- 2750.mp3
|   +--- 400.mp3
|   +--- 400.mp3map
|   +--- 500.mp3
|   +--- 5000.mp3
|   +--- SDCARD.txt
+--- tmp
```
### 2. After sync
```
.
+--- .mdf
+--- etc
|   +--- bluetooth
|   |   +--- config
|   |   |   +--- active
|   +--- library
|   |   +--- list
|   +--- onboarding
|   |   +--- active
|   |   +--- force_update
|   +--- wifi
|   |   +--- config
|   |   |   +--- active
+--- str
|   +--- a6c67c68-2db7-4713-9cf9-0d0e33336bc8
|   |   +--- img
|   |   |   +--- (many images in .lif)
|   |   |   +--- script
|   |   |   |   +--- (menu images in .lif)
|   |   +--- info
|   |   +--- key
|   |   +--- main.lsf
|   |   +--- script
|   |   |   +--- (lsf files)
|   |   +--- sounds
|   |   |   +--- (many .mp3 and .mp3map)
|   |   +--- version
+--- test
|   +--- (10 files)
+--- tmp
|   +--- cable_update_complete
+--- update-comm.enc
+--- update-main.enc
```

### 3. After reboot
```
.
+--- .mdf
+--- etc
|   +--- bluetooth
|   |   +--- config
|   |   |   +--- active
|   +--- library
|   |   +--- list
|   +--- onboarding
|   +--- update
|   +--- wifi
|   |   +--- config
|   |   |   +--- active
+--- str
|   +--- a6c67c68-2db7-4713-9cf9-0d0e33336bc8
|   |   +--- img
|   |   |   +--- (many images in .lif)
|   |   |   +--- script
|   |   |   |   +--- (menu images in .lif)
|   |   +--- info
|   |   +--- key
|   |   +--- main.lsf
|   |   +--- script
|   |   |   +--- (lsf files)
|   |   +--- sounds
|   |   |   +--- (many .mp3 and .mp3map)
|   |   +--- version
+--- test
|   +--- (10 files)
+--- tmp
+--- usr
|   +--- 0
|   |   +--- a6c67c68-2db7-4713-9cf9-0d0e33336bc8
|   |   |   +--- chaps.save
|   |   +--- a6c67c68-2db7-4713-9cf9-0d0e33336bc8.prog
|   |   +--- a6c67c68-2db7-4713-9cf9-0d0e33336bc8.save
```

| File | Key | Contents|
|-|-|-|
|[`sd:0:/.mdf`](#mdf) | ??? | Metadata including two FW versions, SNU, VID / PID, Keys ?
|[`sd:0:/etc/bluetooth/config/active`]() | None | |
|[`sd:0:/etc/bluetooth/config/last_device`]() | None | |
|[`sd:0:/etc/bluetooth/devices/0`]() | None | |
|[`sd:0:/etc/onboarding/force_update`](#etconboardingforce_update) | None | Pending FW update on device |
|[`sd:0:/etc/library/list`](#etclibrarylist) | None | List of all UUID storiez installed |
|[`sd:0:/str`]() | None | Stories storage |
|[`sd:0:/str/UUID_v4`]() | None | All resources for one story |
|[`sd:0:/str/UUID_v4/info`](#struuid_v4info) | Story | Info related the story |
|[`sd:0:/str/UUID_v4/key`](#struuid_v4key) | Device | Auth token for this story on this device |
|[`sd:0:/str/UUID_v4/main.lsf`](#struuid_v4mainlsf) | **Story?** | Initial script to run for story |
|[`sd:0:/str/UUID_v4/version`](#struuid_v4version) | None | A plain text file with a revision number |
|[`sd:0:/str/UUID_v4/img/`](#struuid_v4img) | **None?** | Images resources |
|[`sd:0:/str/UUID_v4/script/`](#struuid_v4scripts) | **Story?** | Interactions resources |
|[`sd:0:/str/UUID_v4/sounds/`](#struuid_v4sounds) | **None?** | Audio resouces |
|[`sd:0:/test`]() | None | Various MP3 at different frequencPies for TestMode |
|[`sd:0:/test`]() | None | Various MP3 at different frequencies for TestMode |
|[`sd:0:/tmp/cable_update_complete`](#tmpcable_update_complete) | None | Related to cable update|
|[`sd:0:/usr/0`]() | None | User story progress for all stories|
|[`sd:0:/usr/0/UUID_v4`]() | None | User story progress for one story |


## Stories Format
### Resources : LIF
???
### Audio : MP3
```
> mediainfo.exe .\00-intro-fr_FR.mp3
General
Complete name                            : .\00-intro-fr_FR.mp3
Format                                   : MPEG Audio
File size                                : 4.29 MiB
Duration                                 : 4 min 40 s
Overall bit rate mode                    : Constant
Overall bit rate                         : 128 kb/s
Encoded by                               : Pro Tools
Recorded date                            : 2023-07-21
Writing library                          : LAME3.100
originator_reference                     : aaO8Q3fCMrPk
umid                                     : 0x060A2B340101010501010F10130000009466705DEAF28000C684538CC0E13E00
time_reference                           : 1587555900

Audio
Format                                   : MPEG Audio
Format version                           : Version 1
Format profile                           : Layer 3
Format settings                          : Joint stereo / MS Stereo
Duration                                 : 4 min 40 s
Bit rate mode                            : Constant
Bit rate                                 : 128 kb/s
Channel(s)                               : 2 channels
Sampling rate                            : 44.1 kHz
Frame rate                               : 38.281 FPS (1152 SPF)
Compression mode                         : Lossy
Stream size                              : 4.29 MiB (100%)
Writing library                          : LAME3.100
```

## Files Format

### .mdf
* **Length** : 0x7E (126B)
* **Key** : plain / device

Structure:  
(to be confirmed, seems to be based on same structure as v3)

  `--- First 64B Block --- PLAIN ---`
``` 
0100 (Static)
6D61696E3A20312E31312E32372D613035386235380A636F
6D6D3A20312E392E382D3035363233363100000000000000 : FW versions (48 Bytes)
                                                   > main: 1.11.27-a058b58
                                                   > comm: 1.9.8-0562361

333030323330343030303132333400000000000000000000 : SNU - Storyteller Unique ID  (24 Bytes)
                                                   > 30023040001234 

3A309E81 : USB Vendor ID / Product ID (8 Bytes)
         > VID 0x3A30, PID 0x9E81
``` 

  `--- Second 48B Block --- CIPHERED ---`  
Contains twice the SNU, ciphered with device key
``` 
    333030323330343030303132333400000000000000000000 : SNU - Storyteller Unique ID  (24 Bytes)
                                                       > 30023040001234 
    333030323330343030303132333400000000000000000000 : SNU - Storyteller Unique ID  (24 Bytes)
                                                       > 30023040001234 
```

### /etc/bluetooth/config/active
* **Length** : variable  
* **Key** : None  
  
This configures the bluetooth module power state. File contents is limited to `true` or `false`.

### /etc/bluetooth/config/last_device
* **Length** : variable  
* **Key** : None  

This file duplicates the last connected device, eventually the first to look for when Flam is started.  
File contents : (refer to [the next section](#etcbluetoothdevices0))

### /etc/bluetooth/devices/0
* **Length** : variable  
* **Key** : None
One file per paired bluetooth device.

File contents
```
BT Headset
3c:54:53:b8:32:a0
```

### /etc/onboarding/force_update
* **Length** : variable  
* **Key** : None

This allows to request Flam to perform update even if firmware is already installed. File contents is limited to `true` or `false`.

### /etc/library/list
* **Length** : variable  
* **Key** : None

This file is the root files that stores all stories available in device. It contains a simple list of UUID formatted as strings, one per line, with LF line endings.
```
C4139D59-872A-4D15-8CF1-76D34CDF38C6
....
123e4567-e89b-12d3-a456-426652340000
```

Each UUIDs match in the stories storage subdirectories `/str`.

### /etc/wifi/config/active
* **Length** : variable  
This configures the wifi module power state. File contents is limited to `true` or `false`.  
**NOTE:** no effect when set to `true`


### /str/UUID_v4/key
* **Length** : 0x20
* **Key** : device specific  
 
  
This file contains the Story keys. It is made of story Key an IV ciphered with Device key

``` C
typedef struct {
    uint key[4];
    uint iv[4];
} story_key;
```

### /str/UUID_v4/info
* **Length** : variable  
* **Key** : story

Contents are still mysterious.  
It might contains Title at least, and maybe Description   

### /str/UUID_v4/main.lsf
* **Length** : Variable
* **Key** : Story?  
  
Initial script to run for story.  
**NOTE :** beginning of file is always the same (some kind of header ?)
``` 
89837DE824CECD37D9F3223E60E296EF : Header ??
XXX...XXX : ciphered contents
``` 

### /str/UUID_v4/version
* **Length** : 0x1 (1B)
* **Key** : plain
This is a plain text file to store the story version

``` 
4
``` 
### /str/UUID_v4/img
* **Length** : variable  
* **Key** : plain

These files store Resources, meaning images in a LIFF format   
``` 
6C696666 : liff header  (4 Bytes)
00000012 00000012 : Image resolution (8 Bytes)
                  > 18 x 18
XXXXXX : Compress data ! LZW ? RLE ?
00000000 00000001 : liff footer ? (8 Bytes)
``` 


**FORMAT DETAILS** : [here](#resources--lif)


### /str/UUID_v4/scripts
* **Length** : variable  
* **Key** : Story?

These files store scripts, TO BE ANALYZED   

**FORMAT DETAILS** : [...]()

### /str/UUID_v4/sounds
* **Length** : variable  
* **Key** : plain

These files store Stories, meaning audio in a MP3 format   

**FORMAT DETAILS** : [here](#audio--mp3)

### /tmp/cable_update_complete
* **Length** : empty  

TBC : This file is created when the Luniistore has finished to write new firmware on device (over USB)

## Story UUIDs

### Full story database
The full list of all existing packs can be extracted from this remote file [packs.json]("https://server-data-prod.lunii.com/v2/packs")

# Links

- https://www