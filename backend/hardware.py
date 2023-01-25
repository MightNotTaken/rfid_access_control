import RPi.GPIO as GPIO
import time
from enum import Enum

SWITCH_LOGIC = 1

LED_Indicator_01_GPIO = 22
LED_Indicator_02_GPIO = 25
LED_Indicator_03_GPIO = 16

Switch_01_GPIO        = 5
Switch_02_GPIO        = 6

class IndicationMode(Enum):
    INDEFINITE =   0
    FOR_DURATION = 1

def millis():
    return int(round(time.time() * 1000))


class Switch:
    def __init__(self, gpio):
        self.gpio = gpio
        self.last_state = not SWITCH_LOGIC
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(self.gpio, GPIO.IN)

    def pressed(self):
        current_state = GPIO.input(self.gpio)
        if current_state == SWITCH_LOGIC and self.last_state != current_state:
            self.last_state = current_state
            return True
        self.last_state = current_state
        return False



class Indicator:
    def __init__(self, gpio, mode = IndicationMode.INDEFINITE):
        self.gpio = gpio
        self.duration = 0
        self.starttime = 0
        self.mode = mode
        self.state = GPIO.LOW
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(self.gpio, GPIO.OUT)
        self.turn_off()

    def glow(self, duration = 0):
        if self.mode == IndicationMode.FOR_DURATION:
            self.duration = duration
            self.starttime = millis()
        if self.state != GPIO.HIGH:
            self.state = GPIO.HIGH
            GPIO.output(self.gpio, GPIO.HIGH)

    def turn_off(self):
        self.state = GPIO.LOW
        GPIO.output(self.gpio, GPIO.LOW)

    def update(self):
        if self.mode == IndicationMode.FOR_DURATION:
            if millis() - self.starttime > self.duration and self.state == GPIO.HIGH:
                self.turn_off()


indicator_01 = Indicator(LED_Indicator_01_GPIO, IndicationMode.FOR_DURATION)
indicator_02 = Indicator(LED_Indicator_02_GPIO, IndicationMode.FOR_DURATION)
indicator_03 = Indicator(LED_Indicator_03_GPIO, IndicationMode.INDEFINITE)

switch_01 = Switch(Switch_01_GPIO)
switch_02 = Switch(Switch_02_GPIO)