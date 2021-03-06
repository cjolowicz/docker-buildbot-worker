ENV BUILDBOT_VERSION M4_BUILDBOT_VERSION
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install m4_ifelse(
        PLATFORM RELEASE, centos 5,
        --only-binary cryptography ,
        PLATFORM RELEASE, centos 6,
        --only-binary cryptography ,
        PLATFORM ARCH, debian i386,
        --only-binary cryptography ,
        PLATFORM ARCH, ubuntu i386,
        --only-binary cryptography )m4_ifelse(
        PLATFORM RELEASE, opensuse 13,
        twisted[tls]==19.2,
        PLATFORM RELEASE, opensuse 42,
        twisted[tls]==19.2,
        PLATFORM RELEASE, debian 8,
        twisted[tls]==19.2,
        PLATFORM RELEASE, ubuntu 14.04,
        twisted[tls]==19.2,
        twisted[tls]) && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN m4_ifelse(
    PLATFORM, alpine,
    adduser -Dh /var/lib/buildbot buildbot,
    useradd --create-home --home-dir=/var/lib/buildbot buildbot)
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
