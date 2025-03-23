
The fuse on this guy:

![[Pasted image 20250322114903.png]]

Blew when I turned it on with the output shorted one time. I opened it up and saw that this random resistor was getting very hot:

![[Pasted image 20250322115109.png]]

It actually kept going and got to 120C, and the rise wasn't stopping. Also the fuse was blown. I thought this mean that there was some component failure that caused both the fuse to blow, and for the resistor to get so hot. 

[Here](https://www.davmar.org/pdf/LambdaLPD.pdf) are the schematics for the board in question:

![[Pasted image 20250322115253.png]]

But since this is a dual output supply, I took the fuse out of the channel that was fine. Then that channels R143 got to >100C too. Then I put the fuse of that channel in the broken channel, and everything was fine.

So actually the problem was just that when the fuse blows, the resistor gets super hot. Waste of time tracing out transistors and so on, but easy fix.