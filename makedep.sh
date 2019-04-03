#!/bin/bash

makedep() {
    arg=$1
    shift

    target=$(basename $arg)
    targetdir=$(dirname $arg)

    for file
    do
        dependency=$(realpath --relative-to=$targetdir "$file")
        echo "$target: $dependency"
        makedep "$arg" $(
            grep -o 'm4_include([^)]*)' "$file" |
            sed -e "s/^m4_include(//" -e 's/)$//')
    done
}

makedep "$@" | sort | uniq
