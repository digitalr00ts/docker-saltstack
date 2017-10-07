FROM digitalr00ts/saltstack-base:ubuntu

LABEL maintainer="carlos@digitalr00ts.com"

ARG SALT_VER=latest

HEALTHCHECK --interval=1m --timeout=3s --start-period=20s --retries=3 \
    CMD nc -zw 1 localhost 4505 && nc -zw 1 localhost 4506 && test-api || exit 1

EXPOSE 4505 4506 8000

VOLUME ['/etc/salt/pki/']

RUN cd && set -ex && \
  mkdir -p /srv/etc/salt/master.d/ && mkdir -p /srv/etc/salt/pki/ && \
  mkdir -p /srv/etc/salt/ssh.d/ && \
  mkdir -p /srv/salt/ && mkdir /srv/pillar/ && \
  mkdir -p /etc/salt/ && \
  mkdir -p /var/cache/salt/master/ && \
  export INITRD=no && \
  export debian_frontend=noninteractive && \
  apt-get update && \
  apt-get install -y --no-install-recommends wget lsb-release && \
  wget --https-only --no-cookies --no-cache --no-verbose -O - \
    https://repo.saltstack.com/apt/ubuntu/$(lsb_release --release --short)/amd64/${SALT_VER}/SALTSTACK-GPG-KEY.pub | apt-key add - && \
  echo "deb http://repo.saltstack.com/apt/ubuntu/$(lsb_release --release --short)/amd64/${SALT_VER} $(lsb_release --codename --short) main" \
    > /etc/apt/sources.list.d/saltstack.list && \
  wget --https-only --no-cookies --no-cache --no-verbose \
    https://github.com/digitalr00ts/docker-saltstack/raw/develop/_files/requirements.txt && \
  wget --https-only --no-cookies --no-cache --no-verbose \
    https://github.com/digitalr00ts/docker-saltstack/raw/develop/_config/master && \
    mv master /etc/salt/ && \
  wget --https-only --no-cookies --no-cache --no-verbose \
    https://github.com/digitalr00ts/docker-saltstack/raw/develop/_files/start-salt.sh && \
    chmod +x start-salt.sh && mv start-salt.sh /usr/local/bin/start-salt && \
  wget --https-only --no-cookies --no-cache --no-verbose \
    https://github.com/digitalr00ts/docker-saltstack/raw/develop/_files/test-api.py && \
    chmod +x test-api.py && mv test-api.py /usr/local/bin/test-api && \
  apt-get update && \
  \
  apt-get install -y --no-install-recommends \
  # salt-common #
  python-tornado \
  # salt-master #
  python-zmq \
  # salt-cloud #
  python-libcloud \
  && \
  wget --https-only --no-cookies --no-cache --no-verbose https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && rm -f get-pip.py && \
  pip --no-cache-dir install salt$([ "$SALT_VER" = 'latest' ] || echo "==${SALT_VER}") &&\
  pip --no-cache-dir install -r requirements.txt && \
  rm -f /root/requirements.txt && \
  pip list --format=columns > /root/pip-list.txt && \
  python -m pip uninstall --yes pip && \
  \
  apt-get remove -y wget lsb-release && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf -- /tmp/* /var/tmp/* /var/lib/apt/lists/* && \
  rm -f -- /etc/ssh/ssh_host_*

CMD ["/usr/local/bin/start-salt"]
