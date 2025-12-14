
# Hardware

The LED that I have been using to pipe light into my microscope light pipe has a pretty hefty forward voltage, around 55V:

![[Pasted image 20251207211210.png]]

This means that I need to power it from my two output bench supply with the two outputs in series. The fact the supply is super dodgy and prone to resettting its settings spontaneously does not help. So I asked Mr GPT and the all new Gemini 3 for a LED driver that would fullfill the requirements. It seems all mains-based LED dimmers use a 0-10V control voltage input, which is rather inconvenient. So I went with the suggestion from Gemini 3 and got a LED backlight driver circuit:

![[Pasted image 20251207211426.png]]

This worked great:

![[Pasted image 20251207211444.png]]

Right up until I rammed the fiber optic end of the cable into the light, at which point everything turned off and stopped working. I surmise this is because the metal end of the fiber optic cable:

![[Pasted image 20251207211628.png]]

shorted out the two pins of the LED, and the driver went kaput. 
# Debugging failure.

[Here](https://www.youtube.com/watch?v=WbFgA-E_BcY) is a youtube video with an unfortunate amount of glare in it that lists the schematic of the driver board I used:

![[Pasted image 20251207211912.png]]

so it's a pretty standard boost circuit with some current feedback. Here is the drain of the MOSFET of my circuit, which has failed somehow and is only outputting about a volt higher than the input voltage:

![[Pasted image 20251207212018.png]]

Looks kinda like it's working in that the output voltage spikes higher than the input, but it is clearly being capped somehow.  The circuit is not drawing that much power so it's not like it is furiously dumping all that energy somewhere. I've also disconnected the LED from the circuit, so the output should just float up to as high as the rail will go.
