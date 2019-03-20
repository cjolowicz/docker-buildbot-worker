FROM m4_ifelse(ARCH, `i386', `i386/')alpine:3.9.2

RUN apk add --update --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    python3-dev

m4_include(buildbot.m4)
