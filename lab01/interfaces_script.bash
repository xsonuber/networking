#!/bin/bash
if [[ "$1" == "-e" ]]; then
echo -e "\033[1mYou chose: \033[0m"
echo "interface settings"
lspci | grep -i 'net'
sudo ethtool enp0s3 
else

#restoring settings
sudo dhclient -r
#echo default settings
echo -e "\033[1mSettings: \033[0m"
sudo echo "nameserver 192.168.0.1" | sudo tee /etc/resolv.conf
sudo ifconfig enp0s3
sudo route -n

#cases -a for "auto" (using dhcp), -s for "static" (user enters the settings) and * for the wrong flag case

echo -e "\033[1mYou chose: \033[0m"

case "$1" in
-a) echo "auto" 

echo -e "\033[1mSettings after changes: \033[0m"

sudo dhclient enp0s3
sudo cat /etc/resolv.conf
sudo ifconfig enp0s3
sudo route -n
;;

-s) echo "static" 

echo -e "\033[1mEnter IP: \033[0m"
read ip1
echo -e "\033[1mEnter netmask: \033[0m"
read mask1
echo -e "\033[1mEnter gateway: \033[0m"
read gateway1
echo -e "\033[1mEnter DNS: \033[0m"
read dns1

#changing settings

sudo ifconfig enp0s3 $ip1 netmask $mask1
sudo route add default gw $gateway1 enp0s3
echo -e "\033[1mSettings after changes: \033[0m"

sudo echo "nameserver $dns1" | sudo tee /etc/resolv.conf
sudo ifconfig enp0s3
sudo route -n
;;

*) echo "error" ;;
esac
fi
