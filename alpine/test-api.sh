#!/bin/sh

curl -sSk https://localhost:8000/login -H 'Accept: application/json' -d username=saltdev -d password=saltdev -d eauth=pam
