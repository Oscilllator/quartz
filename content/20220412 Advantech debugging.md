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