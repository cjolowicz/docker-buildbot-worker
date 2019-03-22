RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libbz2-dev \
        libc6-dev \
        libdb-dev \
        libexpat-dev \
        libffi-dev \
        libgdbm-dev \
        liblzma-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libz-dev \
        tk-dev \
        uuid-dev \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*
