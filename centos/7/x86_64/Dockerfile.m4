m4_include(m4/yum.m4)m4_dnl
FROM centos:7

RUN set -ex; \
    M4_YUM -y install \
        https://centos7.iuscommunity.org/ius-release.rpm \
    ; \
    M4_YUM -y install \
        gcc \
        make \
        python36u \
        python36u-pip \
        python36u-devel \
    ; \
    M4_YUM clean all

RUN ln -s /usr/bin/pip3.6 /usr/bin/pip3

m4_include(common/buildbot.m4)m4_dnl
