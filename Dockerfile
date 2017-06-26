FROM alpine:3.5

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    unicode=YES

COPY requirements.txt .
COPY start-salt.sh /usr/local/bin

RUN set -ex && \
  apk update && \
  apk upgrade && \
  apk add shadow && \
  groupadd --system saltapi && \
  mkdir -p /var/cache/salt/master/ && \
  apk add python2 libzmq libressl libssh2 libgit2 mariadb-libs libcurl ca-certificates zeromq redis && \
  apk add --virtual .build-dependencies curl g++ make swig libffi-dev libressl-dev python2-dev mariadb-dev zeromq-dev && \
  curl -SsLo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
  chmod +x /usr/local/bin/dumb-init && \
  curl -SsLO https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && rm -f get-pip.py && \
  pip --no-cache-dir install --requirement requirements.txt && rm -f requirements.txt && \
  pip freeze > /root/requirements.txt && \
  python -m pip uninstall --yes pip && \
  apk del .build-dependencies ;\
  mkdir -p /etc/pki/tls/certs/ && \
  rm -rf -- /var/cache/apk/* /var/lib/apk/* /etc/apk/cache/* /root/.cache

VOLUME ["/opt/salt", "/opt/log", "/srv/salt"]

EXPOSE 8000 4505 4506

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/local/bin/start-salt.sh"]
