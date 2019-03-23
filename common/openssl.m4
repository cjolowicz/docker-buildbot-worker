m4_include(m4/curl.m4)m4_dnl
m4_include(m4/nproc.m4)m4_dnl
ENV OPENSSL_VERSION m4_ifelse(PLATFORM, centos, 1.1.0j, 1.1.1b)
ENV OPENSSL_DIR /usr/local/ssl

RUN set -ex; \
    cd /usr/local/src; \
    M4_CURL(https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz -LO); \
    tar -xf openssl-$OPENSSL_VERSION.tar.gz; \
    rm -f openssl-$OPENSSL_VERSION.tar.gz; \
    cd openssl-$OPENSSL_VERSION; \
    m4_ifelse(
        ARCH, x86_64,
        ./config,
        ARCH, i386,
        ./Configure -m32 linux-generic32) \
        --prefix=$OPENSSL_DIR \
        --openssldir=$OPENSSL_DIR \
        shared \
        zlib \
        enable-egd m4_ifelse(PLATFORM, centos, `\
        no-async \
        -Wl,-rpath,$OPENSSL_DIR/lib') \
    ; \
    make -j "$(M4_NPROC)"; \
    make install_sw; \
    cd ..; \
    rm -rf openssl-$OPENSSL_VERSION; \
    echo $OPENSSL_DIR/lib > /etc/ld.so.conf.d/openssl-$OPENSSL_VERSION.conf; \
    ldconfig -v; \
    $OPENSSL_DIR/bin/openssl version -a

ENV PATH $OPENSSL_DIR/bin:$PATH
ENV PKG_CONFIG_PATH $OPENSSL_DIR/lib/pkgconfig
