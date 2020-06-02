#!/usr/bin/env bash

# base:latest is auto-detected

source prepare_images.sh

echo Building myimage
docker build auto -t $registry/myimage:1 || exit
docker push $registry/myimage:1 || exit

echo Running image:
docker run --rm $registry/myimage:1 || exit   

echo taging base:2 as latest
docker tag $registry/base:2 $registry/base:latest || exit
docker push $registry/base:latest || exit  

echo
echo taging base:2 as latest
docker tag $registry/base:2 $registry/base:latest || exit
docker push $registry/base:latest || exit  

echo
echo Rebasing image
../image_rebase $registry myimage:1 || exit
# repull from repository
docker pull $registry/myimage:1 || exit 

echo
echo Running rebased image with centos7+base2 layers:
docker run --rm  $registry/myimage:1 || exit    

