#! /bin/bash

. ./scripts/misc/setup.sh


if hash docker 2>/dev/null; then

  printf "\n${GREEN_BG}Stopping your development containers...${NC}\n\n"

  set +x
    docker-compose -f ./infrastructure/docker-compose/docker-compose.yml -f ./infrastructure/docker-compose/docker-compose-dev.yml down

  printf "\n${GREEN_BG}Done${NC}\n\n"

else
  echo >&2 "I require docker but it's not installed.  Aborting.";
fi