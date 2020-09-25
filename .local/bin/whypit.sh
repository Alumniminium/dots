#!/bin/bash

# strict mode for masochism, character building, and actual learning
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IFS=$'\n\t'

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
    json=$(curl -s --location \
             --request POST 'https://api.whyp.it/api/tracks' \
             --header 'Accept: application/json' \
             --form 'file=@'"$file"'' \
             --form 'title='"$name"'' \
             | grep -oP '(?<=:).*(?=})' \
             | tr --delete \")

    id=$(echo "$json" | awk -F',owner_token:' '{print $1}')
    echo "Uploaded $id transcoding...";
else
    json=$(curl -s --location \
                --request POST 'https://api.whyp.it/api/tracks?test' \
                --header 'Accept: application/json' \
                --form 'file=@'"$file"'' \
                --form 'title='"$name"'' \
                | grep -oP '(?<=:).*(?=})' \
                | tr --delete \")
fi

# parse the initial response

id=$(echo "$json" | awk -F',owner_token:' '{print $1}')
token=$(echo "$json" | awk -F',owner_token:' '{print $2}')

# check if transcoding is done

json=$(curl -s --location \
               --request GET 'https://api.whyp.it/api/tracks/'"$id"'/first-long-poll' \
               --header 'Accept: application/json')

slug=$(echo "$json" | awk -F'"slug":' '{print $2}' \
                    | tr --delete '\"}')

# if slug is empty, transcoding isn't done, wait for it to finish

if [ -z "$slug" ]; then

    json=$(curl -s --location \
                   --request GET 'https://api.whyp.it/api/tracks/'"$id"'/second-long-poll' \
                   --header 'Accept: application/json')

    slug=$(echo "$json" | awk -F'"slug":' '{print $2}' \
                        | tr --delete '\"}')

    if [ -z "$slug" ]; then
       	echo "failed";
        exit
    fi

fi

# display whyp.it URL or delete the file if it was a test run

if [ -z "$test" ]; then
    echo "Play: https://whyp.it/t/$slug?token=$token";
else
    curl -s --location \
            --request DELETE 'https://api.whyp.it/api/tracks/'"$id"'?owner_token='"$token"'' \
            --header 'Accept: application/json'
     echo "passed";
fi
