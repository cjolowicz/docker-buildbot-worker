#!/bin/bash

arg=$1
shift

target=$(basename $arg)
targetdir=$(dirname $arg)

for file
do
    dependency=$(realpath --relative-to=$targetdir "$file")
    echo "$target: $dependency"
    grep -o 'm4_include([^)]*)' "$file" |
        sed -e "s/^m4_include(//" -e 's/)$//' |
        xargs $0 "$arg"
done
