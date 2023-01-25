import os

if __name__ == "__main__":
    os.system("gcc -lpthread -lwiringPi -lrt ./backend/reader.c -o ./backend/rfid_reader.o")