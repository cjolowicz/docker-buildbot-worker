m4_include(yum.m4)m4_dnl
m4_include(functions.m4)m4_dnl
FROM m4_ifelse(
    ARCH, `x86_64',
    `astj/centos5-vault',
    ARCH, `i386',
    `themattrix/centos5-vault-i386')

# Configure yum's multilib_policy to prevent installation failures.
# https://serverfault.com/questions/77122/rhel5-forbid-installation-of-i386-packages-on-64-bit-systems
RUN echo "multilib_policy=best" >> /etc/yum.conf

# OpenSSL requires Perl >= 5.10.0, repositories have 5.8.8.
m4_include(perl.m4)
m4_include(openssl.m4)
m4_include(curl.m4)
m4_include(python.m4)
m4_include(buildbot.m4)m4_dnl
