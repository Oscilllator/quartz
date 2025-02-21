
# The PCB

Basically the same as the [[20250103 awg buffer bringup|previous]] one, but with the changes integrated and the addition of the positive and negative rails for the op amp. The rails look like this:

![[Pasted image 20250219210052.png]]
![[Pasted image 20250219210101.png]]

I asked claude to generate all the component values for this based on the datasheet and didn't bother to check them much. As a result:

# Changes required

### Voltage level

Need to change "R2" to 11k for both power supplies since the formula for the output voltage is:

![[Pasted image 20250219210159.png]]

Vth == 1.25V.


### Power rail flip

I got the inverting and noninverting inputs wrong for the amp before, so I selected the amp in kicad and pressed 'y' to flip it in the y axis:

![[Pasted image 20250220075355.png]]

...yeah, that was a mistake.

### Bias resistors.

For some reason the bias resistors:

![[Pasted image 20250220075532.png]]

were specified to be 330R each, not 4k. Thermal camera saved me on that one I think.


## Weird startup behavior

About 80% of the time the negative rail comes up fine. 20% of the time it hits my power supply current limit of ~600mA at a 1.9V input voltage. The switch node looks like this at this time:

![[Pasted image 20250220190836.png]]

Don't know why this is, but it's clearly just shorting the inductor to ground permanently. I noticed that the example schematic had 470uF on the output instead of my 60uF so I added a 470uF electrolytic too. That seems to have fixed the problem. I assume that if there isn't enough capacitance in the system the inductor will discharge itself in less  than one switching cycle or something like that and get the chip into a bad state. 


...Actually this did not fix the issue. There are some super weird correlations going on. It's almost as though the temperature is important, it seems more likely to happen right after soldering something on. But it also might just be that it happens more often after waiting a while. There definitely don't seem to be any caps that take a while to discharge, so it isn't that.

I thought that perhaps there wasn't enough input capacitance, and so the voltage on the input was going really low on the first switch of the power supply, and the subsequent switch never turned off and shorted the inductor to ground. it isn't that either...