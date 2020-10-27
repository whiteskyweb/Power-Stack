![Power Stack Logo](https://i.imgur.com/TZmwxww.png)

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/067c31a35eec4e348dcef717a7aff582)](https://www.codacy.com/app/xaviemirmon/Power-Stack?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=xaviemirmon/Power-Stack&amp;utm_campaign=Badge_Grade)
[![pipeline status](https://gitlab.com/travel-nation/power-stack/badges/master/pipeline.svg)](https://gitlab.com/travel-nation/power-stack/commits/master)
[![Netlify Status](https://api.netlify.com/api/v1/badges/c81828e6-617d-4884-9c61-09049754f036/deploy-status)](https://app.netlify.com/sites/power-stack-prod/deploys)

The Power Stack is a collection of all the best technologies providing you 
with boilerplate to get a modern API-based containerised web app up and 
running in no time. This code has been setup to try and adhere to the 12-factor principles wherever possible. This repo gives you access to the 
following micro-service based architecture:

  - Frontend
    - Gatsby (React)
  - Backend 
    - Drupal 8 (PHP)
  - Database
    - MySQL
  - Caching
    - Redis
    
## Hosting

<p align="center">
<a href="https://console.platform.sh/projects/create-project?template=https://github.com/whiteskyweb/Power-Stack.git&utm_content=whiteskyweb_power_stack&utm_source=github&utm_medium=button&utm_campaign=deploy_on_platform">
    <img src="https://platform.sh/images/deploy/lg-blue.svg" alt="Deploy on Platform.sh" width="180px" />
</a>
</p>

## Requirements

  - Docker
  - Docker Compose
  - NPM

## Installation

The installation is quite time consuming so you will need to up your process timeout as follows:

`composer --global config process-timeout 2000`

Then install:

`composer create-project white-sky-web/power-stack power-stack --no-interaction`


Browser testing kindly provided by [<img src="https://i.imgur.com/qMhoqZP.png" width="100">](https://www.browserstack.com/) 
