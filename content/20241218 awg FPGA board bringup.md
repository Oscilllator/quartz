First things first, here is the board:

![[Pasted image 20241218211810.png]]

Looks great. One problem: the 3.3v rail is shorted straight to ground!

# Lock in thermometry

Following along with [this article](https://dmytroengineering.com/content/projects/t2s-plus-thermal-camera-hacking#lock-in-thermography) which I have been wanting to use for a while, I figure I can use this to find the location of the short. Here is a picture of me detecting the presence of just a wire with current pulsed through it:

![[Pasted image 20241218083410.png]]

Works great. The whole sin/cos thing seems a bit silly though, it's basically the same as just taking the diff. I wonder if this is due to the thermal time constant as compared to the switching frequency of the current:

![[Pasted image 20241218212136.png]]

Like whether a sin/cos or whatever would fit well into this would depend partly on the thermal time constant. Anyway this is what I get after like 2min of recording data:


![[Pasted image 20241218084842.png]]

You can clearly see there is a dot in the top left corner of the board! It's a bit faint though, so I recorded for many hours until I had like 37GB of data and then got this image:

![[Pasted image 20241218170324.png]]

...Basically the same. Anyway this was enough for me to go out on a limb and desolder the clock chip:

![[Pasted image 20241218212337.png]]

![[Pasted image 20241218212400.png]]

And indeed this removes the short! I checked the orientation of the part in the datasheet though and although there isn't a pin 1 marking, the orientation appears to be correct just going of the text on the part.

# Power rails

...I didn't connect these:

![[Pasted image 20241218212717.png]]

...great. After connecting both the 1.1 and 2.5v rails with bodge wires to the decoupling cap pads on the back, I get this:

```
sudo ecpprog -t
init..
IDCODE: 0x41112043 (LFE5U-45)
ECP5 Status Register: 0x04a00000
flash ID: 0xEF 0x40 0x18
Bye.
```

Excellent!

## AD9744 fs_adj

I foolishly connected this to the fpga instead of via a 2k resistor to ground:

![[Pasted image 20241218213253.png]]

Just so I fixed that before trying to actually use it.
