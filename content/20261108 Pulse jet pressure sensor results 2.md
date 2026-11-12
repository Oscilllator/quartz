
# Changes
From [[20261018 Pulse jet pressure sensor results|last time]]:
- Remade the linear rail entirely to have a much longer travel:
![[Pasted image 20261108201508.png]]
Now the pressure can be measured from the entrance of the air intake to just into the exhaust outlet

- Electronics replaced with vibe coded pcb, courtesy claude:

![[Pasted image 20261108201555.png]]
Mr Claude did a much better job with the power supply rails than the [[20260922 Pressure sensor electronics#AD620 amplifier|previous]] analog amplifer, so the SNR of the pressure sensor is much better.

- "Reference" sensor replaced with actual audio sensor rather than contact piezo mic. No problems rapidly deteriorating measurements, hopefully.

# Results
Here is one of the more successful data collection runs, as a view into the raw data. Unfortunately this time around the shop compressor was not available to provide air, so a ducted fan was used. I don't think this was able to provide quite enough though as the operation of the pulse jet was intermittent.

![[Pasted image 20261108202258.png]]

Here is a closer view into one sweep with the areas of continuous and intermittent operation laid out:

![[Pasted image 20261108202709.png]]

And a single such burst:

![[Pasted image 20261108203059.png]]

I'm not sure what's going on here. Presumably there is some stability criteria for engine oscillation that's not being reached. You can see though that the amplitude builds for a couple cycles. So the positive feedback required for oscillation works for some short period of time, then something causes it to fade. This is not what you would expect from an 'underdamped' system where you would have one big pulse and then either a decay (overdamped) or a bunch of trailing oscillations with gain <1. 

Alternatively, it also kind of looks like a high frequency signal being modulated by a lower frequency signal. I'm not too sure what would cause that, though.

### Reference instability
Last time the plain old SNR of the piezo measurement was poor. This time it's reasonably good, I think, but nonetheless the variability in the mic measurement is far higher than that of the pressure measurement. Here is an example:

![[Pasted image 20261109075500.png]]

The pressure waves are reasonably consistent. but for whatever reason the microphone signal has much more variability.  Here is a time slice from a bit earlier in the same run, but with the motor at the same position:

![[Pasted image 20261109075646.png]]

This is a bit better, but still not great.