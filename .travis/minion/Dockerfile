FROM travis_saltmaster

LABEL maintainer="Carlos@digitalr00ts.com"

HEALTHCHECK --interval=1m --timeout=3s --start-period=20s --retries=3 \
    CMD salt-call test.ping

VOLUME ['/srv/etc/salt/pki/']

COPY _config/minion /etc/salt/

RUN cd && set -ex && \
  mkdir -p /etc/salt/minion.d/ \
    /srv/etc/salt/minion.d/ \
    /srv/etc/salt/pki/minion

CMD ["salt-minion"]
