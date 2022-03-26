#!/bin/bash
docker-compose pull server
docker-compose up --remove-orphans --force-recreate -d server
docker image prune -a -f
