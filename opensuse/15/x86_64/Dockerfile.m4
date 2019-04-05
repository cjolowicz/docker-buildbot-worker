m4_include(m4/zypper-install.m4)m4_dnl
FROM opensuse/leap:15

RUN M4_ZYPPER_INSTALL(
    m4_include(opensuse/buildbot-deps.m4))

m4_include(common/buildbot.m4)m4_dnl
