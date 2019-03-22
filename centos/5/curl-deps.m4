RUN set -ex; \
    M4_YUM install -y \
        file \
    ; \
    M4_YUM clean all
