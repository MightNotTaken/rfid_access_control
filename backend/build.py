import os

if __name__ == '__main__':
    os.system('gcc -lpthread -lwiringPi -lrt reader.c -o rfid_reader')