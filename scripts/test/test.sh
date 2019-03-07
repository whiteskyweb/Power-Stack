#! /bin/bash

. ./scripts/test/setup.sh

docker-compose -f ./infrastructure/docker-compose/docker-compose.yml up -d
