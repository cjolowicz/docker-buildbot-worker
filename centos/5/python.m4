ENV PYTHON_VERSION 3.6.8

# https://stackoverflow.com/questions/5937337/building-python-with-ssl-support-in-non-standard-location
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
        LDFLAGS="$(pkg-config --libs openssl) -Wl,-R$OPENSSL_DIR/lib"; \
    make -j $(grep -c processor /proc/cpuinfo); \
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
