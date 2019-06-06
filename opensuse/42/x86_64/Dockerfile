FROM opensuse/leap:42

RUN set -ex; \
    zypper --non-interactive install \
    gcc \
    make \
    python3-devel \
    python3-pip \
    ; \
    zypper clean --all

ENV BUILDBOT_VERSION 1.8.2
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install --only-binary cryptography twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
