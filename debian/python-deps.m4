RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libbz2-dev \
        libdb-dev \
        libgdbm-dev \
        liblzma-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        tk-dev m4_ifelse(RELEASE, 6, \
        libexpat1-dev \
        libncurses5-dev, \
        build-essential \
        libc6-dev \
        libexpat-dev \
        libffi-dev \
        libz-dev \
        uuid-dev \
        xz-utils) \
    ; \
    rm -rf /var/lib/apt/lists/*