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

![[Pasted image 20260325212250.png]]

![[Pasted image 20260325212233.png]]
