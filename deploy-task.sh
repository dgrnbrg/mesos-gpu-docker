#!/usr/bin/env bash

: ${HOSTNAME:="localhost"}
: ${LIBPROCESS_IP:="127.0.0.1"}

docker_rm() {
    if [ "$(docker ps --filter "name=$1" -a -q)" != "" ]; then
        docker rm -f "$1"
    fi
}

docker_rm mesos-gpu-execute
docker run \
    --net="host" \
    -e "LIBPROCESS_IP=$LIBPROCESS_IP" \
    --name mesos-gpu-execute \
    mesos-gpu-execute

sleep 1

docker logs mesos-agent

docker exec -t -i mesos-agent /bin/bash
