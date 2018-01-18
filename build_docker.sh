#!/bin/bash

docker build -f ./docker/frontend.dockerfile -t osm/rails-port-frontend .
docker build -f ./docker/backend.dockerfile -t osm/rails-port-backend .