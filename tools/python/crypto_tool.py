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


def pad_zero(buffer:bytearray):
    pad_len = (BLOCK_SIZE - len(buffer) % BLOCK_SIZE) % BLOCK_SIZE
    return buffer + (b'\x00' * pad_len)


def cipher_lua(input_script, title, output_name, output_dir):
    print(f"{input_script:32} >>> {output_name:24} TO: {output_dir}")
    if title:
        os.makedirs(output_dir, exist_ok=True)
    if not title:
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
            title += "\n"
            ciphered = aes.encrypt(pad_zero(title.encode('utf-8')))
            fp.write(ciphered)

    # print()
    # hexdump.hexdump(ciphered)


    # ciphering lua file
    if input_script:
        aes = AES.new(raw_dev_key, AES.MODE_CBC, raw_dev_iv)
        with open(input_script, "rb") as fp:
            lua_script = fp.read()
            ciphered = aes.encrypt(pad_zero(lua_script))

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
                
# cipher_lua("custom_scripts/ref_mytimer.lua",  "noreq mytimer",  "main.lsf",     OUTPUT_DIR+"00000000-0000-0000-0004-000000000009/")

# cipher_lua("custom_scripts/req_mytimer.lua",  "req_mytimer",  "main.lsf",     OUTPUT_DIR+"00000000-0000-0000-0004-000000000010/")
# cipher_lua("custom_scripts/my-timer.lua",     None,           "my-timer.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000010/")

# cipher_lua("custom_scripts/req_mytimer.lua",  "req_mytimer2", "main.lsf",     OUTPUT_DIR+"00000000-0000-0000-0004-000000000011/")
# cipher_lua("custom_scripts/my-timer.lua",     None,           "script/my-timer.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000011/")

# cipher_lua("custom_scripts/req_gtimer.lua",   "req_gtimer",   "main.lsf",          OUTPUT_DIR+"00000000-0000-0000-0004-000000000012/")
# cipher_lua("custom_scripts/my-timer.lua",     None,           "global.lsf",        OUTPUT_DIR+"00000000-0000-0000-0004-000000000012/")

# cipher_lua("custom_scripts/req_gtimer.lua",   "req_gtimer2",  "main.lsf",          OUTPUT_DIR+"00000000-0000-0000-0004-000000000013/")
# cipher_lua("custom_scripts/my-timer.lua",     None,           "script/global.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000013/")
# ALL FAIL FAIL

# cipher_lua("custom_scripts/node_info.lua",    "node_info",     "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0005-000000000001/")
# # FAIL FAIL

# cipher_lua("custom_scripts/wifi_noconnect.lua",   "wifi_noconnect",   "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0006-000000000001/")
# # OK
# cipher_lua("custom_scripts/wifi_connect.lua",     "wifi_connect",     "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0006-000000000002/")
# cipher_lua("custom_scripts/wifi_connect_x10.lua", "wifi_connect_x10", "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0006-000000000003/")
# # FAIL FAIL

# cipher_lua("custom_lua/white_timer6s.lua", "Timer 6s", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000001/")
# cipher_lua("custom_lua/white_timer12s.lua", "Timer 12s", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000002/")
# cipher_lua("custom_lua/white_timers.lua", "Timers", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000003/")
# # OK
# cipher_lua("custom_lua/white_test2.lua", "fileExists no call", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000004/")
# cipher_lua("custom_lua/white_test3.lua", "fileExists test.txt", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000005/")
# cipher_lua("custom_lua/white_test4.lua", "fileExists on prog all SDs", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000006/")
# cipher_lua("custom_lua/white_test5.lua", "UART setup", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000007/")
# cipher_lua("custom_lua/white_test6.lua", "UART write hello", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000008/")
# cipher_lua("custom_lua/white_test7.lua", "UART 0 write hello", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000009/")
# cipher_lua("custom_lua/white_test8.lua", "os.loglevel", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000010/")
# cipher_lua("custom_lua/white_test9.lua", "os.loglevel + os.logcons", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000011/")
# cipher_lua("custom_lua/white_test10.lua", "os.version", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0001-000000000012/")
# # FAIL FAIL


# cipher_lua("custom_lua/flam_fn1.lua", "Math Floor", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0002-000000000001/")
# cipher_lua("custom_lua/flam_fn2.lua", "Progression Load", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0002-000000000002/")
# cipher_lua("custom_lua/flam_fn3.lua", "Prog Save", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0002-000000000003/")
# cipher_lua("custom_lua/flam_fn4.lua", "Prog Save file", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0002-000000000004/")
# cipher_lua("custom_lua/flam_fn5.lua", "Prog Save multiple", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0002-000000000005/")
# # OK
# cipher_lua("custom_lua/flam_fn6.lua", "Prog Save simple", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0002-000000000006/")
# # FAIL FAIL
cipher_lua("custom_lua/flam_fn7.lua", "Load Image", "main.lsf", OUTPUT_DIR+"00000000-0000-0001-0002-000000000007/")

cipher_lua("custom_lua/flam_dump1_ref.lua", "Dump package loaded (fake)", "main.lsf", OUTPUT_DIR+"00000000-0000-FFFF-0001-000000000001/")
cipher_lua("custom_lua/flam_dump1.lua", "Dump package loaded", "main.lsf", OUTPUT_DIR+"00000000-0000-FFFF-0001-000000000002/")
cipher_lua("custom_lua/flam_dump2.lua", "Dump state", "main.lsf", OUTPUT_DIR+"00000000-0000-FFFF-0001-000000000003/")
cipher_lua("custom_lua/flam_dump3.lua", "Dump Global", "main.lsf", OUTPUT_DIR+"00000000-0000-FFFF-0001-000000000004/")

# cipher_lua("custom_scripts/XXXX.lua", "XXXX", "main.lsf", OUTPUT_DIR+"00000000-0000-0000-0004-000000000001/")

