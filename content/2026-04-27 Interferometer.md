The time has come to build an interferometer.

Here is the setup:

![[Pasted image 20260425214113.png]]

The laser is a osram PL530 being operated at 270ma with no power to the heater. This is apparently 50mW @ 450mA but honestly it didn't look that bright when I was operating it at 270mA.

Here is the output of the photodiode I installed inside an old thorlabs case:

![[Pasted image 20260425214401.png]]

This is with the scope on 1MOhm input impedance. Pretty good fringe contrast, really! I also installed a piezo disc on one of the mirrors on the right hand side with the idea that since there was so marge garbage in the output signal from vibrations through the table and a generally bad laser, a clear 1khz tone from the piezo would stick out really well and prove the interferometer was working well. Uncle GPT however informs me that since the thickness of the piezo film is likely only about 100um, the displacement would be on the order of single digit nm. So not enough to show up anyway.

### Three level signal
The next day I turned the interferometer on and noticed there was a kind of four-level distribution:

![[Pasted image 20260426073236.png]]

Looks like I have two interferometers in my interferometer.

### Current modulation.

Now I am powering the laser through a 10R resistor, and am AC coupled to a waveform generator so I can inject some current modulations.

![[Pasted image 20260426104124.png]]

![[Pasted image 20260426104235.png]]

### Sitting still

![[Pasted image 20260426104253.png]]

With a 4VPP modulation coming out of the scope waveform gen, I get this.


#### Whilst tapping.
Continuously lightly tapping on the table shifts the noise up in frequency quite a lot and makes the modulation a lot more obvious:

![[Pasted image 20260426103819.png]]

### One arm blocked

With one arm of the interferometer blocked, I get this:
![[Pasted image 20260426104604.png]]

...I guess the signal is just modulation of the laser power...

## Michelson -> Mach zehnder