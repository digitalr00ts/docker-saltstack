FROM digitalr00ts/saltstack-base:latest

LABEL maintainer="Carlos@digitalr00ts.com"

ARG SALT_VER=latest

HEALTHCHECK --interval=1m --timeout=3s --start-period=20s --retries=3 \
    CMD nc -zw 1 localhost 4505 && nc -zw 1 localhost 4506 && test-api || exit 1

EXPOSE 4505 4506 8000

VOLUME ['/etc/salt/pki/']

COPY _config /etc/salt

RUN cd && set -ex && \
  mkdir -p /etc/salt/ && mkdir -p /var/cache/salt/master/ && \
  apk --no-cache add --virtual .build-dependencies curl gcc musl-dev libffi-dev libressl-dev python2-dev zeromq-dev curl-dev && \
  curl -SsLO https://github.com/digitalr00ts/docker-saltstack/raw/dev/alpine/_files/requirements.txt && \
  curl -SsLO https://bootstrap.pypa.io/get-pip.py && \
  cd /usr/local/bin/ && \
  curl -SsLO https://github.com/digitalr00ts/docker-saltstack/raw/dev/_files/start-salt.sh && \
  curl -SsLO https://github.com/digitalr00ts/docker-saltstack/raw/dev/_files/test-api.py && \
  cd && \
  python get-pip.py && rm -f get-pip.py && \
  pip --no-cache-dir install salt$([ "$SALT_VER" = 'latest' ] || echo "==${SALT_VER}") &&\
  pip --no-cache-dir install -r requirements.txt && \
  rm -f /root/requirements.txt && \
  pip list --format=columns > /root/pip-list.txt && \
  python -m pip uninstall --yes pip && \
  apk del .build-dependencies ;\
  rm -rf -- /var/cache/apk/* /var/lib/apk/* /etc/apk/cache/* /root/.cache

CMD ["/usr/local/bin/start-salt"]
