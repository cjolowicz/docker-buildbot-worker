m4_include(m4/tuxad-curl.m4)m4_dnl
m4_define(`M4_CURL',
    m4_ifelse(
        PLATFORM RELEASE, centos 5,
        M4_TUXAD_CURL($1),
        PLATFORM RELEASE, debian 5,
        curl --insecure $1,
        curl $1))m4_dnl
