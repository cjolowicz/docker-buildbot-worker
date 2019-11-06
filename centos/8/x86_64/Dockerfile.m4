m4_include(m4/yum-install.m4)m4_dnl
FROM centos:8

RUN M4_YUM_INSTALL(
    gcc
    make
    python3
    python3-devel
    python3-pip)

m4_include(common/buildbot.m4)m4_dnl
