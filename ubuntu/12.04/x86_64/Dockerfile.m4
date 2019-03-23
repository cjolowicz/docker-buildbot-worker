m4_include(m4/apt-install.m4)m4_dnl
FROM ubuntu:12.04

RUN M4_APT_INSTALL(
    m4_include(debian/openssl-deps.m4)
    m4_include(debian/curl-deps.m4)
    m4_include(debian/python-deps.m4))

m4_include(common/openssl.m4)
m4_include(common/curl.m4)
RUN apt-get purge -y curl libcurl3

m4_include(common/python.m4)
m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
