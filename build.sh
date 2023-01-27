#! /bin/sh
echo "building reader.c"
sudo gcc "./backend/reader.c" -lwiringPi -lpthread -lrt -o "./backend/rfid_reader.o"