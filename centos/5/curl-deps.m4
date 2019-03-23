m4_include(m4/yum.m4)m4_dnl
RUN set -ex; \
    M4_YUM install -y \
        file \
    ; \
    M4_YUM clean all
