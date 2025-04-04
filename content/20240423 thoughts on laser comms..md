Idea: put a laser transmmitter and receiver under a fisheye lens, then have a mechanism that translates the laser and receiver under them to direct the beam around. That way you could get uninterceptable laser communications and it would be relatively easy to steer the beam around in an entire hemisphere, because like 10mm of translation would result in a full hemisphere of laser direction.

![[Pasted image 20240423085642.png]]

I suppose it would be a bit like optics stabilization only instead of stabilizing the sensor you are destabilizing a laser tx/rx. 

### Construction
You could make a PCB voice coil kind of thing that looks like this:

![[Pasted image 20240423085457.png]]

and then that could sit on some 3d printed flexure thingo to provide translation. 

### The hard bit

The hard thing with this I think would be gettingthe tx and the rx pointed in the right direction. One thing that I think might help here would be (for the rx side) actually putting the rx photodiode just straight up on top of an image sensor.

![[Pasted image 20240423085852.png]]

Then when you were trying to steer the rx around you could have a blob detector that would tell you where to point the 