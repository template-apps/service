#!/bin/bash

# Example: ./rebuildAndPush.sh -r localhost:5500 -n apps-template -v latest -p linux/x86_64
# Example: ./rebuildAndPush.sh -r 881387567440.dkr.ecr.us-east-1.amazonaws.com -n apps-template -v 0.1 -p linux/x86_64

ARCH=""

while getopts "r:n:v:p:" opt; do
    case $opt in
        r) REGISTRY="$OPTARG";;
        n) NAMESPACE="$OPTARG";;
        v) VERSION="$OPTARG";;
        p) ARCH="$OPTARG";;
        \?) echo "Usage: $0 -r <registry> -n <namespace> -v <version> [-p <architecture>]"
            exit 1
        ;;
    esac
done

# Check if all required parameters are provided
if [ -z "$REGISTRY" ] || [ -z "$NAMESPACE" ] || [ -z "$VERSION" ]; then
    echo "Usage: $0 -r <registry> -n <namespace> -v <version> [-p <architecture>]"
    exit 1
fi

SERVICE="$(basename "$PWD")"
REPOSITORY="$REGISTRY/$NAMESPACE-$SERVICE:$VERSION"
JRE_IMAGE_URI="$REGISTRY/$NAMESPACE-custom-jre-20:0.1"

./gradlew clean build
echo ">>> Compilation done"

# Remove existing images/containers based on the repository
docker image rm "$(docker images -q "$REPOSITORY")" 2>/dev/null
echo ">>> Existing Images/Containers Deleted"

# Build the Docker image
if [ -z "$ARCH" ]; then
    docker build --no-cache --build-arg JRE_IMAGE_URI="$JRE_IMAGE_URI" --build-arg SERVICE="$SERVICE" -t "$REPOSITORY" .
else
    docker build --no-cache --build-arg JRE_IMAGE_URI="$JRE_IMAGE_URI" --build-arg SERVICE="$SERVICE" --platform "$ARCH" -t "$REPOSITORY" .
fi
echo ">>> New Docker Image Built"

# Tag the Docker image
docker tag "$REPOSITORY" "$REPOSITORY"
echo ">>> New Docker Image Tagged"

# Push the Docker image to the registry
docker push "$REPOSITORY"
echo ">>> New Docker Image Pushed to $REGISTRY"
