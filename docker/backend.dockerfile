FROM osm/rails-port-base

COPY . /railsport

# Need to remove proxy config and change url to local Gitlab
RUN git clone https://github.com/openstreetmap/cgimap.git

WORKDIR /cgimap
RUN ./autogen.sh
RUN ./configure
RUN make

COPY apache.backend /etc/apache2/sites-available/apache.backend.conf
RUN a2ensite apache.backend.conf
RUN a2enmod rewrite proxy remoteip proxy_fcgi setenvif

WORKDIR /railsport
RUN bundle exec rake assets:precompile

WORKDIR /railsport/lib/quad_tile
RUN ruby extconf.rb
RUN make

WORKDIR /railsport

CMD service apache2 start && /cgimap/openstreetmap-cgimap --daemon --socket :8000 --host osm-dev-db --dbname dev --username postgres --password postgres --pidfile cgimap.pid --logfile cgimap.log && bash