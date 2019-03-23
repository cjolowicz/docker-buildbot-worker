m4_include(m4/curl.m4)m4_dnl
m4_include(m4/nproc.m4)m4_dnl
ENV PERL_VERSION 5.28.1

RUN set -ex; \
    cd /usr/local/src; \
    M4_CURL(http://www.cpan.org/src/5.0/perl-$PERL_VERSION.tar.gz -LO); \
    tar -xf perl-$PERL_VERSION.tar.gz; \
    rm -f perl-$PERL_VERSION.tar.gz; \
    cd perl-$PERL_VERSION; \
    ./Configure -des; \
    make -j "$(M4_NPROC)"; \
    make install; \
    cd ..; \
    rm -rf perl-$PERL_VERSION
