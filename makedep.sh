#!/bin/bash

if realpath --relative-to=/ / >/dev/null 2>&1
then
    relative_to() {
        realpath --relative-to="$1" "$2"
    }
else
    relative_to() {
        $(dirname $0)/relative-to.sh "$@"
    }
fi

makedep() {
    arg=$1
    shift

    target=$(basename $arg)
    targetdir=$(dirname $arg)

    for file
    do
        dependency=$(relative_to "$targetdir" "$file")
        echo "$target: $dependency"
        makedep "$arg" $(
            grep -o 'm4_include([^)]*)' "$file" |
            sed -e "s/^m4_include(//" -e 's/)$//')
    done
}

makedep "$@" | sort | uniq
