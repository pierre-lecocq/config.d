#!/bin/sh

if [ ! -d ./.git ]; then
    echo "Current folder is not a git repository" >&2
    exit
fi

for remote in $(git remote | grep -v -e '^origin$'); do
    git remote prune $remote
done
