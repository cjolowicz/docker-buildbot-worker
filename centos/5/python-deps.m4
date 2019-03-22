RUN set -ex; \
    YUM install -y \
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
    YUM clean all
