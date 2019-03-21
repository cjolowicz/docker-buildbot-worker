FROM i386/debian:wheezy

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        curl \
        gcc \
        make \
        libc6-dev \
        patch \
        perl \
        zlib1g-dev \
    ; \
    rm -rf /var/lib/apt/lists/*

ENV OPENSSL_VERSION 1.1.1b
ENV OPENSSL_DIR /usr/local/ssl

RUN set -ex; \
    cd /usr/local/src; \
    curl https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz -LO; \
    tar -xf openssl-$OPENSSL_VERSION.tar.gz; \
    rm -f openssl-$OPENSSL_VERSION.tar.gz; \
    cd openssl-$OPENSSL_VERSION; \
    ./Configure -m32 linux-generic32 \
        --prefix=$OPENSSL_DIR \
        --openssldir=$OPENSSL_DIR \
        shared \
        zlib \
        enable-egd  \
    ; \
    make -j "$(nproc)"; \
    make install_sw; \
    cd ..; \
    rm -rf openssl-$OPENSSL_VERSION; \
    echo $OPENSSL_DIR/lib > /etc/ld.so.conf.d/openssl-$OPENSSL_VERSION.conf; \
    ldconfig -v; \
    $OPENSSL_DIR/bin/openssl version -a

ENV PATH $OPENSSL_DIR/bin:$PATH
ENV PKG_CONFIG_PATH $OPENSSL_DIR/lib/pkgconfig

ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libbz2-dev \
        libc6-dev \
        libdb-dev \
        libexpat-dev \
        libffi-dev \
        libgdbm-dev \
        liblzma-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libz-dev \
        tk-dev \
        uuid-dev \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHON_VERSION 3.7.2

# https://stackoverflow.com/questions/5937337
COPY python-use-local-openssl.patch /usr/local/src

RUN set -ex; \
    curl --insecure -LO "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz"; \
    tar -xJC /usr/local/src -f Python-$PYTHON_VERSION.tar.xz; \
    rm Python-$PYTHON_VERSION.tar.xz; \
    cd /usr/local/src/Python-$PYTHON_VERSION; \
    patch -p1 < ../python-use-local-openssl.patch; \
    ./configure \
        --enable-loadable-sqlite-extensions \
        --enable-shared \
        --with-system-expat \
        --with-system-ffi \
        --without-ensurepip \
        CPPFLAGS="$(pkg-config --cflags openssl) -Wl,-R$OPENSSL_DIR/lib" \
        LDFLAGS="$(pkg-config --libs openssl) -Wl,-R$OPENSSL_DIR/lib" \
    ; \
    make -j "$(nproc)"; \
    make install; \
    ldconfig; \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' + \
    ; \
    rm -rf /usr/local/src/Python-$PYTHON_VERSION; \
    python3 --version

RUN set -ex; \
    cd /usr/local/bin; \
    ln -s idle3 idle; \
    ln -s pydoc3 pydoc; \
    ln -s python3 python; \
    ln -s python3-config python-config

ENV PYTHON_PIP_VERSION 19.0.3

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

ENV BUILDBOT_VERSION 1.8.0
RUN pip3 install --upgrade pip && \
    pip --no-cache-dir install twisted[tls] && \
    pip --no-cache-dir install buildbot_worker==$BUILDBOT_VERSION

RUN useradd --create-home --home-dir=/var/lib/buildbot buildbot
WORKDIR /var/lib/buildbot
USER buildbot

COPY buildbot.tac .

CMD ["twistd", "--pidfile=", "--nodaemon", "--python=buildbot.tac"]
