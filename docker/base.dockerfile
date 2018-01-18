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

RUN apt-get install -y dirmngr gnupg
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
RUN apt-get install -y apt-transport-https ca-certificates
RUN echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list
RUN apt-get update
RUN apt-get install -y libapache2-mod-passenger

RUN mkdir /railsport
WORKDIR /railsport
COPY Gemfile /railsport/Gemfile
COPY Gemfile.lock /railsport/Gemfile.lock
RUN bundle install

RUN apt-get install -y libpqxx-dev libfcgi-dev \
        libboost-dev libboost-regex-dev libboost-program-options-dev \
        libboost-date-time-dev libboost-filesystem-dev \
        libboost-system-dev libboost-locale-dev libmemcached-dev \
        libcrypto++-dev automake autoconf libtool libyajl-dev

WORKDIR /