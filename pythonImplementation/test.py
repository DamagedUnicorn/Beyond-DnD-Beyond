#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul  4 22:25:57 2022

@author: thorknudsen
"""

import tkinter as tk
import numpy as np
from tkmacosx import Button

window = tk.Tk()

image = tk.PhotoImage(file="advantage.gif")
b = Button(window, text="Hello, world", image=image, compound="left", bg="#ff0000", width=1000)
b.pack(side="top")

window.mainloop()