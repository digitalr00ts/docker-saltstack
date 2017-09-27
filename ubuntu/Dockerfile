FROM digitalr00ts/saltstack-base:ubuntu

LABEL maintainer="carlos@digitalr00ts.com"

HEALTHCHECK --interval=1m --timeout=3s --start-period=20s --retries=3 \
    CMD nc -zw 1 localhost 4505 && nc -zw 1 localhost 4506 && test-api || exit 1

EXPOSE 4505 4506 8000

VOLUME ['/etc/salt/pki/']

COPY _files/start-salt.sh /usr/local/bin/start-salt
COPY _files/test-api.py /usr/local/bin/test-api
COPY _config /etc/salt

ARG SALT_VER=latest

RUN cd && set -ex && \
  export INITRD=no && \
  export debian_frontend=noninteractive && \
  apt-get update && \
  apt-get install -y --no-install-recommends wget lsb-release && \
  wget -O - https://repo.saltstack.com/apt/ubuntu/$(lsb_release --release --short)/amd64/${SALT_VER}/SALTSTACK-GPG-KEY.pub | apt-key add - && \
  echo "deb http://repo.saltstack.com/apt/ubuntu/$(lsb_release --release --short)/amd64/${SALT_VER} $(lsb_release --codename --short) main" > /etc/apt/sources.list.d/saltstack.list && \
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
  wget --https-only --no-cache --no-verbose https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && rm -f get-pip.py && \
  pip --no-cache-dir install salt$([ "$SALT_VER" = 'latest' ] || echo "==${SALT_VER}") &&\
  pip list --format=columns > /root/pip-list.txt && \
  python -m pip uninstall --yes pip && \
  \
  apt-get remove -y wget lsb-release && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf -- /tmp/* /var/tmp/* /var/lib/apt/lists/* && \
  rm -f -- /etc/ssh/ssh_host_*

CMD ["/usr/local/bin/start-salt"]
