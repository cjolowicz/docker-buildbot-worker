m4_include(m4/yum-install.m4)m4_dnl
FROM scientificlinux/sl:7

RUN M4_YUM_INSTALL(epel-release); \
    M4_YUM_INSTALL(
    m4_include(scientific/buildbot-deps.m4))

m4_include(common/buildbot.m4)m4_dnl
