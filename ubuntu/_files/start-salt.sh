#!/bin/sh

salt-call --local tls.create_self_signed_cert -l error && \
	rm -f /var/log/salt/minion

echo
echo "$(python --version)"
cat /root/pip-list.txt
echo
echo 'Saltstack:'
echo "    $(salt-master --version)"
echo "    $(salt-syndic --version)"
echo "    $(salt-api --version)"
echo

salt --versions-report

salt-syndic --daemon &
# api_log_file setting does not exist so setting log file here
# 2016.11.6
salt-api --daemon --log-file=/etc/log/salt/api --log-file-level=debug &
salt-master

