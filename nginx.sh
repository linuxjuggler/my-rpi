#!/bin/sh

NGINX_VERSION=1.6.2
NGINX_URL=http://nginx.org/download/nginx-{$NGINX_VERSION}.tar.gz
HOME_DIR=/home/pi/my-pi
LOCAL_ADDRESS=zaherpi2.lcoal
LOCAL_IP=192.168.1.27


cd $HOME_DIR

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
mkdir $HOME_DIR/src
cd $HOME_DIR/src
curl $NGINX_URL -o nginx.tar.gz
tar zxf nginx.tar.gz

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
make && sudo make install

echo "## enable nginx service"
sudo cp $HOME_DIR/nginx_start /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo update-rc.d -f nginx defaults
sudo mkdir /etc/nginx/{sites-available,sites-enabled}
sudo rm -f /etc/nginx/nginx.conf
sudo cp $HOME_DIR/nginx.conf /etc/nginx/nginx.conf
sudo rm -fr $HOME_DIR/src

echo "## create the default site"
sudo cp $HOME_DIR/laravel /etc/nginx/sites-available/laravel
sudo sed -i 's/zaherpi2.local/{$LOCAL_ADDRESS}/' /etc/nginx/sites-available/laravel
sudo sed -i 's/192.168.1.27/{$LOCAL_IP}/' /etc/nginx/sites-available/laravel
cd /etc/nginx/sites-enabled
sudo ln -s ../sites-available/laravel

echo "## installing php"
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install php5-fpm php5-mcrypt php5-sqlite sqlite php5-cli php5-xcache php5-curl


echo "## Installing composer"
cd $HOME_DIR
curl -sS http://getcomposer.org/installer | php
sudo mv $HOME_DIR/composer.phar /usr/local/bin/composer
sudo chown pi:pi  /usr/local/bin/composer

echo "## Creating the web directory"
cd /var
sudo mkdir www
sudo chown -R pi:pi www
cd www
/usr/local/bin/composer create-project laravel/laravel --prefer-dist
chown pi:pi  /var/www/laravel

echo "## restarting nginx"
sudo service nginx restart

echo "## installing avahi-daemon"
sudo apt-get install -y avahi-daemon
