m4_include(m4/yum.m4)m4_dnl
m4_define(
    `M4_YUM_INSTALL',
    set -ex; \
    M4_YUM install -y \
    $1; \
    M4_YUM clean all)m4_dnl
