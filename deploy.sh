#!/usr/bin/env bash

docker buildx create --use --name symfony_builder

docker buildx build \
    -t banderson/symfony \
    --platform=linux/arm64,linux/amd64 \
    --push .

docker buildx rm symfony_builder
