FROM ubuntu:latest

LABEL maintainer="carlos@digitalr00ts.com"

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    unicode=YES

RUN cd && set -ex && \
  export INITRD=no && \
  export debian_frontend=noninteractive && \
  \
  dpkg-divert --local --rename --add /sbin/initctl && \
  ln -sf /bin/true /sbin/initctl && \
  dpkg-divert --local --rename --add /usr/bin/ischroot && \
  ln -sf /bin/true /usr/bin/ischroot && \
  \
  apt-get update && \
  apt-get install -y --no-install-recommends language-pack-en && \
  locale-gen en_US && \
  update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 && \
  apt-get install -y --no-install-recommends apt-transport-https ca-certificates && \
  apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold" && \
  \
  apt-get install -y --no-install-recommends wget \
  # salt-common
  python-dateutil python-jinja2 python-msgpack python-pkg-resources python-requests python-tornado python-yaml python-systemd python-psutil python \
  # salt-master
  python-crypto python-zmq && \
  \
  wget --https-only --no-cache --no-verbose https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && rm -f get-pip.py && \
  pip --no-cache-dir install pyopenssl salt && \
  #-r /root/requirements.txt && \
  #rm -f /root/requirements.txt && \
  pip list --format=columns > /root/pip-list.txt && \
  python -m pip uninstall --yes pip && \
  wget --https-only --no-cache --no-verbose https://github.com/krallin/tini/releases/download/v0.16.1/tini_0.16.1-amd64.deb && \
  wget --https-only --no-cache --no-verbose https://github.com/krallin/tini/releases/download/v0.16.1/tini_0.16.1-amd64.deb.asc && \
  gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
  gpg --verify tini_0.16.1-amd64.deb.asc && \
  dpkg -i tini_0.16.1-amd64.deb && \
  rm -f -- tini_0.16.1-amd64.deb.asc tini_0.16.1-amd64.deb && \
  apt-get remove -y wget && \
  apt-get autoremove -y && \
  \
  apt-get clean && \
  rm -rf -- /tmp/* /var/tmp/* /var/lib/apt/lists/* && \
  rm -f -- /etc/ssh/ssh_host_*

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]

