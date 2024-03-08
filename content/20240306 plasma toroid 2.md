Instead of having a class whatever oscillator with zero voltage switching nonsense to not blow up the FET, how about a simple push pull half bridge to drive the LC oscillator directly:

![[Pasted image 20240306195043.png]]

Something a little like this:

![[Pasted image 20240306195108.png]]

The only trouble I had with this was finding a gate driver that claimed to be able to switch fast enough. [[20240208 plasma toroid#New circuit|previously]] the FET driver would smoke out after a few seconds of operation.

The PCB looks like this:

![[Pasted image 20240306195458.png]]

Anyway, after lowing up the FET driver once and resoldering, I get this:

![[Pasted image 20240306195239.png]]

Green is high side FET gate, cyan is low side FET gate, yellow is middle of the half bridge, maths is top FET gate - middle of half bridge (so the gate-source voltage of the top FET). And finally purple is after the inductor.
So now all that needs to be done is crank up the frequency to the frequency of the purple oscillations, and bam! plasma toroid.

![[Pasted image 20240307204728.png]]
