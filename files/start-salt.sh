#!/bin/sh

salt-call --local tls.create_self_signed_cert CN="${HOSTNAME}" && \
	rm -f /var/log/salt/minion

cat > /opt/salt/master.d/01-api.conf << EOF
rest_cherrypy:
  port: 8000
  debug: True
  ssl_crt: /etc/pki/tls/certs/${HOSTNAME}.crt
  ssl_key: /etc/pki/tls/certs/${HOSTNAME}.key
  log_error_file: /opt/log/api-error
  log_access_file: /opt/log/api-access
  debug: True
EOF

/opt/extras/extras.sh useradd

echo
echo "$(python --version)"
cat /root/requirements.txt
echo
echo 'Saltstack:'
echo "    $(salt-master --version)"
echo "    $(salt-syndic --version)"
echo "    $(salt-api --version)"
echo

redis-server /etc/redis/salt.conf
salt-syndic --daemon --config-dir=/opt/salt &
# api_log_file setting does not exist so setting log file here
# 2016.11.6
salt-api --daemon --config-dir=/opt/salt --log-file=/opt/log/api --log-file-level=debug &
salt-master --config-dir=/opt/salt

