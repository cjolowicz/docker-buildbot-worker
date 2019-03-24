FROM i386/centos:6

RUN set -ex; \
    echo i686 > /etc/yum/vars/arch; \
    echo i386 > /etc/yum/vars/basearch; \
    yum install -y util-linux-ng; \
    yum clean all; \
    set -ex; \
    linux32 yum install -y \
    https://dl.iuscommunity.org/pub/ius/stable/CentOS/6/i386/ius-release-1.0-15.ius.centos6.noarch.rpm; \
    linux32 yum clean all; \
    set -ex; \
    linux32 yum install -y \
    gcc \
    make \
    python36u \
    python36u-devel \
    python36u-pip \
    ; \
    linux32 yum clean all

RUN ln -s /usr/bin/pip3.6 /usr/bin/pip3

ENTRYPOINT ["/usr/bin/linux32"]

ENV BUILDBOT_VERSION 1.8.0
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
