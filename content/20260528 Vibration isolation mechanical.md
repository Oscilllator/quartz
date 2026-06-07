
This is continuing on from [[20260505 Vibration isolation|here]] but now focusing on the mechanical build rather than interleaving with the sim.

# Spring based isolation

I've hung the whole apparatus now from a string that's ~1m long:

![[Pasted image 20260528225910.png]]

## Results

The full scale drift over a few seconds that the [[20260505 Vibration isolation#Vibration isolated - time series|previous]] flexure based system exhibited now (after waiting a few minutes) is much more stable with this system. you can see the rough slope here where over a period of many seconds it only drifts over a small part of the full scale range:

![[Pasted image 20260528230103.png]]

Interestingly in this setup there is a distinct peak around 450Hz, I wonder what that is.


Another great shot with better alignment - look at that extinction ratio!

![[Pasted image 20260528231216.png]]

## Rigid mounts

The previous mounts, while adjustable, were extremely floppy:

![[Pasted image 20260606180325.png]]

Here are the new ones:

![[Pasted image 20260606182508.png]]

A view of the overall setup:

![[Pasted image 20260606182601.png]]

As a result, the vibration is actually not even full scale when the setup is sitting plain on the desk with no isolation:

![[Pasted image 20260606182753.png]]

And with isolation, the system is naturally way better:

![[Pasted image 20260606183352.png]]

Ref is before suspension, orange FFT is after. This is about as good as it's going to get, I think. You can see however from the vscal of channel 2 that the new pinhole leads to a way lower signal amplitude, only ~40mV here instead of ~500mV before.

## Retroreflector without corner cube

Now that there is a reasonably good setup with low noise, it would be good to measure some audio, even if it was within the setup and not a real conversation. To do this we will of course need to wiggle the end of the measurement arm back and forth. You might think that the best way to do this is a simple piece of retroreflecting tape, but this gets you loads of backreflections back into the laser which I am assured is Very Bad and leads to all sorts of mode hopping, intensity noise, and so on. So instead I learned about this technique whereby a regular lens + mirror can be used as a corner cube retroreflector, only now of course if you replace the mirror with something much thinner than what's pictured here, perhaps it could pick up some voices:

![[Pasted image 20260606184253.png]]



### Aside: lack of quadrature detection

The fact that I am measuring the optical output with only a single photodiode means that when the displacement is >1 wavelength, there is an ambiguity about which direction the measurement arm is moving. Just like how on an encoder you need an A/B channel to tell which direction the motor is moving.

Here is an example where the true movement is a steady state sinusoid, but the signal has been 'folded' back in on itself because the signal was not centered around 0:

![[Pasted image 20260606184738.png]]

You can see as the signal goes from left to right the sinusoid, starting at the bottom, folds back into itself. If there was a separate signal here 90deg out of phase with this, the direction of movement could be resolved. Hopefully I can get that working at some point.

## Floppy mirrors

Now to pick up ambient air vibrations such as those made by people speaking, I need a mirror that's as light as possible

### Aluminium foil

I tried out Al foil first, gluing it to a lens mount with UV glue like so (pictured, dull side):

![[Pasted image 20260606190606.png]]

This surprisingly turns out not to work well at all, the brushed pattern makes it pretty anisotropic:

![[Pasted image 20260606190526.png]]

Horizontal brushed pattern:

![[Pasted image 20260606190637.png]]

Kind of like an ultra bad mini diffraction grating, I suppose.

### Copper tape

![[Pasted image 20260606195702.png]]

A whistle looks like this:

![[Pasted image 20260606195640.png]]

Success!

I tried to hook up a microphone, but the front end of the scope as is is not enough to pick it up apparently so there is no direct side-to-side yet, I'll have to make do with this screenshot from the spectroid app:

![[Pasted image 20260606195823.png]]

### Frequency response

This is what I get with white noise on max volume playing from my nearby monitor:

![[Pasted image 20260606201348.png]]

The white noise indeed looks fairly white per the spectroid app, so this might be the real transfer function of the copper tape microphone

### A voice

Here is a human speech sample:

![[2026-06-06 20-42-14.mp4]]
