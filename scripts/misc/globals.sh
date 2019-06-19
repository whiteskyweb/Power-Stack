#! /bin/bash

export NC='\033[0m' # No Color
export GREEN_BG='\033[42m'
export GREEN='\033[0;32m'


if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi


if [ ! -z "$BUILD_VARS" ]
then
  echo $BUILD_VARS | base64 -d > ./.env
fi


cat << "EOF"

    ____                             _____ __             __
   / __ \____ _      _____  _____   / ___// /_____ ______/ /__
  / /_/ / __ \ | /| / / _ \/ ___/   \__ \/ __/ __ `/ ___/ //_/
 / ____/ /_/ / |/ |/ /  __/ /      ___/ / /_/ /_/ / /__/ ,<
/_/    \____/|__/|__/\___/_/      /____/\__/\__,_/\___/_/|_|


EOF
