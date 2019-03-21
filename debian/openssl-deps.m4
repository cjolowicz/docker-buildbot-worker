RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        curl \
        gcc \
        make \
        libc6-dev \
        patch \
        perl \
        zlib1g-dev \
    ; \
    rm -rf /var/lib/apt/lists/*
