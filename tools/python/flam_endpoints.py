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

def add_audioBooks():
    auth = auth_getToken(login, pwd)

    user_addBundleFree(auth, "sqdfmkljeazrpiuisd", "-DA7_EmilyBimzqXPaWZ")
    user_addBundleFree(auth, "sqdfmkljeazrpiuisd", "-DA7_micro4IERQMdLbP")

def get_audioBooks():
    auth = auth_getToken(login, pwd)
    user_getAudioBooks(auth, "sqdfmkljeazrpiuisd")

def get_FlamTypes():
    auth = auth_getToken(login, pwd)
    # prod_getResources(auth, "LUN7P_01_FR_STD")
    # prod_getResources(auth, "LUNII - 2 FR RETAIL")

    CURRENT_SNU = 30023040000000
    
    for i in range(3722, 10000):
        one_SNU = "{:d}".format(CURRENT_SNU + i)

        print(one_SNU, end="\r")
        reftype, version = prod_getType(auth, one_SNU)
        if reftype != "LUN7P_01_FR_STD":
            print("\n" + reftype + " - " + version)
            # prod_getResources(auth, reftype)
    print(one_SNU)


if __name__ == '__main__':
    # add_audioBooks()
    # get_audioBooks()
    get_FlamTypes()
    
    # get_luniis()
    # get_wifiPsk()
    # get_allCmd()
    # get_settings()
    # get_update()
    # session()
    # start_pairing()