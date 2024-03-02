from pathlib import Path
import shutil
import hexdump
import os.path

LUA_SCRIPT = "./original_scripts/global.lsf"
KEY_DATA =  b'\x11\x22....' \
            b'\x33\x44....'

CHUNK_SIZE = 0x10
INFO_SIZE = 0x80
ROOT_DIR = "./dump_dirs"
BASE_DIR = ROOT_DIR + "/00000000-dead-0000-0000-00000000"

# cleanup output dirs
shutil.rmtree(ROOT_DIR)

# let's go
with open(LUA_SCRIPT, "rb") as fp:
    lua_data = fp.read()

    chunk_num = 0
    while chunk_num * CHUNK_SIZE < len(lua_data):
        print(f"Chunk {chunk_num:4}")
        # litlle bit further
        chunk = lua_data[chunk_num*CHUNK_SIZE:]
        # keeping only INFO_SIZE or less
        if len(chunk) > INFO_SIZE:
            chunk = chunk[:INFO_SIZE]

        hexdump.hexdump(chunk)
        print()

        # create new directory
        chunk_dir = Path(f"{BASE_DIR}{chunk_num:04}")
        chunk_dir.mkdir(parents=True)
        # create key file
        key_file = chunk_dir.joinpath("key")
        with open(key_file, "wb") as fp:
            fp.write(KEY_DATA)
        # create info file with chunk
        info_file = chunk_dir.joinpath("info")
        with open(info_file, "wb") as fp:
            fp.write(chunk)

        # next chunk pos
        chunk_num += 1