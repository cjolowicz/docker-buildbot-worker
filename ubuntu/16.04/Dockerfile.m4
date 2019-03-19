FROM m4_ifelse(ARCH, `i386', `i386/')ubuntu:16.04

RUN apt-get update && apt-get install -y \
    build-essential \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

m4_include(buildbot.m4)
