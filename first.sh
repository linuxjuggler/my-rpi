#!/bin/sh

SWAP_SIZE=512
STATIC_IP=192.168.1.27
HOSTNAME=zaherpi2
HOME_DIR=/home/pi/my-pi

echo "## Change the resolv.conf to use google DNS"
sudo echo "nameserver 8.8.8.8" > /etc/resolv.conf
sudo echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo "## Change the hostname"
sudo echo $HOSTNAME > /etc/hostname
sudo /etc/init.d/hostname.sh restart

echo "## Updating the system"
sudo apt-get update && apt-get -y upgrade
sudo rpi-update

echo "## Change the swap size"
sudo echo CONF_SWAPSIZE=$SWAP_SIZE > /etc/dphys-swapfile
sudo dphys-swapfile setup

echo "## Change the interfaces to static one"
sudo rm /etc/network/interfaces
sudo cp $HOME_DIR/interfaces /etc/network/interfaces
sudo sed -i 's/192.168.1.27/{$STATIC_IP}/' /etc/network/interfaces

echo "## We are going to reboot now"
sudo reboot -n