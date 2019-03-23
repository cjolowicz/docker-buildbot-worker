m4_include(m4/apt-install.m4)m4_dnl
FROM i386/debian:wheezy

m4_include(debian/7/apt.m4)
RUN M4_APT_INSTALL(ca-certificates)

m4_include(debian/openssl-deps.m4)
m4_include(common/openssl.m4)
m4_include(debian/python-deps.m4)
m4_include(common/python.m4)
m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
