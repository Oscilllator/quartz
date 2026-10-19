
Finally the pulse jet, linear rail, pressure sensor, and associated acquisition system is ready.

It looks like this:

![[2026-10-18_21-35.png]]

Now to measure the pressure. As a reminder this is what conceptually is supposed to be happening:

![[Pasted image 20261018214446.png]]
When the pressure sensor is swept back and forth, it will measure a periodic pressure wave of course. Just this by itself is useful because it tells us the frequency and amplitude of the pressure wave, as a function of distance inside the pulse jet. But, we can do better. By placing a stationary reference sensor on the body of the pulse jet we can measure the phase of the pressure sensors measurement with respect to the reference. This means that the propogation of the pressure wave down the inlet can be directly measured.

To elaborate: suppose you have an imaginary pulse jet. Every 1ms, there is an explosion in the combustion chamber and a shockwave propogates down the inlet. 
### Odd pressure spikiness

Throughout parts of the run, this weird stuff happens:

![[Pasted image 20261018203548.png]]

Why is that? no idea. Doesn't really fit with my idea of a loose connector.

### Dying pressure sensor

Here is the piezo pickup used the first time, bullclipped on with a random woodchip as a load spreader in an attempt not to crack the piezo element:

![[Pasted image 20261018211503.png]]

This worked reasonably well for one data recording, then died and did not work well for another.

So, we bolted a proper ultrasonic transducer on:

![[Pasted image 20261018211636.png]]

This also worked well for one recording, and then also very clearly died slowly over the course of a run:

![[Pasted image 20261018211721.png]]

By the end, it was practically dead and you couldn't really pick up on the reference waveform at all, here is a zoomed in trace from near the end:

![[Pasted image 20261018211919.png]]


# Claude visualisation
Link [here](https://harrydb.com/static/pulsejet-pressure-explorer.html)