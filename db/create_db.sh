#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
    CREATE DATABASE dev;
    CREATE DATABASE test;
    CREATE DATABASE dev_gis;
EOSQL

psql -v ON_ERROR_STOP=1 --username postgres -d dev <<-EOSQL
    CREATE EXTENSION btree_gist;
    CREATE FUNCTION maptile_for_point(int8, int8, int4) RETURNS int4 AS '/railsport/db/functions/libpgosm', 'maptile_for_point' LANGUAGE C STRICT;
    CREATE FUNCTION tile_for_point(int4, int4) RETURNS int8 AS '/railsport/db/functions/libpgosm', 'tile_for_point' LANGUAGE C STRICT;
    CREATE FUNCTION xid_to_int4(xid) RETURNS int4 AS '/railsport/db/functions/libpgosm', 'xid_to_int4' LANGUAGE C STRICT;
EOSQL

psql -v ON_ERROR_STOP=1 --username postgres -d test <<-EOSQL
    CREATE EXTENSION btree_gist;
    CREATE FUNCTION maptile_for_point(int8, int8, int4) RETURNS int4 AS '/railsport/db/functions/libpgosm', 'maptile_for_point' LANGUAGE C STRICT;
    CREATE FUNCTION tile_for_point(int4, int4) RETURNS int8 AS '/railsport/db/functions/libpgosm', 'tile_for_point' LANGUAGE C STRICT;
    CREATE FUNCTION xid_to_int4(xid) RETURNS int4 AS '/railsport/db/functions/libpgosm', 'xid_to_int4' LANGUAGE C STRICT;
EOSQL

psql -v ON_ERROR_STOP=1 --username postgres -d dev_gis <<-EOSQL
    CREATE EXTENSION postgis;
    CREATE EXTENSION hstore;
EOSQL