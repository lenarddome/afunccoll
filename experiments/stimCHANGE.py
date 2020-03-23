# psychopy python script to update stimuli attribute every n frame
# you can create stop-motion by changing the image displayed, as the image
# is one attribute of the stimuli

import random
import copy
from psychopy import core, event
from psychopy.visual import *
from numpy import array, arange, random

# define window
win = Window([1024, 768],
       fullscr=True, screen=2, units = 'pix',
       winType='pyglet', allowGUI=False, allowStencil=False,
       monitor='testMonitor', color='#0000000', colorSpace='rgb',
       blendMode='avg')

# hex color generator
_HEX = list('0123456789ABCDEF')

def startcolor():
    return '#' + ''.join(_HEX[random.randint(0, len(_HEX)-1)] for _ in range(6))

# declare variabls
sf = 0.5
X = 32
P = 128

noiseTexture = random.random([X,X])*2-1 # a X-by-X array of random numbers 
pnoiseTexture = random.random([P,P])*2-1 # a X-by-X array of random numbers 

# noise patches
n = GratingStim(
    win = win, mask=None, tex = noiseTexture,
    size = 400, contrast = 1.0, opacity = 1.0,
)

v = GratingStim(
    win = win, mask=None, tex = pnoiseTexture,
    size = 400, contrast = 1.0, opacity = 1.0,
)

s = GratingStim(
    win = win, mask=None, tex = noiseTexture,
    size = 400, contrast = 1.0, opacity = 1.0,
)
s.pos = [500, 0]
v.pos = [-500, 0]

sv = arange(0.1, 100, 0.01) # size vector


frame = 0  # the current frame number
continueroutine = True

while continueroutine:
    theseKeys = event.getKeys()
    if len(theseKeys) > 0:
        if theseKeys[0] == 'escape':
            core.quit()
    hex_number = startcolor()
    noiseTexture = random.random([X,X])*2-1 # a X-by-X array of random numbers 
    if frame % 6 == 0:  # % is modulo. Here every sixth frame
        n.color = hex_number
        n.tex = noiseTexture
    #if frame % 120 == 0:
    #    move = random.randint(-100, 100)
    #    n.pos += move 

    noiseTexture = random.random([P,P])*2-1 # a X-by-X array of random numbers 
    if frame % 32 == 0:  # % is modulo. Here every sixth frame
        v.color = hex_number
        v.tex = noiseTexture
    # Run this every iteration to synchronize the while-loop with the monitor's frames.


    n.draw()
    s.draw()
    v.draw()
    win.flip()
    frame += 1
    n.phase += 0.1
    if frame % 1000 == 0:
        continueroutine = False
