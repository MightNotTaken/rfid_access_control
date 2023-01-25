#! /bin/sh
#! /usr/bin/python3

sleep 1
sudo systemctl stop rfidexit.service
sudo /accesscontrol/backend/rfid_reader.o 0 1 authorized
