#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Please provide a branch name";
    exit 1;
fi

git checkout master \
    && git pull \
    && git submodule update \
    && git checkout -b $1
