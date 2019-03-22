RUN set -ex; \
    YUM install -y \
        file \
    ; \
    YUM clean all
