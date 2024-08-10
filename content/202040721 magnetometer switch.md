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

# Real world, real results.

## Schematic

Pretty straight forward amplifier going into a switch with an incorrectly configured buffer, followed by some more gain.

![[Pasted image 20240805201249.png]]

![[Pasted image 20240805201258.png]]

![[Pasted image 20240805201304.png]]

## PCB:

Here is the PCB:
![[Pasted image 20240805201339.png]]


## First results:

![[Pasted image 20240805201641.png]]

Looks pretty legit to me officer.

### Charge injection

The main reason that I used this chip is that it alleges there is no charge injection when the input is around half the supply voltage:

![[Pasted image 20240805201752.png]]

which means that for signals with 0 amplitude you should be all G.

![[Pasted image 20240805202213.png]]

...this is interesting. Here I have zoomed in on one section. You can see that when the signal is switched there is indeed no charge injection. But when the signal is switched away, the signal starts to decay since there isn't anything attached to that node of the circuit anymore. That's obviously something that needs to be fixed. It should either hold its previous value (best) or decay to vcc/2 instead of GND. I wonder if it's the lack of capacitance on the output combined with the input bias current of the op amp I am using...

### RTFM

Here is the schematic for sample and hold from the datasheet:

![[Pasted image 20240805202514.png]]

...yeah. time to put 1nF on the output of my switch.

![[Pasted image 20240805203113.png]]

Nice! Now the droop has gone from like 200mV to 2mV. That's pretty good. But if my signal is in the nV/uV range, that is still not close to good enough!

### Rise time.

Here is the rise time with the 1nF cap attached:

![[Pasted image 20240805203949.png]]

Recall from [[20240701 Fluxgate magnetometer#Gating and filtering|before]] that the total width of our pulse was around 2uS. You can see from above already that the rise time of the signal is about, or just under, 2uS. So that's not good, it would be nice if it was 2-10x faster.

Here is what the datasheet has to say on the topic:

![[Pasted image 20240805204444.png]]

So we need Ron:

![[Pasted image 20240805204534.png]]

240\*1e-9 = 240ns. But our rise time is like 10x 240ns! I don't know why this is. In the above scope trace you can see a blip in the blue input as the control line is switched. That's the impact of the scope impedance, which is clearly not a significant factor. I think maybe I need an op amp with a much lower input bias current.

While those are coming in the mail, I figured I would proceed regardless. The circuit should still work, it will just be less effective.

## Bandpass filter

With all of the above working the circuit is definitely much more sensitive, it saturates with a small fraction of the earths magnetic field so I have been "nulling" the sensor by placing a magnet at the right distance and orientation so it measures 0 field in total. Then the signal that I get is dominated by mains hum at the low end and the 200+kHz pulses at the high end. Time for a filter:

![[Pasted image 20240807214122.png]]

My inductor kit just arrived in the mail so this is a good test. This is what the above kit looks like when constructed out of rando components:

![[Pasted image 20240808075128.png]]

![[Pasted image 20240807214240.png]]
...not great. I suspect that the fact that my 15mH inductors have themselve 50R of DC resistance is not helping matters. It seems to be failing most at the high end though. I feel like that would be mostly due to self resonance of L2 being too low. 

Changing the filter to 1kHz->10kHz would give more time for an imperfect rolloff to attenuate the ~1MHz pulses from the magnetometer, but that would also involve changing the top inductor to 220uH:

![[Pasted image 20240808074724.png]]

which would lower the SRF and make the performance of the filter _worse_ at the high end. So I am hesitant to spend some time building one. The inductor sheet does not seem to come with a datasheet (hah) but when I filter digikey inductors from ones with the same inductance and similar DCR they all have SRF's in the MHz range. So maybe I'm fine.

### 1-10kHz filter

![[Pasted image 20240808184121.png]]

![[Pasted image 20240808184131.png]]

That looks much better!

### Filter sensitivity sniff test

Green here is the filtered result, blue is the unfiltered:

![[Pasted image 20240809074104.png]]

This looks pretty good. Now that the new op amp has arrived, it's time to go back and put that in I think.

## New op amp

I switched out the op amp that is the buffer on the output of the analog switch for the new OPA2392, with 10fA(!) of input bias current. This should allow me to use a significantly lower storage capacitor on the output of the switch, since it won't be drained by the capacitor. I changed the cap from 1nF to 270pF and got this:

![[Pasted image 20240809081425.png]]

In the [[202040721 magnetometer switch#Rise time.|previous]] section the rise time was 1us, which was not comfortably within the sampling window. Here it is like 200ns, so you can see the output begin to track the input even within the sampling window. Noice!

Here is another view zoomed out showing the wonderful sample and hold behavior on a test sawtooth waveform:

![[Pasted image 20240809210532.png]]

## Some notes from debugging

Putting the above filter on the output of the OPA2392 results in some absolutely disgusting waveforms. This isn't a surprise, since it is not specced at all to drive a 50R load. This led to a little confusion since the NE5532 also isn't specced for this, but does not seem to have any pathological behavior if you do. Fortunately, I had a spare op amp output on my board already, so hooking that up as a buffer allowed me to pipe the output into the filter as intended:

![[Pasted image 20240810111642.png]]

One other thing: I noticed that the output was only nonsaturated for a very narrow range of magnetic fields. I took this to be because of the super high gain, and indeed this is the case, but the situation can be made much much better by AC coupling after the buffer:

![[Pasted image 20240810111753.png]]

since then the DC earth magnetic field does not contribute to the saturation, only the AC component from my drive coil.

Her is the output after making the above changes before and after the filter:

![[Pasted image 20240810111928.png]]

grrr. Previously the mains interference was sinusoidal, like all honest mains interference is. But here there is a square wave mains interference, so after filtering the edges still come through loud and clear. How annoying.

# Sensitivity comparison

Throughout all of this there has been some kind of assumption that the sensitivity of the magnetometer was somewhere near that of a coil I have been using a coil to compare, and indeed the magnitude of the signal is comparable. But, I have not been using a coil with an appropriate capacitor to make the coil into an LC resonator. The comparison here is easy since I can directly swap out the magnetometer pickup coil for a coil of the same type as what I have been using as a drive coil.

Here we shall compare a 454uH pickup coil tuned to 8.5kHz with two 470nF caps in parallel. with the drive and pickup coils separated by about 1m, the coil has 200mVpp of signal, and when I zoom in a bunch it has about 2mVpp of noise. Here is an FFT of the noise:

![[Pasted image 20240810120149.png]]

When I connect the magnetometer across the input again (after desoldering the caps) the signal has a magnitude of 20mVpp, and the noise has a magnitude of 4mVpp (after taking out the spikes coming in from the mains noise). Here is a spectrum coming from the magnetometer:

![[Pasted image 20240810120726.png]]

lots of disgusting spikes there. Regardless it looks like the main difference here is the sensitivity rather than the noise. I think I can chalk up the lower noise of the pickup coil to the lower bandwidth of the LC resonator. The reduced signal though is another matter. I suspect that the cause of this is that the "loop area" of the magnetometer is quite a bit lower than the coil, since the coil has a diameter of around 200mm and the magnetometer is only around 40mm. 

The question is though what defines the 'loop area'. You might think that it is the loop area of the pickup coil, but I do not think that this is the case since the purpose of that coil is just to pick up when the main magnetometer material saturates. Perhaps then it is the total amount of flux concentration that the magnetic material in the magnetometer manages. This sounds like a job for a textbook though.

"Magnetic sensors and magnetometers" has this to say on the topic of noise:

![[Pasted image 20240810122119.png]]
![[Pasted image 20240810122321.png]]

![[Pasted image 20240810122339.png]]

So it looks like changing the size of the sensor is futile. But one thing could easily be changed: I have been using a 50R impedance waveform generator with a 20V signal to power the drive coil. It sounds like I should change that to something else. 