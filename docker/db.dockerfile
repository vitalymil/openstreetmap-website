FROM postgres:9.5.10
RUN apt-get update -q
RUN apt-get install -y postgresql-server-dev-9.5 build-essential postgresql-9.5-postgis-2.2
COPY ./db/functions /railsport/db/functions
COPY ./lib/quad_tile /railsport/lib/quad_tile
WORKDIR /railsport/db/functions
RUN make clean
RUN make
COPY ./db/create_db.sh /docker-entrypoint-initdb.d/create_db.sh
