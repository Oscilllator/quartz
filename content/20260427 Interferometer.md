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

I figured that perhaps the above wild fluctuations were due to either a horrible power supply (almost guaranteed) or strong back reflections from my plain glass beam splitter. I can't find any good cheap laser drivers online unfortunately so I figured I would change the setup to a Mach zehnder interferometer, as those don't create back reflections for the laser. It looks like this now:

![[Pasted image 20260428213540.png]]

But unfortunately I can't get any fringes at all, no matter how I wiggle and woggle things. part of what makes this difficult I think is that it's a lot harder to adjust the path length in this configuration and hence hard to get fringes, since the coherence length of the laser is presumably very short with this bad power supply.

# Retroreflector Michelson interferometer

Following [this](https://www.rp-photonics.com/michelson_interferometers.html) guide here, I switched back to a michelson interferometer but with retroreflectors at the end instead of plain mirrors, so the return beam is displaced sideways. This seems to work well, and looks like this:

![[Pasted image 20260503095756.png]]

In particular the return beam is no longer shooting back into the laser cavity:

![[Pasted image 20260503095837.png]]

The interference fringes look like this:

![[PXL_20260503_162357990.LS.mp4]]

When I give one of the retroreflectors a tiiiny tap with my fingers, I get this response:

![[Pasted image 20260503102104.png]]

When the same tap is given with one of the arms obscured, the magnitude of the response is miniscule by comparison.

## Bandwidth of detector.

In the above graph I have a plain photodiode, a PD15-22C that I've stuck in the thorlabs case. When this is put into the scope with a 50R impedance input, the amplitude of the signal is way below the noise floor of the scope, which is sad. So it's on a 1MOhm impedance, which is for sure killing the bandwidth, as you can see from the above plot - the amplitude of the signal out of the interferometer should be constant, the only thing that is changing is the frequency.

