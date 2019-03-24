libbz2-dev
libdb-dev
libgdbm-dev
m4_ifelse(RELEASE, 5, `', liblzma-dev)
libncursesw5-dev
libreadline-dev
libsqlite3-dev
tk-dev
m4_ifelse(RELEASE, 6,
libexpat1-dev
libncurses5-dev,
build-essential
libc6-dev
libexpat-dev
libffi-dev
libz-dev
uuid-dev
xz-utils)
