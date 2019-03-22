RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        file \
    ; \
    rm -rf /var/lib/apt/lists/*
