#!/bin/bash

includedir=$1
shift

target=$1
shift

for file
do
    echo "$target: $file"
    grep -o 'm4_include([^)]*)' "$file" |
        sed -e "s:^m4_include(:$includedir/:" -e 's:)$::' |
        xargs $0 "$includedir" "$target"
done
