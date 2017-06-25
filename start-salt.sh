#!/bin/sh

# subj="
# C=US
# ST=UT
# O=Salt Stack, Inc.
# localityName=Lehi
# commonName=*
# "

# openssl req -batch \
# 	-subj "$(echo -n "$subj" | tr "\n" "/")" \
# 	-x509 -sha256 -days 365 -out /etc/pki/tls/certs/localhost.crt \
# 	-newkey rsa:2048 -nodes -keyout /etc/pki/tls/certs/localhost.key

salt-call --local tls.create_self_signed_cert && \
	rm -f /var/log/salt/minion

echo
echo "$(python --version)"
cat /root/requirements.txt
echo
echo 'Saltstack:'
echo "    $(salt-master --version)"
echo "    $(salt-syndic --version)"
echo "    $(salt-api --version)"
echo

# api_log_file setting does not exist so setting log file here
# 2016.11.6
salt-api --daemon --config-dir=/opt/salt --log-file=/opt/log/api --log-file-level=debug
salt-syndic --daemon --config-dir=/opt/salt
salt-master --config-dir=/opt/salt

