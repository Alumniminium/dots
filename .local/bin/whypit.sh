#!/bin/bash

# strict mode for masochism, character building, and actual learning
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IFS=$'\n\t'

#API="https://api.whyp.it/api/tracks"
API="http://localhost:5000/api/tracks"

# parse input args

file=${1:-}

if [ -z "$file" ]; then
    echo 'error: no file specified';
    exit 1
fi
name=${2:-}

if [ -z "$name" ]; then
    name=$(basename -- "$file")
fi

test=${3:-}

# setup variables

id=error_id_not_set
token=error_token_not_set
slug=error_slug_not_set

# start the upload

if [ -z "$test" ]; then
    echo "Uploading $file ...";
    json=$(curl -s --location --request POST "$API" --header 'Accept: application/json' \
            --form 'file=@'"$file"'' \
            --form 'title='"$name"'')
            
    json=$(echo $json | grep -oP '(?<=:).*(?=})' | tr --delete \")
    id=$(echo "$json" | awk -F',owner_token:' '{print $1}')
    echo "Uploaded $id transcoding...";
else
    json=$(curl -s --location \
                --request POST "$API?test" \
                --header 'Accept: application/json' \
                --form 'file=@'"$file"'' \
                --form 'title='"$name"'' \
                | grep -oP '(?<=:).*(?=})' \
                | tr --delete \")
fi

# parse the initial response

id=$(echo "$json" | awk -F',owner_token:' '{print $1}')
token=$(echo "$json" | awk -F',owner_token:' '{print $2}')

echo "Id: $id"
echo "Token: $token"
# check if transcoding is done

json=$(curl -s --location --request GET "$API/$id/first-long-poll" --header 'Accept: application/json')

if [[ $json == *"time_estimate"* ]]; then
    time=$(echo $json | tr --delete '\"}' | cut -d ':' -f 2)
    sleepTime=$(( $time / 1000 ))
    start=0
    echo "Transcoding finish in $sleepTime seconds..."
    for (( c=$start; c<=$sleepTime; c++ ))
    do
    	echo -n "."
    	sleep 1
    done
fi

# if slug is empty, transcoding isn't done, wait for it to finish
json=$(curl -s --location \
            --request GET "$API/$id/second-long-poll" \
            --header 'Accept: application/json')

echo "Slug Json: $json"
 slug=$(echo "$json" | awk -F'"slug":' '{print $2}' \
                     | tr --delete '\"}')
echo "Slug: $slug"
if [ -z "$slug" ]; then
   	echo "failed";
    exit
fi

# display whyp.it URL or delete the file if it was a test run

if [ -z "$test" ]; then
    echo "Play: https://whyp.it/t/$slug?token=$token";
else
    curl -s --location \
            --request DELETE "$API/$id?owner_token=$token" \
            --header 'Accept: application/json'
     echo "passed";
fi
