#!/bin/bash

VERSION="$1"
shift

PLATFORM="$1"
shift

RELEASE="$1"
shift

ARCH="$1"
shift

latest_releases=(
    alpine-3.9
    centos-7
    debian-9
    opensuse-42
    scientific-7
    ubuntu-18.04
)

function is_latest_release() {
    for release in ${latest_releases[@]}
    do
        if [ $PLATFORM-$RELEASE = $release ]
        then
            return 0
        fi
    done
    return 1
}

function expand() {
    version="$1"
    shift

    echo "$version-$PLATFORM-$RELEASE-$ARCH"

    if [[ "$version" =~ - ]]
    then
        return
    fi

    if [ $ARCH != x86_64 ]
    then
        return
    fi

    echo "$version-$PLATFORM-$RELEASE"

    if ! is_latest_release
    then
        return
    fi

    echo "$version-$PLATFORM"

    if [ $PLATFORM != alpine ]
    then
        return
    fi

    echo "$version"

    if [[ "$version" = *.* ]]
    then
        return
    fi

    echo latest
}

version="$VERSION"

while :
do
    expand "$version"

    [[ "$version" =~ [.-] ]] || break

    version="${version%[.-]*}"
done
