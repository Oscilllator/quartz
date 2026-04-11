I had the idea of using a contact microphone attached to your belly to monitor digestive function. [Here](https://www.amazon.com/dp/B0GGBQ7HMK?ref=ppx_yo2ov_dt_b_fed_asin_title&th=1) is the one that I bought:

![[Pasted image 20260322152122.png]]

It has a diameter of ~20mm and an input capacitance of ~25nF.

Hooking it up to the scope, I can see my heartbeat in my wrist quite clearly:
![[Pasted image 20260321151831.png]]

But, interestingly cannot see it in my neck. Attaching it to a headphone amplifier and routing that into headphones reveals some interesting stuff, but the headphone amplifier has an input impedance of apparently 17kR, which is too low to be able to pick up lower frequency content.

### Time constant from scope

Here is the response to a well calibrated finger-press square wave input:

![[Pasted image 20260321152817.png]]

So with the 1Mohm scope input, the time constant is ~50ms apparantly.


# High input impedance amp

Per the above I figured I needed a high input impedance amplifier in order to be able to pick up the tummy rumbles properly. I got [this one](https://www.amazon.com/dp/B09JZ82WBP?ref=ppx_yo2ov_dt_b_fed_asin_title)

![[Pasted image 20260322152247.png]]

But after soldering on a 3.5mm jack attachment, powering it up, and figuring out I needed to max out the 'bass' knob, The signal looks horrible!

Here is the 20mm disk piezo again straight into the scope, showing the push/release signal:

![[Pasted image 20260322151824.png]]

pretty clear AC coupled signal. Now here it is, coming out of the amplifier:

![[Pasted image 20260322152045.png]]

This is horrific. huge amounts of mains hum, and the signal is clearly wildly unstable for some reason. I note that the original piezeo pickup that came with the amp had a wire mesh shield all along it. Given how incredibly cheap it was, that was probably pretty necessary shielding and explains the mains hum on the disc piezo, but it does not explain the stability of the amplifier here.

Perhaps ~10xing the input capacitance of the amplifier made it unstable. The input amp is a TL062c jfet input amp:

![[Pasted image 20260322153034.png]]


## Schematic

Not particularly complete

![[Pasted image 20260404094645.png]]

![[Pasted image 20260325212233.png]]

# Crosstalk

The above board has a "feature" whereby the output is disabled and instead run into some tuner thing so it can tell you if your ukulele is in tune. To get rid of this I disconnected the output and then wired up the OUT2 of the LM358 through a cap into the output directly. No more problems here.

Now onto the recording. I powered the PCB off of a USB 5V rail, to which I also had a teensy attached with an audio shield. That way I can do actual recordings of the tummy rumbles and have a way of correlating food with rumble times and so on. Only problem is, there is:
a) Huuuuge mains crosstalk
b) Also a lot of crosstalk directly from the power supply. Asking mr claude to make a script that turns the CPU from max load to 0 at 300Hz results in a very loud noise in the headphones:


![[Pasted image 20260404095116.png]]

My vague understanding was that stuff like "power supply rejection ratio" of op amps was supposed to solve this, but clearly not.

...turns out that the ground side for the bias midpoint of the first op-amp was hooked up directly to the RING connection of the aux jack that plugged in. Because of my odd wiring, this output was disconnected and so the bias was pulled to one of the rails, which caused the strong coupling from the power supply rail. after shorting this line to ground, the noise from the teensy disappeared.

### Output measuring heartrate again:

![[Pasted image 20260404110716.png]]

The system is extremely sensitive now, though it seems to have a huge amount of high frequency noise in it. this seems to be mostly outside the audible range so hopefully won't cause too many problems. In the headphones, the heartbeat is accompanied by a bit of clicking so I think it might actually be saturating at one of the amplification stages.

## At each stage

### Directly measuring piezo:

![[Pasted image 20260404111601.png]]

### Output of stage 1:

![[Pasted image 20260404111832.png]]

...yeah that's already pretty bad. what's going on??

This whole circuit has 4 stages of amplification for some reason. I think I just need to rewire it so it has one, and cut out all the funny business.

### Simple buffer

Let's rewire to try to get this, and see how it goes:

![[Pasted image 20260404114548.png]]

...nope, the power supply noise is super audible. I got claude to change the cpu loading so it ramped between 100 and 300Hz over a few seconds, which created a distinct siren noise in the headphones. This is what the FFT of the power supply rail looks like:

![[Pasted image 20260404123236.png]]

# new amplifier, new problems.

I replaced the old guitar amplifier with a AD620 instrumentation amplifier from [amazon](https://www.amazon.com/dp/B0B6VJ7V45?ref=ppx_yo2ov_dt_b_fed_asin_title):

![[Pasted image 20260408075421.png]]

This new one has two problems:
- It has a charge pump, and there is massive coupling between the charge pump switching and the output. The BOOST pin seems to have alleviated this somewhat
- There is much stronger coupling in this design between the power rail of the teensy and the output. The above mentioned triangle siren ramp is extremely loud. Putting a but electrolytic on the 5V rail and on the -5V rail did not help with this. Probing the rail with a scope suggessts there is ~20mV of noise.
On this last part, it's unclear to me if the issue here relates to the actual power supply, or some kind of grounding problem between the output of the amplifier and the mic ground of the teensy, since presumably the two are coupled.


### Teensy audio shield grounding oddity

For some reason the MIC GND of the teensy audio shield is wired out to a GND pin on the header, and that pin on the CPU board is a regular power ground, resulting in the MIC GND being shorted to the power GND:

![[Pasted image 20260408200951.png]]

Seems like that might cause some issues.

## Solution

The above AD620 eval board had a potentiometer and buffer to adjust the null point, the output of which went into the ref pin. The output of the AD620 is referenced to this pin, so power supply noise was directly coupled in. instead, the pin was shorted to the MIC ground which handily removed all the power supply noise.

Now I can get these great plots:

![[Pasted image 20260408205129.png]]

So far, I've been trying to keep the amplifier working down to as low of a frequency as possible. I'm seeing now though that this isn't a great idea. the amplifier can easily sit at a large offset for many seconds, during which the output is completely saturated.

# Recorded audio
I've now got things to the point where I can clearly hear tummy rumbles in the pickup mic, whilst sitting still. There are couple of weird things to iron out though
- Sometimes the audio signal fades out periodically. This may be due to heartbeat
- Noise from clothes and so on remains extremely high.

Here is a section of the audio signal loaded into audacity, showing the periodic fading clearly:

![[Pasted image 20260411102221.png]]

![[rec_019_periodic.wav]]