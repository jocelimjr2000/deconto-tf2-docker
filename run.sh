#!/bin/bash

# Check .env exists
if [ -f .env ]
then

    # Get all variables
    export $(cat .env | sed 's/#.*//g' | xargs)

    # Create Network Project if not exists
    docker network ls|grep $DEFAULT_NETWORK_NAME > /dev/null || docker network create --driver bridge $DEFAULT_NETWORK_NAME

    shopt -s nullglob
    for file in *.yml *.yaml; do
        docker-compose -f "$file" up --build -d

        sleep 5
    done

    # List Containers
    docker ps -a 

fi
