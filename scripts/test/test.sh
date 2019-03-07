#! /bin/bash

. ./scripts/test/setup.sh

docker-compose -f ./infrastructure/docker-compose/docker-compose.yml -f ./infrastructure/docker-compose/docker-compose-dev.yml up -d
