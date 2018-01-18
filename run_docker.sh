#!/bin/bash

if [ "$1" != "-p" ] && [ "$1" != "--nodb" ]; then
    docker rm -f osm-dev-db

    docker run -d \
            -e POSTGRES_PASSWORD=postgres \
            -v $(pwd)/pg_data:/var/lib/postgresql/data \
            --network osm_network \
            --name osm-dev-db \
            osm/rails-port-dev-db \

    sleep 5
fi

docker run --rm \
        $( [ "$1" = "-p" ] && printf %s '-e RAILS_ENV=production' ) \
        --network osm_network \
        --entrypoint="bundle" \
        --name osm-db-migrate \
        osm/rails-port-frontend exec rake db:migrate


if [ "$1" = "-p" ]; then
    if [ "$2" = "frontend" ]; then
        docker rm -f osm-frontend
        docker run -dit \
                --network osm_network \
                -p $3:80 \
                --name osm-frontend \
                osm/rails-port-frontend
    else
        docker rm -f osm-backend
        docker run -dit \
                --network osm_network \
                -p $3:80 \
                --name osm-backend \
                osm/rails-port-backend
    fi
else
    docker run --rm \
            --network osm_network \
            --entrypoint="bundle" \
            -p 3000:3000 \
            --name osm-dev-railsport \
            osm/rails-port-frontend exec rails server -b 0.0.0.0
fi