FROM osm/rails-port-base
COPY . /railsport
COPY apache.frontend /etc/apache2/sites-available/apache.frontend.conf
RUN a2ensite apache.frontend.conf
RUN a2enmod alias expires headers proxy_http proxy_balancer \
    lbmethod_byrequests lbmethod_bybusyness rewrite unique_id

WORKDIR /railsport
RUN bundle exec rake assets:precompile

WORKDIR /railsport/lib/quad_tile
RUN ruby extconf.rb
RUN make

WORKDIR /railsport

ENTRYPOINT service apache2 start && bash