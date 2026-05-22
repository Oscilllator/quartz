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

![[Pasted image 20260521214052.png]]