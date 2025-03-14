
# Pinout
![[Pasted image 20250301110518.png]]
20 pin connector. Total width from the start of the first pin to the start of the next is 9.49mm. So a pitch of 0.4745mm. Call it 0.5mm I suppose.

This is the interface for the communication board, which is _not_ the flex cable above:

![[Pasted image 20250301110950.png]]

Powering it up and connecting a suitably padded flex cable between the actual gyro and the controller+psu PCB, the 'valid' bit of the serial output is 0 and the measured rate is also exactly 0.

The measured laser current however seems to be changing a few times per second from around 23 to 53mA. That seems wack. But, lo! I also found this test point on the fiber gyro board:

![[Pasted image 20250310200913.png]]

Note the time axis here. here is a plot of the measured laser current as a function of time:

![[Pasted image 20250310201051.png]]

A Clue!

This is the test point in question:

![[Pasted image 20250310201754.png]]

Which is the Vout pin of the [LTC1655](https://www.analog.com/media/en/technical-documentation/data-sheets/16555lf.pdf), a 16 bit rail to rail DAC. So perhaps then the gyro is going through an initialization routine and can't get out of it?

Interestingly, some of the test points sweep through 6 values and others through 5.

## Literature

I found the book "Design and development of fiber optic gyroscopes". It has a design segment just on the DSP-1750, and has this block diagram in it:

![[Pasted image 20250310202801.png]]

This has _three_ connections to the fiber system. There are two through hole connectors that I can see on the fiber board, a 5 pin one in a ring, and a weird 2 pin one that seems to have no voltage on it at all (this is in agreement with the below observations on the DAC input being flat, though).

I had naively assumed that the output of the gyro was like an FMWC lidar; there would be some beat frequency that would be measured. But it seems that's not the case:
```
The scientific principle behind the FOG is the Sagnac effect, which is also
the basis of the ring laser gyro. When the fiber coil is not rotating, the optical path length in both directions is the same, so the two counter-rotating optical
signals are in phase upon their return to the detector. Rotating the coil
introduces an optical phase difference in the counter-rotating light paths
known as the Sagnac phase shift. The phase difference in the two paths results
in a change in amplitude of the recombined signals proportional to the
rotation rate. As such, the FOG is often referred to as an interferometer.

The piezoelectric (PZT) modulator is driven with a sinusoidal signal to
bias the Sagnac interferometer at the most-sensitive operating point. The
open-loop gyroscope has a first-order sinusoidal response to rotation, and the
SF is dependent on the optical intensity and modulation depth. The
interferometer converts this modulation into an output signal comprising
harmonics correlating to the Bessel functions. All of the required information
to determine the rotation rate and stabilize the SF is extracted from the
fundamental signal up to its fourth harmonic
```


## Possible output:

The last pin of the flex cable has this signal on it:

![[Pasted image 20250310204038.png]]

A single snapshot of which looks like this:

![[Pasted image 20250310204123.png]]

Another interesting signal on the flex cable:

![[Pasted image 20250310211741.png]]

Actually both of the above signals originate from this chip:

![[Pasted image 20250310211827.png]]

This is a [LTC1403AIMSE](https://www.analog.com/media/en/technical-documentation/data-sheets/14031fd.pdf) 14 bit ADC:

![[Pasted image 20250310212621.png]]

It would appear that I was looking at the CONV/SCK/SDO lines. The CONV line is the spiky one above.  This means that when the duty cycle was changing above, that was the magnitude of the digital signal changing, not the frequency of an analog one. Kind of weird because when I probe pins 1 and 2 of the chip with the probe AC coupled and zoomed in to 5mv/div, I see basically no change whatsoever on the input. The chip also does not have an internal amplifier, so it's not just that it's too low for the scope to measure.

So the next step is to take a reading of the digital signals, which will require probing the CLK+SDO lines concurrently. Probably the CONV line would help, too.

