#!/usr/bin/env python

from lunii_backend import *

# login = sys.argv[1]
# pwd = sys.argv[2]

def get_luniis():
    auth = auth_getToken(login, pwd)
    devices = user_getDevices(auth)

def get_wifiPsk():
    auth = auth_getToken(login, pwd)
    prod_getWifiPsk(auth, "30023040001234")

if __name__ == '__main__':
    # get_luniis()
    get_wifiPsk()
    # get_audioBooks()
    # get_allCmd()
    # get_settings()
    # get_update()
    # session()
    # start_pairing()