# Goal
I would like to build a drone that has a long flight time, ideally like 1hr. Also it should be small (<500g)
## Tradeoffs
The most efficient propeller is one that is large and spins slowly. The most efficient Motor is one that spins very fast.
These are in tension, and so what you want for a hovering drone is a large propeller with low pitch. 
The practical limit on how low would be the minimum of (propeller tensile strength, increased parasitic drag as result of high tip velocity, flutter and suchlike).
Perhaps it is possible to print and measure some 3d printed propellers. This post is about measuing propellers.

# Hardware
The thrust stand is very simple and looks like this:
![[Pasted image 20230325172939.png]]

A regular 1kg load cell attached to one of those HX711 things attached to a esp8266 that spews out the raw load cell data.
## Current measurement

^8e3601

The only way I could rig up current (and thus power) measurement was to query my Hantek PPS2320A. Unfortunately the serial interface is utter trash. The serial link is 9600 baud only and drops packets all the time. The current measurement updates at like 1Hz and takes several seconds to settle. So the resulting data has to be heavily filtered to remove all the jank.
I have ordered some current sensors which should help out a lot when they arrive.

# Calibration
The 24 bit ADC in the strain gauge measurement chip has no calibration or notion of any weight, so I had to do that bit myself. Pretty easy though, just put a bunch of weights on a kitchen scale across the strain gauge range. Results looks like this:
![[Pasted image 20230326113708.png]]
I'm pretty sure most of the error in the low range is just my shoddy measuring technique but whatevs, it's more than good enough.
Featuring an 800g weight:

![[Pasted image 20230326113837.png]]


## Raw data
To collect the data I just recorded the current and thrust over time while twiddling a servo tester knob to get different thrust levels. Here is the raw data as a function of time:
![[Pasted image 20230326111901.png]]

Every time there is a gap in the data followed by a drop in the power supply measurement is a dropped uart transaction from the power supply.
As a scatter graph of efficiency (blue: raw, red: filtered):
![[Pasted image 20230326112427.png]]

Disgusting. Getting rid of all the garbage and judiciously cropping the y axis it looks like this:

![[Pasted image 20230326112551.png]]
Much better!
Here is what a normal efficiency curve looks like:

![[Pasted image 20230326112943.png]]

So this is more or less in line with that. The >10g/w efficiency number is pretty good, too. 
This data was taken with an 8040 propeller at 8V motor voltage. The [manufacturers data](https://sunnyskyusa.com/products/sunnysky-x2204-brushless-motors) looks like this:

![[Pasted image 20230326113215.png]]

I have no idea how I managed to beat the manufacturer efficiency ratings. I did not bother to subtract the weight of the motor + propeller for my calculations but I doubt that's it.
Regardless, with my current calculated weight of ~370g for the drone this actually works out to bang on 60 mins hover flight time. Pretty noice if you ask me. The max thrust is a little low though cause it works out to a 2.7:1 ratio. Would be nice to see if we could get that up to like 4, we shall see how adding a bigger propeller helps with that.

