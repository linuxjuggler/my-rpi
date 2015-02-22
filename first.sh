!#/bin/bash

echo "## updating the system"
sudo -s
apt-get update && apt-get -y upgrade
rpi-update

echo "## We are going to reboot now"
reboot -n