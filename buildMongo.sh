#!/bin/sh
docker exec db_mongodb  mongo admin /setup/create-admin.js
docker exec db_mongodb mongo admin /setup/create-user.js -u admin -p admin --authenticationDatabase admin