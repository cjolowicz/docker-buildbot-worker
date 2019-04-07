ENV BUILDBOT_VERSION 1.8.1
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN m4_ifelse(
    PLATFORM, alpine,
    adduser -Dh /var/lib/buildbot buildbot,
    useradd --create-home --home-dir=/var/lib/buildbot buildbot)
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

VOLUME /var/lib/buildbot
CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
