In the [[20240701 Fluxgate magnetometer#Hopeful reasons for this result|previous]] episode of trying to get a fluxgate manetometer to work as a detector for a metal detector I decided that a possible reason that I didn't observe much of a change in signal amplitude vs frequency was that the magnetometer was not sensitive enough. It was so insensitive that I had to wedge the copper/iron right up into the setup to measure anything:

![[Pasted image 20240721135309.png]]

If the metal was in a more representative position I think the result might have been different.

## Sampling to make it more sensitive

I [[20240701 Fluxgate magnetometer#Gating and filtering|already tried this]] but my DIY analog switch had too much charge injection to be useful, so I gave up. So as a backup plan I plopped down an analog switch PCB:

![[Pasted image 20240721134916.png]]

In the hopes that a dedicated IC would be much better. The actual part I used is the [SN74LVC1G3157](https://www.ti.com/lit/ds/symlink/sn74lvc1g3157.pdf).

## Results

Well, it isn't any better really:

![[Pasted image 20240721135705.png]]

not only is there a huge amount of charge injection still, but there is actually quite a lot of noise turning up during the transient period, which is even worse. 

## Wrong circuit

I think I ordered the wrong part basically. What I should have done is used a sample and hold circuit rather than a analog switch.

# New circuit

I poked about and learned of the existence of the [LTC1043](https://www.analog.com/media/en/technical-documentation/data-sheets/1043fa.pdf). It contains a whole bunch of components and differential whatnots, but it is possible to use one corner of it to make a sample and hold circuit:

![[Pasted image 20240722073936.png]]

Based on the immediate and totally predictable failure of the previous design I decided to put this new one in LT spice. Since this is a LT component this is actually possible:

![[Pasted image 20240722074120.png]]

Here I have set things up so there is a sin wave signal corrupted with some spikes that we want to ignore:

![[Pasted image 20240722074323.png]]

And here is the output from the op amp (before R6) as well as the output from the switch S2A:

![[Pasted image 20240722074947.png]]

you can see that the output tracks the input quite well, but that the voltage sags down quite quickly outside the period where the switch is connecting the input and the output. I think that this is because the input impedance of the second op amp U3 is too high, i.e. 100kR is not enough. The idea here was that it would be a high impedance follower, but I think this might not be the proper design of op amp for that.

You can also see some spikes and whatnot going on on the input during the transition times. I think that's the output capacitor C2 suddenly being connected to the load of U2. Increasing the value of R6 should help fix that, although of course it forms a lowpass filter so you can't do it too much.

