# https://stackoverflow.com/questions/55229056
m4_define(YUM, m4_ifelse(ARCH, `x86_64', `yum', ARCH, `i386', `linux32 yum'))m4_dnl

# Download sources, using tuxad.de's curl for TLS 1.2 support.
# Invoke curl with `--insecure` because of this:
#
#   curl: (60) SSL certificate problem, verify that the CA cert is OK. Details:
#   error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed
#
m4_define(
    CURL,
    rpm -i m4_ifelse(
        ARCH, `x86_64',
        `http://www.tuxad.de/repo/5/tuxad.rpm',
        ARCH, `i386',
        `http://www.tuxad.com/rpms/tuxad-release-5-1.noarch.rpm',
    ); \
    YUM update -y; \
    YUM install -y curl; \
    curl --insecure $1; \
    YUM remove -y curl openssl1; \
    rpm --erase m4_ifelse(
        ARCH, `x86_64',
        `tuxad-release-5-7',
        ARCH, `i386',
        `tuxad-release',
    ); \
    YUM clean all)
