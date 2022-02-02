#!/bin/bash
docker-compose pull app
docker-compose up --remove-orphans --force-recreate -d app
