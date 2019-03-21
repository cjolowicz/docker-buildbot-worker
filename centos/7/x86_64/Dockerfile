FROM centos:7

RUN set -ex; \
    yum -y install \
        https://centos7.iuscommunity.org/ius-release.rpm \
    ; \
    yum -y install \
        gcc \
        make \
        python36u \
        python36u-pip \
        python36u-devel \
    ; \
    yum clean all

RUN ln -s /usr/bin/pip3.6 /usr/bin/pip3

ENV BUILDBOT_VERSION 1.8.0
RUN pip3 --no-cache-dir install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]