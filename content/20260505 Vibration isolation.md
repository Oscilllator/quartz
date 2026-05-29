Per [[20260505 Vibration isolation|here]] the main thing wrong with the interferometer is the vibrations, no surprises there. I recall seeing a demo at photonics west which in retrospect was probably [minus k technologies](https://www.minusk.com/content/technology/how-it-works_passive_vibration_isolator.html). It does vibration isolation with a flexure element that has negative stiffness. If you knew what to build, it would probably be pretty easy.

# Simulation of buckling loads

Here is claudes first attempt at simulating a buckling load:

![[beam_sweep.gif]]

The middle plot is supposed to look like this:

![[Pasted image 20260505200016.png]]

From [here](https://www.comsol.com/blogs/can-a-stiffness-be-negative). It kiinda looks like that but not really.

# Real isolation

I have been furnished with a prototype vibration isolation mount based on the above negative stiffness mount.

## Setup

![[Pasted image 20260521214115.png]]

Sadly the whole rig is just a bit too heavy, and so it bottoms out the setup:

![[Pasted image 20260521214214.png]]

So it's not in the flat part of the force-displacement curve.

### Results

It does something, but still pretty bad. But as mentioned it's not being operated at the right point.

![[Pasted image 20260521214052.png]]

## Proper balancing.

You can see from the above pics that there are 4 1/2" steel rods holding everything up. I removed these and replaced it with 3d printed 1/2" rods to cut down on the weight. This was enough to (just) bring it below the operating points. On thorlabs mirror stage, one 4mm allen key, and one 1/4"-20 bolt  on top of that puts it in the sweet spot.


### Vibration isolated - Spectrum

![[Pasted image 20260523115241.png]]

### Vibration isolated - time series

This makes the difference abundantly clear:

![[Pasted image 20260523115743.png]]


![[Pasted image 20260523114837.png]]

### Power supply sensitivity

Here is a plot of me twisting the knob on the power supply back and forth to modulate the current going into the laser:

![[Pasted image 20260523121436.png]]

Considering I was swinging the power back and forth by quite a bit, I would estimate many 10s of mA, this actually points away from the residual noise being power supply related I think since that implies that the benchtop power supply is implausibly noisy.

### Vibration correlation

If the remaining noise in the interferometer output was due to vibration, then perhaps there would be a correlation between the voltage across a piezo mic and the output of the interferometer. You might be able to see this in the xy mode of a scope:

![[Pasted image 20260523123940.png]]

...or, perhaps not. This isn't a definitive proof though. I don't think that the piezo voltage is linearly proportional to the displacement of the system 

Pic of setup:

![[Pasted image 20260523124527.png]]


## Back to sim

I got claude to switch from the DIY version of the sim to a Calculix based one. Apparently regular grid-based FEA just doesn't work very well with super long aspect ratio buckling type simulations, so this uses some other method.

Here is what the results look like now:

![[Pasted image 20260526210519.png]]

![[Pasted image 20260526210530.png]]

![[Pasted image 20260526210545.png]]

This looks more in line with the literature I think, though I don't really know how plausible it is. 

