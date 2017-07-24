FROM digitalr00ts/ubuntu:16.04

ENV LC_ALL=C.UTF-8 \
    SALT_VER=latest

COPY files/requirements.txt .
COPY files/start-salt.sh /usr/local/bin

RUN set -ex ;\
  export DEBIAN_FRONTEND=noninteractive ;\
  mkdir -p /etc/salt/pki && mkdir -p /var/cache/salt/master/ &&\
  apt-get update && apt-get -o Dpkg::Options::='--force-confold' --force-yes --yes upgrade &&\
  apt -o Dpkg::Options::='--force-confold' --force-yes --yes install --no-install-recommends curl \
    python2.7-minimal libpython2.7-minimal zlib1g \
    python-dateutil python-jinja2 python-msgpack python-pkg-resources python-requests python-tornado python-yaml python-psutil python-crypto python-zmq \
    python-cffi python-cherrypy3 python-git python-m2crypto python-mysqldb python-gnupg &&\
  curl -SsLo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 &&\
  chmod +x /usr/local/bin/dumb-init &&\
  curl -SsLO https://bootstrap.pypa.io/get-pip.py &&\
  python get-pip.py && rm -f get-pip.py &&\
  pip --no-cache-dir install salt$([ "$SALT_VER" = 'latest' ] || echo "==${SALT_VER}") &&\
  pip --no-cache-dir install --requirement requirements.txt && rm -f requirements.txt &&\
  pip freeze > /root/requirements.txt &&\
  python -m pip uninstall --yes pip &&\
  mkdir -p /etc/pki/tls/certs/ &&\
  echo 'default_include: /opt/salt/master.d/*.conf' > /etc/salt/master &&\
  apt --yes purge curl &&\
  apt clean &&\
  rm -rf -- /var/lib/apt/lists/* ;\
  find /var/log/ -type f -exec rm -f {} \; ;\
  rm -rf -- /root/.cache ; rm -f /root/.bash_history

VOLUME ["/opt/salt", "/opt/log", "/srv/salt"]

EXPOSE 8000 4505 4506

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/local/bin/start-salt.sh"]
