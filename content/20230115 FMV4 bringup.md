The FM4V pcbs have arrived. This time I used the jlcpcb assembly service. The PCB's look like this:
![[Pasted image 20230115192501.png]]

The oscillator comes up without any prompting thankfully. The first thing that I want to look at is the 915MHz amplifier.

## Assembly problems
![[Pasted image 20230115193957.png]]
Some dingus soldered a 0R resistor onto R65 which understandably. Once that was removed the amplifier turned itself into a 700MHz oscillator. Nice. Since the VCO is right next to the amplifier I'm going to turn it off by desoldering R53 and then trying again.
That fixed the oscillation, but there is now a bunch of crosstalk coming somewhere from the 10MHz system. The fastest edges there come from the NAND gate, and indeed the interference concides directly with an extremely sharp falling edge there. Disconnecting the phase detector by desoldering R5 gets rid of it entirely.
The amplifier has huge attenuation. Perhaps this has something to do with how someone put a 0R resistor in R64.
Removing that resistor we get this:
![[Pasted image 20230116113736.png]]
This is with 20dB attenuation from the attenuator, bottom line is ref through a THRU trace on the ufl RF demo kit.

## Optimising
The BFP420 should have way more gain than this though:
![[Pasted image 20230116114145.png]]

So let's measure some important parameters:
- Vbe = 0.951V
- Ic = 2.79 / 50 = 55mA
- Ib = 3.59 / 4700 = 0.76mA
...This seems like it's being driven rather hard.
![[Pasted image 20230116114826.png]]
And indeed we seem to have travelled off the end of the x axis. Absolute maximum is 60mA though and transistor doesn't seem to be _too_ toasty, so we should be still OK.
I think I want this amplifier to have a fairly low output impedance so as to be able to drive the mixer nice and hard, and so instead of increasing R71 I will increase R57:
![[Pasted image 20230116120237.png]]
I think we want somewhat less than a factor of 10 less bias current, so I'll go with 33kR.
...aaand the transistor seems to be blown. I resoldered another one, but for future reference the current draw without the transistor attached is 91mA. Since the regulator is a linear one, any deviation from this is the current consumption of the circuit.

With R57=33k and R71 still 50R the Ic is 11mA, Ib is 3.6 / 33k = 0.1mA. Looks like this was the desired Ic adjustment, but the gain looks like this now:
![[Pasted image 20230116151913.png]]
Which is quite a bit worse. The S11 smith says that the input impedance is 55+j20R. I'm not sure but that sounds pretty close to 50, sufficiently close anyway that the 20dB performance gap is not explained by it. 
The application note has a pretty big inductor (about 50R at the target freq) in series with the input for 50R matching though, and I also notice that the input impedance of this thing barely changes with turning the device on and off. Also the app note for 'high impedance input' has basically the same circuit as I do, so I think there might be something fishy going on here.
...Measuring the input capacitor, it's 5pF. I should check the BOM that got sent out cause it sure looks like the JLCPCB people got a lot wrong here. Using a 300pF capacitor gives this input impedance (0-915MHz):
![[Pasted image 20230116155442.png]]
Which looks much more like the application note (high input impedance at 100MHz).

## Input matching
I think that I should initially run the system at 300MHz, to be comfortably within the scopes 500MHz bandwidth.
At 300MHz the input inpedance of the amplifier is 0-128jR. ~~~Referring to [[20221025 antenna tuning#50R matching.]] this means:~~~
Adding in an inductor of ~128R cancels the impedance at 300MHz:
![[Pasted image 20230116173634.png]]
But that's not really what I want cause the impedance is wayy too large. Doing the maths in the Hagen textbook I don't really see how it's possible to match a purely imaginary impedance to a real 50R system. The imaginary bits just shuffle around. But there is an example in an [application note](https://www.infineon.com/dgdl/Infineon-Design_Guide_for_low_noise_TR_in_FM_radio_FE-ApplicationNotes-v01_00-EN.pdf?fileId=8ac78c8c7e7124d1017f0227976a6c9d)
![[Pasted image 20230116173837.png]]
So I will try to assemble this and then see what I measure. 
The exact transistor I am using isn't one of the examples, and the match is supposed to be at 100Mhz. This is what I get:
![[Pasted image 20230116175258.png]]
Where the impedance cr
