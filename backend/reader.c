/*
 * linked with -lpthread -lwiringPi -lrt
 */

#include <stdio.h>
#include <stdlib.h>
#include <wiringPi.h>
#include <time.h>
#include <unistd.h>
#include <memory.h>
#include <unistd.h>
#include <string.h>


int PIN_0 = 0;
int PIN_1 = 1;

#define MAXWIEGANDBITS 26
#define READERTIMEOUT 3000000
#define LEN 256

static unsigned char __wiegandData[MAXWIEGANDBITS];
static unsigned long __wiegandBitCount;
static struct timespec __wiegandBitTime;


char* outputDirectory;
char* parentDirectory;

void getData0(void) {
    if (__wiegandBitCount / 8 < MAXWIEGANDBITS) {
        __wiegandData[__wiegandBitCount / 8] <<= 1;
        __wiegandBitCount++;
    }
    clock_gettime(CLOCK_MONOTONIC, &__wiegandBitTime);
}

void getData1(void) {
    if (__wiegandBitCount / 8 < MAXWIEGANDBITS) {
        __wiegandData[__wiegandBitCount / 8] <<= 1;
        __wiegandData[__wiegandBitCount / 8] |= 1;
        __wiegandBitCount++;
    }
    clock_gettime(CLOCK_MONOTONIC, &__wiegandBitTime);
}

int wiegandInit(int d0pin, int d1pin) {
    // Setup wiringPi
    wiringPiSetup() ;
    pinMode(d0pin, INPUT);
    pinMode(d1pin, INPUT);

    wiringPiISR(d0pin, INT_EDGE_FALLING, getData0);
    wiringPiISR(d1pin, INT_EDGE_FALLING, getData1);
}

void wiegandReset() {
    memset((void *)__wiegandData, 0, MAXWIEGANDBITS);
    __wiegandBitCount = 0;
}

int wiegandGetPendingBitCount() {
    struct timespec now, delta;
    clock_gettime(CLOCK_MONOTONIC, &now);
    delta.tv_sec = now.tv_sec - __wiegandBitTime.tv_sec;
    delta.tv_nsec = now.tv_nsec - __wiegandBitTime.tv_nsec;

    if ((delta.tv_sec > 1) || (delta.tv_nsec > READERTIMEOUT))
        return __wiegandBitCount;

    return 0;
}

int wiegandReadData(void* data, int dataMaxLen) {
    if (wiegandGetPendingBitCount() > 0) {
        int bitCount = __wiegandBitCount;
        int byteCount = (__wiegandBitCount / 8) + 1;
        memcpy(data, (void *)__wiegandData, ((byteCount > dataMaxLen) ? dataMaxLen : byteCount));

        wiegandReset();
        return bitCount;
    }
    return 0;
}



void joinInto(char** path, char* p1, char* p2) {
    int size = strlen(p1) + strlen(p2);
    *path = (char*)malloc(sizeof(char) * size);
#if defined(_WIN32) || defined(_WIN64)
    sprintf(*path, "%s\\%s", p1, p2);
#else
    sprintf(*path, "%s/%s", p1, p2);
#endif
}

void initialize(int argc, char** argv) {
    sscanf(argv[1], "%d", &PIN_0);
    sscanf(argv[2], "%d", &PIN_1);
    getcwd(parentDirectory, sizeof(parentDirectory));

    parentDirectory = (char *)malloc(200 * sizeof(char));
    getcwd(parentDirectory, 200);
    outputDirectory = (char *)malloc(strlen(parentDirectory) + strlen(argv[3]));
    joinInto(&outputDirectory, parentDirectory, argv[3]);
}

void accomodateInto(char** container, char* data, int bytes) {
    int i;
    *container = (char *)malloc(sizeof(char) * 2 * bytes + 1);
    sprintf(*container, "");
    for (i = 0; i < bytes; i++) {
        sprintf(*container, "%s%02X", *container, (int)data[i]);
    }
}


int main(int argc, char** argv) {
    int i;
    initialize(argc, argv);

    wiegandInit(PIN_0, PIN_1);
    while(1) {
        int bitLen = wiegandGetPendingBitCount();
        if (bitLen == 0) {
            usleep(5000);
        } else {
            char data[100];
            char* path;
            FILE *fp;
            char* rfid;
            int bytes;
            bitLen = wiegandReadData((void *)data, 100);
            bytes = bitLen / 8 + 1;
            accomodateInto(&rfid, data, bytes);
            joinInto(&path, outputDirectory, rfid);
            fp = fopen(path, "w");
            if (fp) {
                fclose(fp);
            }
        }
    }
}
