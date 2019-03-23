m4_include(m4/apt-install.m4)m4_dnl
FROM debian:stretch

RUN M4_APT_INSTALL(
    m4_include(debian/buildbot-deps.m4))

m4_include(common/buildbot.m4)m4_dnl
