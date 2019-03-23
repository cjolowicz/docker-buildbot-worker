FROM debian:jessie

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-pip \
    ; \
    rm -rf /var/lib/apt/lists/*

ENV BUILDBOT_VERSION 1.8.0
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
