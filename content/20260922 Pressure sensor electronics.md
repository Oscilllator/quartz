
# The sensor
I'ts a XCQ-093-50SG from ebay:

![[Pasted image 20260922075618.png]]

Full scale output is 0-100mV. I can reach this by jamming the end of a compressed air duster into it, which is a bit suspicious but apparently the vapor pressure of difluoroethane is higher than the max pressure of this sensor so perhaps that's OK. the 50SG means it's a 3.5 bar range, with no 'reference port'.

# AD620 amplifier

I've used one of these [[20260321 contact microphone#new amplifier, new problems.|before]] and had a whole bunch of issues with the mains signal ending up on the output, and the noise from the charge pump inverter appearing on the output too. Since the vref line of the breakout board comes from a pot that goes between the + and - supply rails ripple on the negative rail shows up directly at the output. Putting a fat 10uF cap on the output helps a great deal, but does not entirely solve the problem. The noise floor is still clearly set by the charge pump:

![[Pasted image 20260923215001.png]]

There is also the issue of the mains signal, which is large and ever present.

## Solution to noise problems.

Fortunately, Kulite mentions that you can actually modulate the supply rail up at say 100kHz or comfortably above wherever your signal is, then demodulate it. Fantastic idea. Here is the sensor modulated with the waveform generator on my scope:

![[Pasted image 20260922080157.png]]

Fantastic.

### Demodulation of the signal

Here is the above data saved as a bin file and demodulated by claude:

![[Pasted image 20260922081103.png]]

Looks pretty good to me! I was a bit worried about how the very short puff of air (such as on the leftmost side of the above scope image) were _lower_ amplitude than the idle signal, but apparently this was taken care of as it shows as a positive bump in the demodulated signal.

# Modulation with DRV8833

This is cheapo chip and was suggested by mr claude as a good way to apply a 10vpp signal to the sensor. With the 5V usb applied in forward in reverse you get the 10vpp that the sensor is supposed to operate at. Is that how it works? I'm not sure, since the sensor only ever has 5v across it. So if there was any nonlinearity in the supply voltage->sensitivity function the calibration would be off. Not a huge issue I hope.



# Putting it all together

![[Pasted image 20261001205055.png]]

Here is what the control interface looks like, which is a pyqt app:

![[Pasted image 20261001205632.png]]


# Temperature measurement
Continuing per the idea [[20260908 pulse jet construction#Measuring the temperature using the pressure sensor directly.|here]], let's try to measure the temperature of the pressure sensor using the pressure sensor itself. The top signal is the current drawn by the pressure sensor overall, as measured by a 50R termination in thescope. the middle signal is from a thermocouple zip tied to the pressure sensor:

![[Pasted image 20261008130952.png]]

The bottom signal is the pressure sensor current pre-demodulation, and the blue highlight is what is being averaged over.
![[Pasted image 20261008121038.png]]

There is clearly a lot of noise in the top signal but it's nonetheless working. Here is a scatter plot of the correlation between the current draw and the temperature, over the full range. It's kind of hard to see on this plot but the different time constants of the thermocouple and the pressure sensor are just visible, as the temperature is increasing the scatter plot is above the fit line and as it's decreasing it's below the fit line. 
![[Pasted image 20261008121051.png]]

## Noise

Here is a pure time series plot of the current drawn, at constant temperature, and of the supply rail:

![[Pasted image 20261008123139.png]]

What's up with that? ~20Hz doesn't really sound like a frequency that I'm using anywhere in the system. Turns out it was that I had the AD620 amplifier plugged in, but not powered on. Powering it on gives this:

![[Pasted image 20261008124529.png]]

(note the y axis scale change)

Now I get this with a pressure sweep:

![[Pasted image 20261008130829.png]]

Way less noise! The different thermal time constants of the thermocouple and temperature sensor are also visible as my little temperature chamber heats up and cools down:

![[Pasted image 20261008130922.png]]

So we can now say with confidence that the pressure sensor temperature can be measured quite accurately - to probably just the same level as the thermocouple itself.

# Insides of the XCQ-093-50SG pressure sensor

Whilst trying to jam this thing into a ~2.39mm hole (The diameter of the sensor is 2.4mm) I accidentally popped the cap off this thing, and immediately destroyed it. Anyway, this affords an opportunity to look inside it, the silicon die of the sensor can be seen clearly:

![[Pasted image 20261011092854.png]]

The epoxy was extremely floppy and didn't really adhere to much. I guess this is so it can transmit pressure waves through losslessly.

![[Pasted image 20261011093058.png]]

I didn't realise that the inside of the pressure sensor was mostly plastic. This is not a good sign as it means that the sensor at the tip will be quite isolated thermally from the body of the sensor, reducing the effect of the water cooling. Oh well, nothing to do but to push on.

## Kulite on their ruggedised sensors.
I wondered how the above sensor might differ from one of the ones that Kulite water cools and sells for high temperature operation, over and above just the water cooling jacket. Apparently the above gold bond wires [are removed](https://kulite.com/assets/media/2023/11/section2.pdf):

![[Pasted image 20261011112953.png]]

Another group has done basically the same thing as me in "WATER-COOLED FAST-RESPONSE WALL-STATIC PRESSURE PROBES FOR HARSH COMBUSTOR ENVIRONMENT APPLICATIONS" 