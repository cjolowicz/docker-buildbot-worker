FROM i386/debian:wheezy

m4_include(debian/7/dependencies.m4)
m4_include(debian/openssl-deps.m4)
m4_include(common/openssl.m4)
m4_include(debian/7/python.m4)
m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
