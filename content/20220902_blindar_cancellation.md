# Coaxial small lidars.
All small lidars are designed for short range. Short range lidars need to have a very close minimum detectable range(duh).
I have noticed that every single small lidar I've seen uses a biaxial system. It might on some level be easier to manufacture these, but I believe one major reason for this is that a coaxial/monostatic system would suffer too much from crosstalk from the lens etc.
Normally the way crosstalk is removed is by sampling the waveform and subtracting a known crosstalk reference. But ADC's fast enough to do this are expensive and high power, and this is another point against using them in small systems.
Crosstalk-free systems can use simple digital edge detection for their waveforms, which is _much_ cheaper.

# Solution
It should in principle be possible to cancel the crosstalk pulse from the receiver in the real analog domain. This could be done a number of ways.
- Play back a known waveform with a DAC to subtract things out.
    - DACs are cheaper than ADC's but this is still most likely fairly expensive.
    - This has the advantage of guaranteeing no interference from the real signal
- Measure the current flowing through the photodiode and use that as a reference for subtraction
    - This assumes the current->photons transfer function is linear, which it isn't. Especially with these high power pulsed lidars the relationship may well be garbage. Experiments needed!
    - There will be a small time delay between the measured current and the received crosstalk. Should be sub-ns and fixed, but still would most likely require addressing. I think a delay line of some kind may be appropriate here
- Measuring the crosstalk with a separate photodiode and subtracting that
    - Have to make sure that the signal photons don't hit the 'reference' photodiode. This could perhaps be done by putting the reference photodiode in a different location and then having a couple of baffles and perhaps even a reference surface on the tx side to get a measurement. This would work well I think when perfectly aligned but would be prone to drift with very small mechanical changes (inevitable in a cheap plastic consumer product). A feedback loop might be able to take care of things here. 
    - Has by far the highest potential for best cancellation - same photodiode, same frontend etc etc.
    - Depending on whether the subtraction is done pre or post first stage amplification this could have a sensitivity impact.
    - Lidars use avalanche photodiodes, and avalanche photodiodes have mighty poor linearity. This will be a problem for any cancellation scheme (since we are cancelling a noisy signal) but will be an especially large problem when trying to cancel one noisy signal with another. There might be some implicit sensitivity hit here since the excess noise of a APD goes down a lot with the gain.  
Hobbs' building electro-optical systems has some good words to say on this (section 18.6), especially the use of what looks an awful lot like a current mirror for cancellation.
It worrys me a bit though that he says:
"
In a measurement whose sensitivity is limited
by laser residual intensity noise (RIN), the noise canceler can improve the SNR by as
much as 70 decibels at low frequencies, and by 40 dB up to 8–10 MHz or so, as shown
in Figure 18.21.
"
We want hundreds of MHz! That sounds like things will just stop working by the time we get there!
Maybe that's because his system doesn't have a cascode-like property, and the bandwidth can be easily increased? I don't know, and I need to understand the circuit better.
The guy also likes to go on about "etalon fringes" and whatnot for the circuit. tbh I don't even know if he's assuming a coherent system, alhough it for sure looks like regular intensity cancellation is what's going on.
The guy also claims to have used it for a fmcw lidar...
