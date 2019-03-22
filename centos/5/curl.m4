ENV CURL_VERSION 7.64.0

RUN set -ex; \
    cd /usr/local/src; \
    CURL(https://curl.haxx.se/download/curl-$CURL_VERSION.tar.gz -LO); \
    tar -xf curl-$CURL_VERSION.tar.gz; \
    rm -f curl-$CURL_VERSION.tar.gz; \
    cd curl-$CURL_VERSION; \
    LDFLAGS=-Wl,-R$OPENSSL_DIR/lib \
    ./configure \
        --with-ssl=$OPENSSL_DIR \
        m4_ifelse(ARCH, `i386', `--host=i686-pc-linux-gnu CFLAGS=-m32'); \
    make -j $(grep -c processor /proc/cpuinfo); \
    make install; \
    cd ..; \
    rm -rf curl-$CURL_VERSION; \
    /usr/local/bin/curl --version

ENV PATH /usr/local/bin:$PATH
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
