#!/bin/bash

DOCKER_GITLAB_VERSION=`cat VERSION`

echo -n "building docker-gitlab:${DOCKER_GITLAB_VERSION}\'s"
echo    " fixed rerative url issues rerative url issues..."

echo DOCKER_GITLAB_VERSION=${DOCKER_GITLAB_VERSION}

sed "s/{{VERSION}}/${DOCKER_GITLAB_VERSION}/" \
    ./template/Dockerfile > ./Dockerfile

sudo docker build -t ayapapa/docker-gitlab:${DOCKER_GITLAB_VERSION} .

echo "recreating docker-compose.yml..."
git clone -v -b ${DOCKER_GITLAB_VERSION} \
    https://github.com/sameersbn/docker-gitlab.git

mkdir -p old-ymls
if [ -f ./docker-compose.yml ]; then
  YML_FILE_NAME=docker-compose.yml-`date +"%Y-%m-%d-%H-%M-%S"`
  cp -p ./docker-compose.yml ./old-ymls/${YML_FILE_NAME}
  echo "old docker-compose.yml was moved to ./old-ymls/${YML_FILE_NAME}"
fi

sed "s/sameersbn\/gitlab/ayapapa\/docker-gitlab/" \
    ./docker-gitlab/docker-compose.yml > ./docker-compose.yml

echo "remove temporary files..."
rm -fr docker-gitlab

echo "finished docker-gitlab build."
echo "modify docker-compose.yml if need, and then execute docker-compose up -d"
