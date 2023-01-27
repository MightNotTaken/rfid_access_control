#! /bin/sh
echo "building reader.c"
sudo gcc ./build/reader.c -lwiringPi -lpthread -lrt -o ./build/rfid_reader.o