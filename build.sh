#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    source .env
else
    echo "Error: .env file not found. Please copy .env.example to .env and fill in your Docker Hub credentials."
    exit 1
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Build the Docker image
echo "Building Docker image..."
docker build -t "$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG" .

if [ $? -ne 0 ]; then
    echo "Error: Failed to build Docker image."
    exit 1
fi

echo "Successfully built image: $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG"
