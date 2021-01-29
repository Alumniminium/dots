#!/bin/sh

cache=$(cat /tmp/feelinglucky)
query="$(echo "$cache" | rofi -dmenu -p "Go to" -u 1 -l 3)"

if [ -z $query ]; then
    return
fi

echo "$query" | cat - /tmp/feelinglucky > /tmp/feelingluckytmp && mv /tmp/feelingluckytmp /tmp/feelinglucky
echo "$query" | tee -a /tmp/feelinglucky
surf $(googler -n 1 search "$query" --json | jq -r '.[].url')