#!/bin/bash
# Publish docker image to docker hub
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters, imagename as arg"
fi
set -e
IMAGE_NAME=$1

VERSION=`grep AppVersion BuildInfo.properties | awk -F'=' '{print $2}'`
DOCKER_CLOUD_USER=`grep -e 'user =' ~/.docker-cloud  | awk '{print $3}'`

# TODO remove debug print
echo In publish_docker.sh:
echo DOCKER_CLOUD_USER: $DOCKER_CLOUD_USER
echo IMAGE_NAME: $IMAGE_NAME
echo VERSION: $VERSION

docker tag ${IMAGE_NAME}:${VERSION} ${DOCKER_CLOUD_USER}/${IMAGE_NAME}:${VERSION}
docker push ${DOCKER_CLOUD_USER}/${IMAGE_NAME}:${VERSION}
