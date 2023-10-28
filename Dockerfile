FROM alpine:latest

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.15/main ca-certificates curl

RUN apk add --no-cache \
    jq

ENTRYPOINT ["/bin/sh"]