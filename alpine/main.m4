RUN apk add --update --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    python3-dev

m4_include(buildbot.m4)m4_dnl
