#!/usr/bin/env bash

set -e

sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

if [ ! -f packages_installed ]; then
  touch packages_installed
  echo "Log back in and we'll be working"
  logout
fi

: ${IMAGES:="mesos-base
             mesos-build
             mesos-master
             mesos-agent
             mesos-gpu-execute
             zookeeper"}

# Build the images
for image in ${IMAGES}; do
    docker build \
        -t ${image} \
        -f Dockerfile.${image} \
        .
done
