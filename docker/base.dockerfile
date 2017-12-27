FROM ubuntu:16.04

# Needed for phantomjs to work (for running tests)
ENV QT_QPA_PLATFORM=offscreen 

RUN apt-get update -q
RUN apt-get install -y \
        ruby2.3 libruby2.3 ruby2.3-dev \
        libmagickwand-dev libxml2-dev libxslt1-dev nodejs \
        apache2 apache2-dev build-essential git-core \
        postgresql postgresql-contrib libpq-dev postgresql-server-dev-9.5 \
        libsasl2-dev imagemagick phantomjs \
 && gem2.3 install bundler

RUN mkdir /railsport
WORKDIR /railsport
COPY Gemfile /railsport/Gemfile
COPY Gemfile.lock /railsport/Gemfile.lock
RUN bundle install