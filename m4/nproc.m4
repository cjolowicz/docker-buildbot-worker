m4_define(`M4_NPROC',
    m4_ifelse(
        PLATFORM, centos,
        grep -c processor /proc/cpuinfo,
        PLATFORM RELEASE, debian 5,
        grep -c processor /proc/cpuinfo,
        nproc))m4_dnl
