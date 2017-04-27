#!/bin/sh
mongo admin /setup/create-admin.js
mongo admin /setup/create-user.js -u admin -p admin --authenticationDatabase admin
