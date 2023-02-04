Schematic:
![[Pasted image 20230129184412.png]]

It seems that  the FET drive has a lot of ringing. Probing R2: 
![[Pasted image 20230129184447.png]]
I added a 10R resistor and this helped.

The next step was to debug for a long long time and then realise I hadn't connected all my grounds together in the layout. Oops. After that I get this:
![[Pasted image 20230201181734.png]]
Green: input
Yellow: top side of thin (~50um, 20mm) wire.
Ref: bottom side of said wire.
VCC is 32V here.
Time to crank up the volts.
---
I believe the main problem that I am having here is that my capacitor is garbage. I have ordered some more.