m4_include(m4/apt-install.m4)m4_dnl
RUN M4_APT_INSTALL(
    curl \
    gcc \
    make \
    libc6-dev \
    patch \
    perl \
    zlib1g-dev \
    )
