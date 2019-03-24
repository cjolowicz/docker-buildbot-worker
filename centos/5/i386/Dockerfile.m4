FROM themattrix/centos5-vault-i386

m4_include(m4/yum-install.m4)m4_dnl
m4_include(centos/yum-multilib.m4)
# OpenSSL requires Perl >= 5.10.0, repositories have 5.8.8.
RUN M4_YUM_INSTALL(
    m4_include(centos/5/perl-deps.m4)
    m4_include(centos/5/curl-deps.m4)
    m4_include(centos/5/python-deps.m4))

m4_include(common/perl.m4)
m4_include(common/openssl.m4)
m4_include(common/curl.m4)
m4_include(common/python.m4)
m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
