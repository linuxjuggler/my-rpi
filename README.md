# About : 

this is a personal experimental project, plus its a way for me to learn more and try to make something good from the tools I have.

if you can help, feel free to fork -> update then send a PR .

# Notes to myself:

#changing to startic ip
cd /etc/network

sudo nano interfaces

#replace the line “iface eth0 inet dhcp” with

iface eth0 inet static
address 192.168.1.4
netmask 255.255.255.0
gateway 192.168.1.1


#check resolve.conf
sudo nano /etc/resolve.conf

nameserver 192.168.1.1

#edit nginx.conf and add the following
include /etc/nginx/sites-enabled/*;

1. remember to copy the default config from tipsy site since yuo have it there.
1. remember to change the default user & group for fpm
1. remember to change the hostname to `zahertest.local`
1. try to see how `seed` work

## Links:

* compiling nginx has been taken from [http://lowpowerlab.com/blog/2013/10/07/raspberrypi-home-automation-gateway-setup/](http://lowpowerlab.com/blog/2013/10/07/raspberrypi-home-automation-gateway-setup/)
* Precompiled Nodejs 0.12.0 has been downloaded from [http://conoroneill.net//download-compiled-version-of-nodejs-0120-stable-for-raspberry-pi-here](http://conoroneill.net//download-compiled-version-of-nodejs-0120-stable-for-raspberry-pi-here)


## last note:

am so thankful for those who provides those tuts and precompiled packages.
