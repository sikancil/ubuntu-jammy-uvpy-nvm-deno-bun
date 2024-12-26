#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    source .env
else
    echo "Error: .env file not found. Please copy .env.example to .env and fill in your Docker Hub credentials."
    exit 1
fi

# Check required variables
if [ -z "$DOCKER_USERNAME" ] || [ -z "$DOCKER_ACCESS_TOKEN" ]; then
    echo "Error: DOCKER_USERNAME and DOCKER_ACCESS_TOKEN must be set in .env file"
    echo ""
    echo "For Google OAuth users:"
    echo "1. Go to https://hub.docker.com/settings/security"
    echo "2. Click 'New Access Token'"
    echo "3. Give it a description (e.g., 'MyAccessToken')"
    echo "4. Select 'Read & Write' permissions"
    echo "5. Copy the generated token"
    echo "6. Paste it as DOCKER_ACCESS_TOKEN in your .env file"
    exit 1
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Login to Docker Hub using access token
echo "Logging in to Docker Hub..."
echo "$DOCKER_ACCESS_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin

if [ $? -ne 0 ]; then
    echo "Error: Failed to login to Docker Hub. Please check your credentials."
    echo "Make sure you're using an access token from https://hub.docker.com/settings/security"
    exit 1
fi

# Push the image to Docker Hub
echo "Pushing image to Docker Hub..."
docker push "$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG"

if [ $? -ne 0 ]; then
    echo "Error: Failed to push Docker image."
    docker logout
    exit 1
fi

# Logout from Docker Hub
docker logout

echo "Successfully pushed image: $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG"
