FROM debian/eol:squeeze

m4_include(debian/6/apt.m4)
m4_include(debian/6/openssl.m4)
m4_include(debian/6/curl.m4)
m4_include(debian/6/python.m4)
m4_include(pip.m4)
m4_include(buildbot.m4)m4_dnl
