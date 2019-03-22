RUN set -ex; \
    YUM install -y \
        gcc \
        make \
        openldap-devel \
        zlib-devel \
    ; \
    YUM clean all
