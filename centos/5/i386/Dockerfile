FROM themattrix/centos5-vault-i386

# Configure yum's multilib_policy to prevent installation failures.
# https://serverfault.com/questions/77122/rhel5-forbid-installation-of-i386-packages-on-64-bit-systems
RUN echo "multilib_policy=best" >> /etc/yum.conf

# OpenSSL requires Perl >= 5.10.0, repositories have 5.8.8.
RUN set -ex; \
    linux32 yum install -y \
        gcc \
        make \
        openldap-devel \
        zlib-devel \
    ; \
    linux32 yum clean all

ENV PERL_VERSION 5.28.1

RUN set -ex; \
    cd /usr/local/src; \
    rpm -i http://www.tuxad.com/rpms/tuxad-release-5-1.noarch.rpm; \
    linux32 yum install -y curl; \
    curl --insecure http://www.cpan.org/src/5.0/perl-$PERL_VERSION.tar.gz -LO; \
    linux32 yum remove -y curl openssl1; \
    rpm --erase tuxad-release; \
    linux32 yum clean all; \
    tar -xf perl-$PERL_VERSION.tar.gz; \
    rm -f perl-$PERL_VERSION.tar.gz; \
    cd perl-$PERL_VERSION; \
    ./Configure -des; \
    make -j $(grep -c processor /proc/cpuinfo); \
    make install; \
    cd ..; \
    rm -rf perl-$PERL_VERSION

ENV OPENSSL_VERSION 1.1.0j
ENV OPENSSL_DIR /usr/local/ssl

RUN set -ex; \
    cd /usr/local/src; \
    rpm -i http://www.tuxad.com/rpms/tuxad-release-5-1.noarch.rpm; \
    linux32 yum install -y curl; \
    curl --insecure https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz -LO; \
    linux32 yum remove -y curl openssl1; \
    rpm --erase tuxad-release; \
    linux32 yum clean all; \
    tar -xf openssl-$OPENSSL_VERSION.tar.gz; \
    rm -f openssl-$OPENSSL_VERSION.tar.gz; \
    cd openssl-$OPENSSL_VERSION; \
    ./Configure -m32 linux-generic32 \
        --prefix=$OPENSSL_DIR \
        --openssldir=$OPENSSL_DIR \
        shared \
        zlib \
        enable-egd \
        no-async \
        -Wl,-rpath,$OPENSSL_DIR/lib \
    ; \
    make -j "$(grep -c processor /proc/cpuinfo)"; \
    make install_sw; \
    cd ..; \
    rm -rf openssl-$OPENSSL_VERSION; \
    echo $OPENSSL_DIR/lib > /etc/ld.so.conf.d/openssl-$OPENSSL_VERSION.conf; \
    ldconfig -v; \
    $OPENSSL_DIR/bin/openssl version -a

ENV PATH $OPENSSL_DIR/bin:$PATH
ENV PKG_CONFIG_PATH $OPENSSL_DIR/lib/pkgconfig

RUN set -ex; \
    linux32 yum install -y \
        file \
    ; \
    linux32 yum clean all

ENV CURL_VERSION 7.64.0

RUN set -ex; \
    cd /usr/local/src; \
    rpm -i http://www.tuxad.com/rpms/tuxad-release-5-1.noarch.rpm; \
    linux32 yum install -y curl; \
    curl --insecure https://curl.haxx.se/download/curl-$CURL_VERSION.tar.gz -LO; \
    linux32 yum remove -y curl openssl1; \
    rpm --erase tuxad-release; \
    linux32 yum clean all; \
    tar -xf curl-$CURL_VERSION.tar.gz; \
    rm -f curl-$CURL_VERSION.tar.gz; \
    cd curl-$CURL_VERSION; \
    LDFLAGS="-Wl,-R/usr/local/lib:$OPENSSL_DIR/lib" \
    ./configure \
        --with-ssl=$OPENSSL_DIR \
        --host=i686-pc-linux-gnu CFLAGS=-m32; \
    make -j "$(grep -c processor /proc/cpuinfo)"; \
    make install; \
    cd ..; \
    rm -rf curl-$CURL_VERSION; \
    /usr/local/bin/curl --version

ENV PATH /usr/local/bin:$PATH
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

RUN set -ex; \
    linux32 yum install -y \
        bzip2 \
        bzip2-devel \
        findutils \
        patch \
        readline-devel \
        sqlite \
        sqlite-devel \
        xz \
        xz-devel \
        zlib-devel \
    ; \
    linux32 yum clean all

ENV PYTHON_VERSION 3.6.8

# https://stackoverflow.com/questions/5937337
COPY python-use-local-openssl.patch /usr/local/src

RUN set -ex; \
    cd /usr/local/src; \
    curl https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz -LO; \
    tar -xf Python-$PYTHON_VERSION.tgz; \
    rm -f Python-$PYTHON_VERSION.tgz; \
    cd Python-$PYTHON_VERSION; \
    patch -p1 < ../python-use-local-openssl.patch; \
    ./configure \
        --enable-loadable-sqlite-extensions \
        --without-ensurepip \
        CPPFLAGS="$(pkg-config --cflags openssl) -Wl,-R$OPENSSL_DIR/lib" \
        LDFLAGS="$(pkg-config --libs openssl) -Wl,-R$OPENSSL_DIR/lib" \
    ; \
    make -j "$(grep -c processor /proc/cpuinfo)"; \
    make install; \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' + \
    ; \
    cd ..; \
    rm -rf Python-$PYTHON_VERSION; \
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
