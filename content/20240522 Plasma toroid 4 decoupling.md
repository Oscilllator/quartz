[[20240424 Plasma toroid 3 Aluminium#Voltage measurement of decoupling|Previously]] I measured 2 volts peak to peak across a <5mm long piece of wire, and decided that this was a result of "bad decoupling" and "inductance" and that I should "decrease my current loops" and "make sure the MLCC is placed close to the half bridge". Well, I did all that:

### Old

![[Pasted image 20240522204041.png]]
### New

![[Pasted image 20240522203901.png]]

Better layout, right? Well, here is what the Oscilloscope sees when it measures from point 1 to point 2 above:
## Measurements
You'll notice that these are directly adjacent points on the ground plane:
### Oscilloscope probe

![[Pasted image 20240522204242.png]]

![[Pasted image 20240522204446.png]]

And that there seems to somehow be 2V across this ground plane. I found this rather implausible, and so decided to measure with my current probe:
### Current probe

![[Pasted image 20240522204306.png]]

![[Pasted image 20240522204339.png]]

HMMMMMM. A strikingly similar graph, I am sure you'll agree. Perhaps my decoupling is completely fine and the scope probe is just acting as a current probe!

![[Pasted image 20240522210000.png]]