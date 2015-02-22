#!/bin/sh

RESTHINKDB_VERSION=1.16.2-1

echo "## Installing the libraries"
sudo apt-get install g++ protobuf-compiler libprotobuf-dev libboost-dev curl m4 wget

echo "## Downloading rethinkdb archive"
mkdir src
cd src
wget -c http://download.rethinkdb.com/dist/rethinkdb-{$RESTHINKDB_VERSION}.tgz
tar xf rethinkdb-{$RESTHINKDB_VERSION}.tgz

cd rethinkdb-$RESTHINKDB_VERSION
./configure --with-system-malloc --allow-fetch

echo "## now executing make && make install"
make && sudo make install