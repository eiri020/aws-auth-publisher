FROM alpine:latest

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.15/main ca-certificates curl

RUN apk add --no-cache \
    jq \
    git \
    socat \
    bash

RUN mkdir /aws-auth-publisher

WORKDIR /aws-auth-publisher

RUN mkdir .aws
RUN touch .aws/credentials

RUN git clone https://github.com/albfan/bash-ini-parser.git
RUN git clone https://github.com/yurikoex/bash-rest-server.git

COPY routes/ routes/
COPY *.sh .
COPY config .

RUN find . -name "*.sh" -exec chmod 755 {} \;

ENTRYPOINT [ "/bin/bash", "-c", "/aws-auth-publisher/index.sh" ]
