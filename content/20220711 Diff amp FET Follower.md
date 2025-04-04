# Consult the book of armaments!

![[Pasted image 20220711204013.png]]

The art of electronics can't seem to get over JFET's. So 1970. Fortunately for them I already got hooked with the JFET colpitts oscillator, so it isn't any more BOM lines for me to add one in.

## Circuit
This circuit here is class A and draws 30mA quiescent, but I think I'll spend a whole design cycle on power efficiency so let's just get this out the door:

![[Pasted image 20220711204616.png]]

Performance:

![[Pasted image 20220711204644.png]]

...Should be adequate for our 0->10KHz operation. The egregiously sized AC coupling capacitor is in face a 5x10mm electrolytic so it shouldn't be too bad.

## Real world, real results

![[Pasted image 20220711212351.png]]

Works Like a charm. Listening to music or a podcast has no discernable distortion. It is a bit quiet though, so adding a touch (3dB?) of gain would be nice.
Taking a look at the inputs/outputs only about 100mV is being output by my phone so putting that on the transmit side to increase the modulation depth would be best.
There is still the matter of the negative rail of the diff amp though. I came across some art of electronics current sink schematics, perhaps one of those can be used instead as it will require quite a lot less voltage headroom, maybe enough even not to need that negative rail.
Figure 3.26 has the details:

![[Pasted image 20220711213706.png]]


