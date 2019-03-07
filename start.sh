#! /bin/bash

. scripts/misc/globals.sh

if hash docker 2>/dev/null; then

  printf "\n${GREEN_BG}Starting your development containers...${NC}\n\n"

  set +x

  docker-compose -f ./infrastructure/docker-compose/docker-compose.yml -f ./infrastructure/docker-compose/docker-compose-dev.yml up -d

  printf "\n${GREEN_BG}Done${NC}\n\n"

  printf "\nVisit your backend at: http://${API_HOST}/\n"

  printf "\nVisit your frontend at: http://${HOST}:8080/\n\n"

else
  echo >&2 "I require docker but it's not installed.  Aborting.";
fi