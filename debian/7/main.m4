RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

m4_include(debian/6/openssl.m4)
m4_include(debian/7/python.m4)
m4_include(pip.m4)
m4_include(buildbot.m4)m4_dnl
