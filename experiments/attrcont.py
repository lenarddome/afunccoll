# psychopy python script to update stimuli attribute every n frame
# you can create stop-motion by changing the image displayed, as the image
# is one attribute of the stimuli

import random
from psychopy import core, event
from psychopy.visual import *
from numpy import array, arange, random

win = Window([1024, 768],
       fullscr=True, screen=1, units = 'pix',
       winType='pyglet', allowGUI=False, allowStencil=False,
       monitor='testMonitor', color='#0000000', colorSpace='rgb',
       blendMode='avg')

sf = 0.5
X = 600 
noiseTexture = random.random([X,X])*2-1 # a X-by-X array of random numbers 

# noise patch
n = GratingStim(
    win = win, mask=None, tex = noiseTexture,
    size = X, contrast = 1.0, opacity = 1.0,
)

sv = arange(0.1, 100, 0.01) # size vector


frame = 0  # the current frame number
continueroutine = True

while continueroutine:
    theseKeys = event.getKeys()
    if len(theseKeys) > 0:
        if theseKeys[0] == 'escape':
            core.quit()
    random_number = random.randint(0,16777215)
    hex_number =format(random_number,'x')
    hex_number = '#'+hex_number
    noiseTexture = random.random([X,X])*2-1 # a X-by-X array of random numbers 
    if frame % 8 == 0:  # % is modulo. Here every sixth frame
        n.color = hex_number
        n.tex = noiseTexture

    # Run this every iteration to synchronize the while-loop with the monitor's frames.
    n.draw()
    win.flip()
    frame += 1
