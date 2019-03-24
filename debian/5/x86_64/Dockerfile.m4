m4_include(m4/apt-install.m4)m4_dnl
FROM debian/eol:lenny

m4_include(debian/6/apt.m4)
RUN M4_APT_INSTALL(
    ca-certificates
    m4_include(debian/openssl-deps.m4)
    m4_include(debian/curl-deps.m4)
    m4_include(debian/python-deps.m4))

m4_include(common/openssl.m4)
m4_include(common/curl.m4)
# Workaround: List directory /var/lib/apt/lists/partial is missing.
RUN set -ex; \
    mkdir -p /var/lib/apt/lists/partial; \
    apt-get purge -y curl libcurl3

m4_include(common/python.m4)
m4_include(common/pip.m4)
m4_include(common/buildbot.m4)m4_dnl
