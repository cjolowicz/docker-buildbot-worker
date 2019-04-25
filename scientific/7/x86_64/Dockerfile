FROM scientificlinux/sl:7

RUN set -ex; \
    yum install -y \
    epel-release; \
    yum clean all; \
    set -ex; \
    yum install -y \
    gcc \
    make \
    python36-devel \
    python36-pip \
    ; \
    yum clean all

ENV BUILDBOT_VERSION 2.2.0
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
