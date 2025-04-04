# What it looks like

  |  
:-----------------------:|:--------------------------:

![[Pasted image 20220412210459.png\|400]]  |  ![[Pasted image 20220412210630.png\|400]]
...Obviously the absolute values aren't so crash hot here but directionally this seems to be 

# Debugging the power supply

![[Pasted image 20220412210731.png]]

### The culprit:

![[Pasted image 20220412210239.png]]

An 8.2R resistor went pop:

![[Pasted image 20220412210803.png]]

After replacing that with some regular through hole resistors that shorted on the other side accidentally, another resistor went pop:

  |  
:-----------------------:|:--------------------------:

![[Pasted image 20220415174018.png\|400]]  |  ![[Pasted image 20220415174159.png\|400]]

## Debugging things that need to be redone:
- ~~Removed 100R resistor R14~~
- Removed one of the transformer windings.
- remove 0.2R resistor in the corner, R15

## Components of note:
- Replaced 8.2, 10R 5W resistor
- 2SK1217 transistor
- JZ1AF-12V-TV relay

## Catching up
It is now  20221126  and so I am trying to piece together  why  I did what I did. I have a variac now so I  think the strategy  is to plug stuff in and then find out  where it's shorted without the spectacular explosion and arcing of prior efforts.
I have here a STR-83145,  I don't know  why I desoldered it.

I also noticed that the resistance between VCC and GND of the M51995P:
![[Pasted image 20221127203516.png]]
switcching controller was low, and so I powered it up with   20V. This caused a lot of current draw (300mA, 5V) and so I conclude it's most likely busted. I'll pull it off and power it up isolated to be sure though.
Amazingly when pulled off the board the chip seems fine! there's no switching or anything, but the FB pin is at the right voltage and there's no short to ground or anything. There's no short on the pcb side either, which begs the question of how this fault came about. I think I will poke about more and find out.
The datasheet for the M51995P has a reference schematic that looks quite a lot like the power supply I am investigating:
![[Pasted image 20221127172609.png]]
In particular I  think  the bajillion transformer windings are relevant. 

## eeproms from the internets
Great webpage with the manuals:
http://ftb.ko4bb.com/getsimple/index.php?id=manuals&dir=Advantest

![[Advantest_R3271P_Spectrum_Analyzer_EPROM_G05.zip]]
![[Advantest_R3271_Spectrum_Analyzer_EPROM_B01-R3271.zip]]

## Sunk cost
This power supply is wayy to complicated. I clearly need to sit down and absolutely nail down the whole schematic at this point if I want to make progress, and I don't want to do that. Fortunately the manual specifies the pinout of the power supply:
![[Pasted image 20221127210613.png]]
And so all I need to do is supply all these voltages. I think I can scrape together enough power rails to get this thing to work.
