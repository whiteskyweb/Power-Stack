#!/bin/bash
. ./scripts/misc/globals.sh

printf "${GREEN}Installing backend packages${NC}\n"
cd backend-code
COMPOSER_PROCESS_TIMEOUT=2000 composer install --prefer-dist --no-dev

printf "${GREEN}Installing frontend packages${NC}\n"
cd ../frontend-code
npm install