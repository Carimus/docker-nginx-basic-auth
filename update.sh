#!/usr/bin/env bash

set -e

mkdir -p ./alpine-1.14/
mkdir -p ./alpine-1.15/

sed 's/FROM nginx:alpine/FROM nginx:1.14-alpine/' < ./Dockerfile.template > ./alpine-1.14/Dockerfile
sed 's/FROM nginx:alpine/FROM nginx:1.15-alpine/' < ./Dockerfile.template > ./alpine-1.15/Dockerfile
