FROM java:8
RUN apt-get update -qq
RUN apt-get install -y wget osm2pgsql
RUN wget http://bretth.dev.openstreetmap.org/osmosis-build/osmosis-latest.tgz
RUN mkdir osmosis
RUN mv osmosis-latest.tgz osmosis
WORKDIR /osmosis
RUN tar xvfz osmosis-latest.tgz
RUN rm osmosis-latest.tgz
ADD ./replicator /replicator
RUN mv /replicator/rep-cron /etc/cron.d
RUN chmod 0644 /etc/cron.d/rep-cron
RUN chmod 777 /replicator/replicate.sh
CMD cron && /replicator/replicate.sh