I bought some laser google off aliexpress but who knows if they are any good.

Here is an image from a realsense d435i, which has no ir filter and also a 16 bit grayscale output:
![[Pasted image 20230403203351.png]]

## Laser off, no googles:
Image is totally black, value of about 0x1400

# Laser on, no googles:
With the camera gain at 0 I adjusted things to be just before saturating:
This is with a laser current of 10mA. Note that the threshold current for this laser is 600mA and so this will be mostly stimulated emission. Still mostly the right wavelength though I would think.
![[Pasted image 20230403192233.png]]

## Laser on, googles:
The image is totally black with the goggles in front. Turning the gain from minimum to 248 gets the laser to the point where it is juuust barely detectable if you turn off the power supply. Prolly ~100 magic sensor counts. Fun fact: if you turn a Hantek PPX2320 off and on a bunch abesntmindedly it might change the voltage and currents to maximum (31V/3A) and then the next time you turn it on it will apply that to your 10W laser diode, making the tip of the fiber catch on fire. Oops. Probs should have had another layer of safety on that one. Should have learnt my lesson on the firmware quality from how it applies 5V to the 1.8V line and has a [[20230325 Thrust stand#^8e3601|Garbage]] current measurement feature.
Ballpark estimate though is that it attenuates the light by (65536 / 100) * 248 = 1e5 which given the egregiously bad testing is in line with the claimed OD6+.
Nonetheless I think I need a second line of defence to be doing anything properly eyedangerous here.
