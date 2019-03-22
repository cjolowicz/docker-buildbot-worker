FROM debian/eol:squeeze

m4_include(debian/6/apt.m4)
m4_include(debian/openssl-deps.m4)
m4_include(common/openssl.m4)
m4_include(debian/6/curl-deps.m4)
m4_include(debian/6/curl.m4)
m4_include(debian/6/python.m4)
m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
