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
    ; \
    linux32 yum clean all

ENTRYPOINT ["/usr/bin/linux32"]

ENV PYTHON_PIP_VERSION 19.1.1

RUN set -ex; \
    cd /usr/local/src; \
    curl -LO 'https://bootstrap.pypa.io/get-pip.py'; \
    python3 get-pip.py \
        --disable-pip-version-check \
        --no-cache-dir \
        "pip==$PYTHON_PIP_VERSION" \
    ; \
    pip --version; \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' + \
    ; \
    rm -f get-pip.py

ENV BUILDBOT_VERSION 2.3.1
RUN pip --no-cache-dir install --only-binary cryptography twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
