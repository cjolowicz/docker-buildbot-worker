FROM debian:wheezy

m4_include(debian/7/apt.m4)
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

m4_include(debian/openssl-deps.m4)
m4_include(common/openssl.m4)
m4_include(debian/7/python-deps.m4)
m4_include(common/python.m4)
m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
