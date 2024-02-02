import base64
import hexdump
import requests


def auth_getToken(login, pwd, debug = False):
    url1 = "https://server-auth-prod.lunii.com/auth/signin"
    args1 = {'application':"luniistore_mobile",
            'email':login,
            'password':pwd
            }
    auth = requests.post(url1, json = args1)
    token = auth.json()['response']['tokens']['access_tokens']['user']['server']
    user_id = auth.json()['response']['user_id']

    # print("\nToken: {0}".format(token))
    # if debug:
    #     raw = base64.b64decode(token.encode('utf-8') + b'===')
    #     hexdump.hexdump(raw)

    # print("\nUser ID: {0}".format(user_id))
    # if debug:
    #     raw = base64.b64decode(user_id.encode('utf-8') + b'===')
    #     hexdump.hexdump(raw)


    header_auth = {'x-auth-token':auth.json()['response']['tokens']['access_tokens']['user']['server'],
                   'authorization': 'Bearer {0}'.format(auth.json()['response']['tokens']['access_tokens']['user']['server'])
                  }

    return header_auth


def user_getDevices(json_auth, debug=False):
    url2 = "https://server-user-prod.lunii.com/v2/users"
    user = requests.get(url2, headers=json_auth)
    print("\nList of luniis")
    luniis = []

    devices =  user.json()['response'].get('luniis')
    if not devices:
        return luniis
    
    for lun in devices:
        one_lunii = devices[lun]
        # print(one_lunii)
        lunii_serial = one_lunii.get("serial_number", None)
        if lunii_serial:
            luniis.append(lunii_serial)
            print("  - {0}: id: {1}, SNU: {2}, version: {3}".format(one_lunii['name'], lun, lunii_serial, one_lunii['version']))

    return luniis

def prod_getWifiPsk(json_auth, snu, debug=False):
    fw = requests.get(f"https://server-backend-prod.lunii.com/factory/products/{snu}", headers=json_auth)
    print(fw.json())
