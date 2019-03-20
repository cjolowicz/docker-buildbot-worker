m4_include(centos/yum.m4)m4_dnl
FROM centos:7

RUN set -ex; \
    YUM -y install \
        https://centos7.iuscommunity.org/ius-release.rpm \
    ; \
    YUM -y install \
        gcc \
        make \
        python36u \
        python36u-pip \
        python36u-devel \
    ; \
    YUM clean all

RUN ln -s /usr/bin/pip3.6 /usr/bin/pip3

m4_include(buildbot.m4)m4_dnl
