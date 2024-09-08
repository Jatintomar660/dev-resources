#!/bin/bash

# This script sets up and starts a code-server container using docker-compose.
# It handles setting up user permissions and moving extensions.

cleanup() {
    echo "Cleaning up existing code-server directory..."
    sudo rm -rf code-server
    docker rm -f code-server-$USER
}

setup_environment() {
    echo "Setting up environment variables..."
    export PUID=$(id -u)
    export PGID=$(id -g)
    echo "PUID set to $PUID"
    echo "PGID set to $PGID"
}

start_docker_compose() {
    echo "Starting docker-compose..."
    docker compose up -d || {
        echo "Docker-compose failed to start"
        exit 1
    }
}

move_extensions() {
    echo "Moving extensions to ./code-server/config/extensions..."

    docker exec code-server-${USER} tar -xf /home/extensions.gz -C /home || {
        echo "Failed to extract extensions"
        exit 1
    }

    echo "extracted extensions.gz"
    sleep 10 # Waiting for any necessary operations to complete before moving

    docker exec code-server-${USER} [ -d /home/extensions ] || {
        echo "/home/extensions does not exist."
        exit 1
    }

    echo "removing /config/extensions..."
    docker exec code-server-${USER} rm -rf /config/extensions || {
        echo "Failed to remove existing extensions directory"
        exit 1
    }
    echo "moving /home/extensions to /config/..."
    docker exec code-server-${USER} mv /home/extensions /config/ || {
        echo "Failed to move extensions"
        exit 1
    }

}

cleanup
setup_environment
start_docker_compose
move_extensions

echo "Script completed successfully."