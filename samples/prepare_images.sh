#!/usr/bin/env bash

echo NOTE: Invoke registry_setup.sh before running test

export registry=localhost:5000

# clear images from local cache
docker rmi $registry/myimage:1
docker rmi $registry/myimage:2
docker rmi $registry/base:1
docker rmi $registry/base:2 

echo Building base images
docker build base1 -t $registry/base:1 || exit
docker build base2 -t $registry/base:2 || exit
docker tag $registry/base:1 $registry/base:latest  || exit
docker push $registry/base || exit 
