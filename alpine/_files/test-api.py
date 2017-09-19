#!/usr/bin/env python

import requests
import sys

requests.packages.urllib3.disable_warnings(
    requests.packages.urllib3.exceptions.InsecureRequestWarning)
ret = requests.get('https://localhost:8000/', verify=False)

if ret.json().get('return', '') != 'Welcome':
    sys.exit('API check failed')
