#! /bin/bash

. ./scripts/misc/setup.sh

cat << "EOF"

    ____                             _____ __             __      ____  _______    __
   / __ \____ _      _____  _____   / ___// /_____ ______/ /__   / __ \/ ____/ |  / /
  / /_/ / __ \ | /| / / _ \/ ___/   \__ \/ __/ __ `/ ___/ //_/  / / / / __/  | | / /
 / ____/ /_/ / |/ |/ /  __/ /      ___/ / /_/ /_/ / /__/ ,<    / /_/ / /___  | |/ /
/_/    \____/|__/|__/\___/_/      /____/\__/\__,_/\___/_/|_|  /_____/_____/  |___/

EOF

printf "\n"

echo version ${VERSION}

printf "\n"

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