FROM alpine:3.6

COPY requirements.txt .
COPY start-salt.sh /usr/bin

RUN set -ex && \
  apk update && \
  apk upgrade && \
  apk add shadow && \
  groupadd --system salt && \
  useradd --no-create-home --no-user-group --shell /sbin/nologin --gid salt --password '$6$wJCko5Bc$.SN0uWuO5yjaQHZbxX.gJ0o1h.cljyv9VBcbpSAGqU6IErmyK4AWJkhlg0QCrUhrBXTQ1.JzgTPkcqqkfOgLs/' saltdev && \
  apk add python2 libzmq libressl libssh2 libgit2 mariadb-libs libcurl ca-certificates && \
  apk add --virtual .build-dependencies curl g++ make swig libffi-dev libressl-dev python2-dev mariadb-dev && \
  curl -LO https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && rm -f get-pip.py && \
  pip --no-cache-dir install --requirement requirements.txt && rm -f requirements.txt && \
  pip freeze > /root/requirements.txt && \
  python -m pip uninstall --yes pip && \
  apk del .build-dependencies ;\
  mkdir -p /etc/pki/tls/certs/ && \
  rm -rf -- /var/cache/apk/* /var/lib/apk/* /etc/apk/cache/* /root/.cache

VOLUME ["/opt/salt", "/opt/log", "/srv/salt"]

EXPOSE 8000 4505 4506

ENTRYPOINT ["start-salt.sh"]
