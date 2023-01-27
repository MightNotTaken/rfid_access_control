#! /bin/sh
#! /usr/bin/electron
sleep 10
sudo systemctl stop rfidauth
sudo systemctl start rfidexit
electron /accesscontrol/frontend