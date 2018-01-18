#!/bin/bash

docker build --force-rm --no-cache -f ./docker/base.dockerfile -t osm/rails-port-base .
docker build --force-rm --no-cache -f ./docker/db.dockerfile -t osm/rails-port-dev-db .