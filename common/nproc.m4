m4_define(NPROC,
    m4_ifelse(
        PLATFORM, centos,
        grep -c processor /proc/cpuinfo,
        nproc))m4_dnl
