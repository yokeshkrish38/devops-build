#!/bin/bash

export IMAGE_NAME=$1
export TAG=latest

docker compose down || true
docker compose up -d

