
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


### Proper mirror

Both the aluminium foil and the copper foil have a 'brushed' appearance, presumably from the rolling used to manufacture them. So a real mirror is needed, but lightweight so it can be moved back and forth by sound. Since this is just an intermediary step on the way to bouncing off a lambertian target I don't want to spend too much time on it.

Here I have taken a tiny chip of gold plated glass struck off a larger scrap gold plated first surface mirror:

![[Pasted image 20260607112948.png]]

This actually cause a constant max amplitude signal, even with the vibration isolation:

![[Pasted image 20260607101826.png]]

You can see a bunch of resonant peaks here.

In particular the above setup many seconds for the signal to settle down after receiving an impulse. But it was also completely insensitive to sound. Chopping the long cantilever left off, and adding a piece of foil to catch more air gives this:

![[Pasted image 20260607113244.png]]

But this too takes a long time to settle down:

![[Pasted image 20260607113418.png]]

So I think these undamped setups are just really bad. I placed a small dot of UV glue here:

![[Pasted image 20260607115749.png]]

Which was designed to stop the 'undamped cantilever' action that was clearly happening earlier. I can see that the decay time is improved, it's now around ~1s, but it is still clearly not good enough. Not only is 1s longer than I would like, but also the setup is quite insensitive to sound. The cantilever + glue drop + glass mirror chip is way higher mass, I guess.

### Kirkland seafood snack bag

The inner surface of this has the exact same brushed surface as aluminium foil, and there is a corresponding grating like effect too whereby the reflected light is elongated in a single direction. I had always thought these were deposited in a vacuum, but I guess not.

### Voodoo chips bag

![[Pasted image 20260607130947.png]]


This one clearly did not have a brushed finish, and indeed it focuses down reasonably well onto the photodiode:

![[Pasted image 20260607130656.png]]

But the output is picking up a lot of noise from somewhere:

![[Pasted image 20260607131053.png]]

This is interesting. The Chip packet is obviously very light, that's the point. So I would have thought that the only thing it was capable of picking up would be audible noise transmitted through the air. I know that the baseplate is not vibrating too much, that's what [[20260528 Vibration isolation mechanical#Rigid mounts|this section]] showed (I thought). This lined up with what I saw with the copper tape above, where when there was no ambient noise there was also not much in the way of signal output.

Obviously that is not the case though