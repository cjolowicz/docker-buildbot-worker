RUN set -ex; \
    M4_YUM install -y \
        gcc \
        make \
        openldap-devel \
        zlib-devel \
    ; \
    M4_YUM clean all
