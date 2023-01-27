#! /bin/sh
echo "building reader.c"
sudo gcc reader.c -lwiringPi -lpthread -lrt -o rfid_reader.o