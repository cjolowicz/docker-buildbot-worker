m4_include(centos/yum.m4)m4_dnl
m4_include(centos/5/tuxad-curl.m4)m4_dnl
# Configure yum's multilib_policy to prevent installation failures.
# https://serverfault.com/questions/77122/rhel5-forbid-installation-of-i386-packages-on-64-bit-systems
RUN echo "multilib_policy=best" >> /etc/yum.conf

# OpenSSL requires Perl >= 5.10.0, repositories have 5.8.8.
m4_include(centos/5/perl.m4)
m4_include(openssl.m4)
m4_include(centos/5/curl.m4)
m4_include(centos/5/python.m4)
m4_include(pip.m4)
m4_include(buildbot.m4)m4_dnl
