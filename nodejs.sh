#!/bin/sh

NODE_VERSION=v0.12.0
NODE_JS=https://s3-eu-west-1.amazonaws.com/conoroneill.net/wp-content/uploads/2015/02/node-{$NODE_VERSION}-linux-arm-pi.tar.gz


echo "# Compiling and Installing nodejs on this Raspberry Pi..."
echo "This may take up to two hours."

echo "## Downloading nodejs"
curl $NODE_JS -o /tmp/nodejs.tar.gz

echo "## extracting nodejs ... this will take a while"
cd /tmp && tar zxvf nodejs.tar.gz
rm -f nodejs.tar.gz


echo "## Installing nodejs .."
cd node-$NODE_VERSION-linux-arm-pi
sudo cp -R * /usr/local/
