m4_dnl
m4_dnl Download sources, using tuxad.de's curl for TLS 1.2 support.
m4_dnl Invoke curl with `--insecure` because of this:
m4_dnl
m4_dnl   curl: (60) SSL certificate problem, verify that the CA cert is OK. Details:
m4_dnl   error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed
m4_dnl
m4_define(
    CURL,
    rpm -i m4_ifelse(
        ARCH, `x86_64',
        `http://www.tuxad.de/repo/5/tuxad.rpm',
        ARCH, `i386',
        `http://www.tuxad.com/rpms/tuxad-release-5-1.noarch.rpm',
    ); \
    M4_YUM install -y curl; \
    curl --insecure $1; \
    M4_YUM remove -y curl openssl1; \
    rpm --erase m4_ifelse(
        ARCH, `x86_64',
        `tuxad-release-5-7',
        ARCH, `i386',
        `tuxad-release',
    ); \
    M4_YUM clean all)m4_dnl
