#!/bin/sh

if [ -z "$1"  ]; then
    echo "Please provide a branch name";
    exit 1;
else
    name_br="$1"
fi

if [ -z "$2"  ]; then
    base_br="master"
else
    base_br="$2"
fi

read -p "Create branch \"${name_br}\" from \"${base_br}\"? (y/n): " -n 1 choice

if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
    git checkout ${base_br} \
        && git pull \
        && git submodule update \
        && git checkout -b ${name_br} ${base_br}
else
    echo "Abort."
    exit 1
fi
