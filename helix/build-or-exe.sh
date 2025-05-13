#!/usr/bin/env bash

IMAGE_NAME="rust:0.1"
user="0:0"


if [ "$1" = "--build" ]; then
	docker build --progress=plain --no-cache \
        --build-arg UID=$(id -u) --build-arg GID=$(id -g) \
        -t $IMAGE_NAME .
	exit 0
fi

if [ "$1" = "--host" ]; then
    user="$(id -u):$(id -g)"
    if ! [ -z "$2" ]; then
        docker run -it --rm -v $(pwd)/$2:/home/appuser/$2 \
        --user "$user" \
        $IMAGE_NAME bash
    else
	    echo  "Directory to map not specified"
    fi
fi


