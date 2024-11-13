FROM alpine:3.20.3

RUN apk update && \
    apk add rsyslog && \
    rm -rf /var/cache/apk/*

COPY rsyslog.conf /etc/rsyslog.conf

EXPOSE 1514/tcp

CMD ["rsyslogd", "-n"]
