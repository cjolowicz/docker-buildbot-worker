m4_dnl
m4_dnl https://stackoverflow.com/questions/55229056
m4_dnl
m4_define(
    YUM,
    m4_ifelse(
        ARCH, `x86_64',
        `yum',
        ARCH, `i386',
        `linux32 yum'))m4_dnl
