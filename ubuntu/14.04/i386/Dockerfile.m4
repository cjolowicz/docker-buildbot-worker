m4_include(m4/apt-install.m4)m4_dnl
FROM i386/ubuntu:14.04

RUN M4_APT_INSTALL(
    m4_include(debian/buildbot-deps.m4))

m4_include(common/buildbot.m4)m4_dnl
