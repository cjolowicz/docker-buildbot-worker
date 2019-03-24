m4_include(m4/yum-install.m4)m4_dnl
FROM scientificlinux/sl:7

RUN M4_YUM_INSTALL(epel-release); \
    M4_YUM_INSTALL(
    m4_include(scientific/buildbot-deps.m4))

RUN set -ex; \
    ln -s /usr/bin/pip3.6 /usr/bin/pip3; \
    ln -s /usr/bin/python3.6 /usr/bin/python3

m4_include(common/buildbot.m4)m4_dnl
