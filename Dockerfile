FROM debian:jessie

MAINTAINER Oluwaseun Obajobi "oluwaseun.obajobi@namshi.com"

RUN apt-get update && \
    apt-get install -y exim4-daemon-light && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    find /var/log -type f | while read f; do echo -ne '' > $f; done;

COPY entrypoint.sh /bin/
COPY set-exim4-update-conf /bin/

RUN chown 1001:1001 /bin; \
    chown 1001:1001 /bin/*; \
    chown 1001:1001 /etc/exim4; \
    chown 1001:1001 /etc/exim4/*; \
    chmod +x /bin/entrypoint.sh; \
    chmod +x /bin/set-exim4-update-conf

EXPOSE 1025

USER 1001
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["exim", "-bd", "-q15m", "-v"]
