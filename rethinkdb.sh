#!/bin/sh

RESTHINKDB_VERSION=1.16.2-1

echo "## Installing the libraries"
sudo apt-get install g++ protobuf-compiler libprotobuf-dev libboost-dev curl m4 wget

echo "## Downloading rethinkdb archive"
mkdir src
cd src
wget -c http://download.rethinkdb.com/dist/rethinkdb-$RESTHINKDB_VERSION.tgz
tar zxf rethinkdb-$RESTHINKDB_VERSION.tgz


echo "## sadly need to do everyting manually"

#cd rethinkdb-$RESTHINKDB_VERSION
#./configure --with-system-malloc --allow-fetch

#echo "## now executing make && make install"
#make && sudo make install

#echo "## installing the javascript client"
#npm install rethinkdb

#echo "## cleanup everything"
#cd ../../
#sudo rm -fr src

#echo "Do you wish to install Laravel Package for rethinkdb ? Yes|No, followed by [ENTER]: "

#read laravel

#if (("$laravel"  == "yes") || ("$laravel"  == "Yes") || ("$laravel"  == "YES") || ("$laravel"  == "y")); then

#    echo "Enter the path for your Laravel installation: ex: /var/www/laravel : "
#    read laravel_path

#    echo "## installing the driver"
#    cd $laravel_path
#    composer require "duxet/laravel-rethinkdb:dev-master"
#    composer update

#    echo "## back to the user home directory"
#    cd
#fi