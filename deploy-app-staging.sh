#!/bin/bash
docker-compose pull app-staging
docker-compose up --remove-orphans --force-recreate -d app-staging
