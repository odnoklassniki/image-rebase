#!/usr/bin/env bash

source prepare_images.sh

echo
echo Building myimage
docker build manual -t $registry/myimage:1 || exit
docker push $registry/myimage:1 || exit

echo
echo Running myimage:
docker run --rm $registry/myimage:1 || exit   

echo
echo Rebasing to base:2
../image_rebase $registry myimage:1 --from-base base:1 --to-base base:2 -t base2 -f || exit  
# repull from repository
docker pull $registry/myimage:base2 || exit 

echo
echo Running rebased image with centos7+base2 layers:
docker run --rm  $registry/myimage:base2 || exit    

# Non-direct parent rebase example:
echo
echo Rebasing to centos:7 but keep base:1 layers
../image_rebase $registry myimage:1 --from-base centos:6 --to-base centos:7 -t centos7 -f  || exit
# repull from repository
docker pull $registry/myimage:centos7 

echo
echo Running rebased image with centos7+base1 layers:
docker run --rm  $registry/myimage:centos7 || exit    

