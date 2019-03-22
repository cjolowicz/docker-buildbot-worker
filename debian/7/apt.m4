RUN sed -i \
        -e s/deb.debian.org/archive.debian.org/ \
        -e /wheezy-updates/d \
        /etc/apt/sources.list
