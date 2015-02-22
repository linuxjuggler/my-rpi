!#/bin/bash

SWAP_SIZE=512
STATIC_IP=192.168.1.27
HOSTNAME=zaherpi2

sudo -s
echo "## Change the resolve.conf to use google DNS"
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

echo "## Change the hostname"
echo $HOSTNAME > /etc/hostname
/etc/init.d/hostname.sh restart

echo "## Updating the system"
apt-get update && apt-get -y upgrade
rpi-update

echo "## Change the swap size"
echo CONF_SWAPSIZE=$SWAP_SIZE > /etc/dphys-swapfile
dphys-swapfile setup

echo "## Change the interfaces to static one"
rm /etc/network/interfaces
cp $HOME_DIR/interfaces /etc/network/interfaces
sed -i 's/192.168.1.27 /{$STATIC_IP}/' /etc/network/interfaces

echo "## We are going to reboot now"
reboot -n