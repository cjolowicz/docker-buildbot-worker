FROM i386/ubuntu:14.04

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    ; \
    rm -rf /var/lib/apt/lists/*

ENV BUILDBOT_VERSION 2.5.0
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install --only-binary cryptography twisted[tls]==19.2 && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
