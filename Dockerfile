FROM debian:jessie

MAINTAINER Oluwaseun Obajobi "oluwaseun.obajobi@namshi.com"

RUN apt-get update && \
    apt-get install -y exim4-daemon-light && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    find /var/log -type f | while read f; do echo -ne '' > $f; done;

COPY entrypoint.sh /bin/
COPY set-exim4-update-conf /bin/

RUN chgrp -R 0 /bin; \
    chgrp -R 0 /etc/exim4; \
    chmod g+rwX /bin/entrypoint.sh; \
    chmod g+rwX /bin/set-exim4-update-conf

EXPOSE 1025

USER 1001
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["exim", "-bd", "-q15m", "-v"]
