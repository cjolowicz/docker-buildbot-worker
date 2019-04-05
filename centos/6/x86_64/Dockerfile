FROM centos:6

RUN set -ex; \
    yum install -y \
    https://centos6.iuscommunity.org/ius-release.rpm; \
    yum clean all; \
    set -ex; \
    yum install -y \
    gcc \
    make \
    python36u \
    python36u-devel \
    python36u-pip \
    ; \
    yum clean all

RUN ln -s /usr/bin/pip3.6 /usr/bin/pip3

ENV BUILDBOT_VERSION 1.8.1
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
