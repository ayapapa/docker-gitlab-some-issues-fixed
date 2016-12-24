#!/bin/bash

DOCKER_GITLAB_VERSION=`cat VERSION`

echo DOCKER_GITLAB_VERSION=${DOCKER_GITLAB_VERSION}

sed "s/{{VERSION}}/${DOCKER_GITLAB_VERSION}/" \
    ./template/Dockerfile > ./Dockerfile

sudo docker build -t ayapapa/docker-gitlab:${DOCKER_GITLAB_VERSION} .

git clone -b ${DOCKER_GITLAB_VERSION} \
    https://github.com/sameersbn/docker-gitlab.git

mkdir -p old-ymls
cp -p ./docker-compose.yml \
      ./old-ymls/docker-compose-`date +"%Y-%m-%d-%H-%M-%S"`.yml

sed "s/sameersbn\/gitlab/ayapapa\/docker-gitlab/" \
    ./docker-gitlab/docker-compose.yml > ./docker-compose.yml

rm -fr docker-gitlab

echo finished docker-gitlab build.
echo modify docker-compose.yml if need, and then execute docker-compose up -d
