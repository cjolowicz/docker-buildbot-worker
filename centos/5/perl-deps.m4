m4_include(m4/yum-install.m4)m4_dnl
RUN M4_YUM_INSTALL(
    gcc \
    make \
    openldap-devel \
    zlib-devel \
    )
