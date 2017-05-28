#!/usr/bin/env python3
#
#   I wrote this because I needed a script to get the IP address of systems
#   that do not update the dns server properly. The script will be ran five
#   minutes after boot and output will be redirected to a text file that is 
#   stored in a dropbox folder.

import socket

def get_ip_address():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    address = s.getsockname()[0]
    s.close()
    return address

print(get_ip_address())

