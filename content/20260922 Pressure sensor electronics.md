
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



