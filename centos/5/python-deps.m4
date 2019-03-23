m4_include(m4/yum.m4)m4_dnl
RUN set -ex; \
    M4_YUM install -y \
        bzip2 \
        bzip2-devel \
        findutils \
        patch \
        readline-devel \
        sqlite \
        sqlite-devel \
        xz \
        xz-devel \
        zlib-devel \
    ; \
    M4_YUM clean all
