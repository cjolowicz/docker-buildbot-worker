m4_include(m4/yum-install.m4)m4_dnl
FROM i386/centos:6

RUN set -ex; \
    echo i686 > /etc/yum/vars/arch; \
    echo i386 > /etc/yum/vars/basearch; \
    yum install -y util-linux-ng; \
    yum clean all; \
    M4_YUM_INSTALL(
        https://dl.iuscommunity.org/pub/ius/stable/CentOS/6/i386/ius-release-1.0-15.ius.centos6.noarch.rpm); \
    M4_YUM_INSTALL(
        m4_include(centos/buildbot-deps.m4))

RUN ln -s /usr/bin/pip3.6 /usr/bin/pip3

ENTRYPOINT ["/usr/bin/linux32"]

m4_include(common/buildbot.m4)m4_dnl
