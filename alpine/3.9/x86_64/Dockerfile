FROM alpine:3.9

RUN apk add --update --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    python3-dev

ENV BUILDBOT_VERSION 2.0.0
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN adduser -Dh /var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
