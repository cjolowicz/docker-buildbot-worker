m4_include(m4/yum-install.m4)m4_dnl
FROM centos:7

RUN M4_YUM_INSTALL(https://centos7.iuscommunity.org/ius-release.rpm); \
    M4_YUM_INSTALL(
        gcc \
        make \
        python36u \
        python36u-pip \
        python36u-devel \
    )

RUN ln -s /usr/bin/pip3.6 /usr/bin/pip3

m4_include(common/buildbot.m4)m4_dnl
