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
    exit 1
fi

# Get repository name from DOCKER_IMAGE_NAME
REPO_NAME=$(echo "$DOCKER_IMAGE_NAME" | cut -d'/' -f2)

# Read description files
if [ ! -f DESCRIPTION.txt ] || [ ! -f DOCKERHUB.md ]; then
    echo "Error: DESCRIPTION.txt and/or DOCKERHUB.md not found"
    exit 1
fi

USE_DENO=false
# Create JSON payload using either Deno or Node.js
if [ "$USE_DENO" = "true" ]; then
    echo "Using Deno to create JSON payload..."
    JSON_PAYLOAD=$(deno eval --allow-read '
    const shortDesc = await Deno.readTextFile("DESCRIPTION.txt");
    const fullDesc = await Deno.readTextFile("DOCKERHUB.md");

    const payload = {
      description: shortDesc.trim(),
      full_description: fullDesc,
    };

    console.log(JSON.stringify(payload));
    ')
else
    echo "Using Node.js to create JSON payload..."
    JSON_PAYLOAD=$(node -e '
    const fs = require("fs");
    const shortDesc = fs.readFileSync("DESCRIPTION.txt", "utf8");
    const fullDesc = fs.readFileSync("DOCKERHUB.md", "utf8");

    const payload = {
      description: shortDesc.trim(),
      full_description: fullDesc,
    };

    console.log(JSON.stringify(payload));
    ')
fi

# Update Docker Hub repository description
echo "Updating Docker Hub repository description..."
RESPONSE=$(curl -s -X PATCH \
    -H "Content-Type: application/json" \
    -H "Authorization: JWT $DOCKER_ACCESS_TOKEN" \
    -d "$JSON_PAYLOAD" \
    "https://hub.docker.com/v2/repositories/$DOCKER_USERNAME/$REPO_NAME/")

if echo "$RESPONSE" | grep -q "error\|message"; then
    echo "Failed to update Docker Hub repository description"
    echo "Response: $RESPONSE"
    exit 1
else
    echo "Successfully updated Docker Hub repository description"
    exit 0
fi
