#!/bin/bash

cwd=$(pwd)
tmpdir=$(mktemp -d)

trap 'cd $cwd && rm -rf $tmpdir' 0
cd $tmpdir

curl -LO http://ftp.de.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_20161130+nmu1+deb9u1_all.deb
ar -x ca-certificates_20161130+nmu1+deb9u1_all.deb
tar -Jxf data.tar.xz
mv usr/share/ca-certificates $cwd
