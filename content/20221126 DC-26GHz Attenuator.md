# Problem
I have  a  [[20220412 Advantech debugging|Spectrum Analyzer]] that doesn't work.  The frontend attentuator  for it also does not work. Opening up the attenuator, we can see this:
![[Pasted image 20221126142350.png]]
It looks like a pretty straightforward setup.  A set of latching solenoids depress the black plungers on either side, either bypassing (bottom path) the attenuator, or switching in (top path) different valued attenuators. Only one  problem: there is no connection on the right hand side to the connector!
This should  be a simple matter to fix,though. A small amount of spring steel in the right spot combined with a dab of plastic and cyanoacrylate:
![[Pasted image 20221126142559.png]]
And boom - fixed.
## Or is it?
The two regular attenuators turn out to be flat -20 and -40dB attenuations as measured by my NanoVNA, but the replaced one looks like this:
![[Pasted image 20221126143621.png]]
...That aint so great.
Further inspection reveals that the attenuator seems to have burnt out -  it's open circuit across the attenuator and to ground on one side.
