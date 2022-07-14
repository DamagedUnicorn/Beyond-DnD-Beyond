#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul  7 17:39:20 2022

@author: thorknudsen
"""

import serial
import time

class SerialCommunication:
    
    def __init__(self, port, baudRate):
        self.port = port
        self.baudRate = baudRate
        self.isConnected = True
        try:
            self.ser = serial.Serial(self.port, self.baudRate)
        except:
            self.isConnected = False

    def readData(self, gui):
        # https://stackoverflow.com/questions/17553543/pyserial-non-blocking-read-loop
        isDataGood = False
        if (self.ser.inWaiting() > 0):
            data = self.ser.read(self.ser.inWaiting()).decode('ascii')
            try:
                _ = int(data)
                isDataGood = True
            except:
                pass
        time.sleep(0.01)
        if isDataGood:
            gui.setRoll(int(data))
            gui.window.update()



