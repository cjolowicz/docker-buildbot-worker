ENV PERL_VERSION 5.28.1

RUN set -ex; \
    cd /usr/local/src; \
    CURL(http://www.cpan.org/src/5.0/perl-$PERL_VERSION.tar.gz -LO); \
    tar -xf perl-$PERL_VERSION.tar.gz; \
    rm -f perl-$PERL_VERSION.tar.gz; \
    cd perl-$PERL_VERSION; \
    ./Configure -des; \
    make -j $(grep -c processor /proc/cpuinfo); \
    make install; \
    cd ..; \
    rm -rf perl-$PERL_VERSION
