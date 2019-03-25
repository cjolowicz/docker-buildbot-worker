m4_include(m4/yum-install.m4)m4_dnl
FROM scientificlinux/sl:6

RUN M4_YUM_INSTALL(
    m4_include(centos/5/perl-deps.m4)
    m4_include(centos/5/python-deps.m4))

m4_include(common/perl.m4)
m4_include(common/openssl.m4)
m4_include(common/python.m4)
m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
