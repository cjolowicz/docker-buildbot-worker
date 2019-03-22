ENV CURL_VERSION 7.64.0

RUN set -ex; \
    cd /usr/local/src; \
    m4_ifelse(PLATFORM, centos,
    M4_CURL(-LO https://curl.haxx.se/download/curl-$CURL_VERSION.tar.gz),
    M4_CURL(-LO https://dl.uxnr.de/mirror/curl/curl-$CURL_VERSION.tar.gz)); \
    tar -xf curl-$CURL_VERSION.tar.gz; \
    rm -f curl-$CURL_VERSION.tar.gz; \
    cd curl-$CURL_VERSION; \
    LDFLAGS="-Wl,-R/usr/local/lib:$OPENSSL_DIR/lib" \
    ./configure \
        --with-ssl=$OPENSSL_DIR \
        m4_ifelse(ARCH, i386, --host=i686-pc-linux-gnu CFLAGS=-m32); \
    make -j "$(M4_NPROC)"; \
    make install; \
    cd ..; \
    rm -rf curl-$CURL_VERSION; \
    /usr/local/bin/curl --version

ENV PATH /usr/local/bin:$PATH
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
