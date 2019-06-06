m4_include(m4/yum-install.m4)m4_dnl
FROM centos:6

RUN M4_YUM_INSTALL(https://centos6.iuscommunity.org/ius-release.rpm); \
    M4_YUM_INSTALL(
        m4_include(centos/buildbot-deps.m4))

m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
