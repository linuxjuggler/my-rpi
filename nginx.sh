#!/bin/sh

NGINX_VERSION=1.6.2
NGINX_URL=http://nginx.org/download/nginx-{$NGINX_VERSION}.tar.gz
HOME=/home/pi/my-pi


cd $HOME

echo "## Make sure the language is working"
sudo locale-gen en_GB.UTF-8
sudo locale-gen en_US.UTF-8


echo "## make sure we have the latest code"
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get dist-upgrade

echo "## Installing build library"
sudo apt-get install build-essential -y
sudo apt-get install libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev -y

echo "## Downloading nginx"
sudo mkdir $HOME/src
cd $HOME/src
sudo curl $NGINX_URL -o nginx.tar.gz
sudo tar zxf nginx.tar.gz

echo "## Configure nginx"
cd nginx-$NGINX_VERSION
sudo ./configure \
    --prefix=/usr \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/lock/nginx.lock \
    --with-http_ssl_module \
    --user=www-data \
    --group=www-data \
    --with-http_stub_status_module \
    --with-http_gzip_static_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module

echo "## Installing nginx"
sudo make && sudo make install

echo "## enable nginx service"
sudo cp $HOME/nginx_start /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo update-rc.d -f nginx defaults
#sudo mkdir /etc/nginx/{sites-available,sites-enabled}
sudo rm -fr $HOME/src

echo "## create the default site"
sudo cp $HOME/laravel /etc/nginx/sites-avaliable/laravel
sudo cd /etc/nginx/sites-enabled
sudo ln -s ../sites-avaliable/laravel

echo "## installing php"
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install php5-fpm php5-mcrypt php5-sqlite sqlite php5-cli php5-xcache php5-curl


echo "## Installing composer"
cd $HOME
curl -sS http://getcomposer.org/installer | php
sudo mv $HOME/composer.phar /usr/local/bin/composer
sudo chown pi:pi  /usr/local/bin/composer

echo "## Creating the web directory"
cd /var
sudo mkdir www
sudo chown -R pi:pi www
cd www
/usr/local/bin/composer create-project laravel/laravel --prefer-dist

echo "## restarting nginx"
sudo service nginx restart

echo "## installing avahi-daemon"
sudo apt-get install -y avahi-daemon
