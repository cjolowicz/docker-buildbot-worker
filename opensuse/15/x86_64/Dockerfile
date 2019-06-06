FROM opensuse/leap:15

RUN set -ex; \
    zypper --non-interactive install \
    gcc \
    make \
    python3-devel \
    python3-pip \
    ; \
    zypper clean --all

ENV BUILDBOT_VERSION 2.3.0
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
