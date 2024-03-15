import os
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
import hexdump

BLOCK_SIZE = 16
OUTPUT_DIR = "custom_lsf/"

raw_dev_key = b'\x11\x22....'
raw_dev_iv  = b'\x33\x44....'
key_file = b'\x11..' \
           b'\x22..'


# hexdump.hexdump(raw_dev_key)
# hexdump.hexdump(raw_dev_iv)
# hexdump.hexdump(title)

# print()

def cipher_lua(input_script, title, output_name, output_dir):
    print(f"{input_script:32} >>> {output_name:24} TO: {output_dir}")
    if title:
        os.makedirs(output_dir, exist_ok=True)
        os.makedirs(output_dir + "script/", exist_ok=True)

    # writing key file
    if not os.path.isfile(output_dir + "key"):
        with open(output_dir + "key", "wb") as fp:
            fp.write(key_file)

    # ciphering title in info
    if title:
        aes = AES.new(raw_dev_key, AES.MODE_CBC, raw_dev_iv)
        with open(output_dir + "info", "wb") as fp:
            # prepare bytes for info file
            ciphered = aes.encrypt(pad(title.encode('utf-8'), BLOCK_SIZE))
            fp.write(ciphered)

    # print()
    # hexdump.hexdump(ciphered)


    # ciphering lua file
    if input_script:
        aes = AES.new(raw_dev_key, AES.MODE_CBC, raw_dev_iv)
        with open(input_script, "rb") as fp:
            lua_script = fp.read()
            ciphered = aes.encrypt(pad(lua_script, BLOCK_SIZE))

            with open(output_dir + output_name, "wb") as fp_lsf:
                fp_lsf.write(ciphered)

    # print()
    # hexdump.hexdump(ciphered)

# cipher_lua("custom_scripts/loop_none.lua", "loop_none", "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0001-000000000001/")
# cipher_lua("custom_scripts/loop_100k.lua", "loop_100K", "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0001-000000000002/")
# cipher_lua("custom_scripts/loop_1M.lua",   "loop_1M",   "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0001-000000000003/")
# cipher_lua("custom_scripts/loop_4M.lua",   "loop_4M",   "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0001-000000000004/")
# cipher_lua("custom_scripts/loop_10M.lua",  "loop_10M",  "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0001-000000000005/")
# # OK 👍🏻

# cipher_lua("custom_scripts/file_sd0.lua",           "file_sd0",            "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0002-000000000001/")
# cipher_lua("custom_scripts/file_mount.lua",         "file_mount",          "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0002-000000000002/")
# cipher_lua("custom_scripts/file_io_read.lua",       "file_io_read",        "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0002-000000000003/")
# cipher_lua("custom_scripts/file_file_read.lua",     "file_file_read",      "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0002-000000000004/")
# cipher_lua("custom_scripts/file_all_sd_write.lua",  "file_all_sd_write",   "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0002-000000000005/")
# cipher_lua("custom_scripts/file_all_sd_write2.lua", "file_all_sd_write2",  "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0002-000000000006/")
# cipher_lua("custom_scripts/file_flash.lua",         "file_flash",          "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0002-000000000007/")
# # FAIL FAIL

# cipher_lua("custom_scripts/api_file_open.lua",  "api_file_open", "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0003-000000000001/")
# cipher_lua("custom_scripts/api_io_open.lua",    "api_io_open",   "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0003-000000000002/")
# # FAIL FAIL
# cipher_lua("custom_scripts/api_file_lfs.lua",   "api_file_lfs",  "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0003-000000000003/")
# # FAIL FAIL
            
# cipher_lua("custom_scripts/req_crypto.lua",   "req_crypto",    "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000001/")
# cipher_lua("custom_scripts/req_file_lfs.lua", "req_file_lfs",  "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000002/")
# cipher_lua("custom_scripts/req_file.lua",     "req_file",      "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000003/")
# cipher_lua("custom_scripts/req_node.lua",     "req_node",      "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000004/")
# cipher_lua("custom_scripts/req_telnet.lua",   "req_telnet",    "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000005/")
# cipher_lua("custom_scripts/req_uart.lua",     "req_uart",      "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000006/")
# cipher_lua("custom_scripts/req_wifi.lua",     "req_wifi",      "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000007/")
# # ALL FAIL FAIL
# cipher_lua("custom_scripts/req_none.lua",     "req_none",      "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000008/")
# # OK
cipher_lua("custom_scripts/ref_mytimer.lua",  "noreq mytimer",  "main.lsf",     OUTPUT_DIR+"00000000-0000-0000-0004-000000000009/")

cipher_lua("custom_scripts/req_mytimer.lua",  "req_mytimer",  "main.lsf",     OUTPUT_DIR+"00000000-0000-0000-0004-000000000010/")
cipher_lua("custom_scripts/my-timer.lua",     None,           "my-timer.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000010/")

cipher_lua("custom_scripts/req_mytimer.lua",  "req_mytimer2", "main.lsf",     OUTPUT_DIR+"00000000-0000-0000-0004-000000000011/")
cipher_lua("custom_scripts/my-timer.lua",     None,           "script/my-timer.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000011/")

cipher_lua("custom_scripts/req_gtimer.lua",   "req_gtimer",   "main.lsf",          OUTPUT_DIR+"00000000-0000-0000-0004-000000000012/")
cipher_lua("custom_scripts/my-timer.lua",     None,           "script/global.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000012/")

cipher_lua("custom_scripts/req_gtimer.lua",   "req_gtimer2",  "main.lsf",          OUTPUT_DIR+"00000000-0000-0000-0004-000000000013/")
cipher_lua("custom_scripts/my-timer.lua",     None,           "script/global.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000013/")

# cipher_lua("custom_scripts/node_info.lua",    "node_info",     "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0005-000000000001/")
# # FAIL FAIL

# cipher_lua("custom_scripts/wifi_noconnect.lua",   "wifi_noconnect",   "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0006-000000000001/")
# # OK
# cipher_lua("custom_scripts/wifi_connect.lua",     "wifi_connect",     "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0006-000000000002/")
# cipher_lua("custom_scripts/wifi_connect_x10.lua", "wifi_connect_x10", "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0006-000000000003/")
# # FAIL FAIL

# cipher_lua("custom_scripts/XXXX.lua", "XXXX", "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000001/")
