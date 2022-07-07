#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul  7 17:39:20 2022

@author: thorknudsen
"""

import serial

class SerialCommunication:
    
    def __init__(self, port, baudRate):
        self.port = port
        self.baudRate = baudRate
        self.ser = serial.Serial(self.port, self.baudRate)
        
    def readData(self):
        self.data = self.ser.readline()
