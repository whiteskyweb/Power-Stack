#! /bin/bash

. ./scripts/test/setup.sh

docker --version
docker-compose --version

# docker-compose -f ./infrastructure/docker-compose/docker-compose.yml -f ./infrastructure/docker-compose/docker-compose-dev.yml up -d
