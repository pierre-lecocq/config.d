#!/bin/sh

# File: ip.sh
# Time-stamp: <2016-03-09 10:10:48>
# Copyright (C) 2016 Pierre Lecocq
# Description:

cache_dir="$HOME/.cache/conky"

if ! [ -d "$cache_dir" ]; then
    echo "Create"
    mkdir -p $cache_dir
fi

cache_file="$cache_dir/ip"

if ! [ -f "$cache_file" ]; then
    echo "Create again"
    curl -s http://whatismyip.akamai.com/ > $cache_file
fi

cat $cache_file
