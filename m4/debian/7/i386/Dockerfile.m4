FROM i386/debian:wheezy

m4_include(debian/7/dependencies.m4)
m4_include(debian/openssl-deps.m4)
m4_include(openssl.m4)
m4_include(debian/7/python.m4)
m4_include(pip.m4)
m4_include(buildbot.m4)m4_dnl
