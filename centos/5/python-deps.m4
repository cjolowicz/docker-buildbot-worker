m4_include(m4/yum-install.m4)m4_dnl
RUN M4_YUM_INSTALL(
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
    )
