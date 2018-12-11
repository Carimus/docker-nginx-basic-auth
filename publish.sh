#!/usr/bin/env bash

set -e

echo "Building image for alpine-1.14:"

docker build -t carimus/nginx-basic-auth:alpine-1.14 \
  -f ./alpine-1.14/Dockerfile \
  .

echo

echo "Building image for alpine-1.15 (default image):"

docker build -t carimus/nginx-basic-auth:alpine-1.15 \
  -t carimus/nginx-basic-auth:latest \
  -f ./alpine-1.15/Dockerfile \
  .

echo

echo "Pushing images to docker hub:"

docker push carimus/nginx-basic-auth:alpine-1.14
docker push carimus/nginx-basic-auth:alpine-1.15
docker push carimus/nginx-basic-auth:latest

echo

echo "Done"
