#!/bin/sh

# File: weather.sh
# Time-stamp: <2016-03-09 20:19:13>
# Copyright (C) 2016 Pierre Lecocq
# Description:

cache_dir="~/.cache/conky"

if ! [ -d "$cache_dir" ]; then
    mkdir -p $cache_dir
fi

date=$(date +"%d-%m-%Y")
cache_file="$cache_dir/weather-$date"

if ! [ -f "$cache_file-location" ]; then
    rm "$cache_dir/weather-*" 2> /dev/null

    data=$(\curl -s http://www.accuweather.com/en/fr/paris/623/weather-forecast/623 \
           | grep "acm_RecentLocationsCarousel.push" | head -1 \
           | awk '{
                 gsub(/acm_RecentLocationsCarousel\.push\(\{name:\"/, "");
                 gsub(/\"(.*)temp:/, " ");
                 gsub(/,  realfeel:/, " ");
                 gsub(/,  text:/, " ");
                 gsub(/\}\);(.*)/, " ");
                 gsub(/'\''/, " ");} 1')

    location=$(echo $data | awk '{print $1 " " $2}')
    temperature=$(echo $data | awk '{print $3 "°C, " $4 "°C"}')
    comment=$(echo $data | awk '{for(i = 5; i <= NF; ++i) printf $i " "}')

    echo -n $location > "$cache_file-location"
    echo -n $temperature > "$cache_file-temperature"
    echo -n $comment > "$cache_file-comment"
fi

if [ "$#" -eq 1 ]; then
    case $1 in
    "loc" | "location")
        cat "$cache_file-location";;
    "temp" | "temperature")
        cat "$cache_file-temperature";;
    "com" | "comment")
        cat "$cache_file-comment";;
    esac
else
    cat "$cache_file-location"
    echo -n " "
    cat "$cache_file-temperature"
    echo -n " "
    cat "$cache_file-comment"
    echo -n " "
fi
