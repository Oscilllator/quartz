

## Chosen design
This is from "Summary Report on Investigation of Miniature Valveless Pulsejets", 1964.

![[Pasted image 20260908214108.png]]
![[Pasted image 20260908214516.png]]

Picked this one (I think it was this one?) because it was straight, valveless, and had actual performance data associated with it.

### CAD

![[Pasted image 20260908213809.png]]

This got ordered from sendcutsend - the inlet and two tail sections were just ordered as three copies of the outer tail section to save on bom cost, and also that gets a bunch of scrap material for later:

![[Pasted image 20260908221043.png]]

## Combustion chamber welded up

![[Pasted image 20260908214717.png]]

This was done with a couple kw laser welder. Makes things pretty easy.
## On a stand

![[Pasted image 20260908213535.png]]

## Extra high emissivity paint

One idea for observing where the combustion is happening is to just look at the device with a thermal camera. As it is, however, the shiny metal surface is no good as it's too reflective. But a quick coat of a magnetite/bentonite slurry gives good results:


![[Pasted image 20260908215025.png]]

In the above picture you can see that the area just after the combustion chamber somehow got partially converted from Fe3O4 to Fe2O3. Although it's clearly because it reached a higher temperature, interestingly it seemed to only occur _after_ the heating during the cooling stage when the vessel wall was only a couple hundred C.

![[thermal_camera_20260907_160813_first20s_landscape_ccw.mp4]]



# Stability, or lack thereof

This is where we ran into troubles. The pulse jet can be started if the fuel injection tube is positioned in the right location. The right location seems to be just inside the combustion chamber, with the fuel injection tube pressing up against the wall of the chamber, not in the center. Why? I don't know.
## Slow motion (1/8x) speed flame combustion

![[PXL_20260907_222844334_1m40-1m50.mp4]]

Doesn't really look like there's much to learn here.

### On starting with and without a compressed air nozzle

We were starting the pulse jet using a compressed air gun as a source of air as opposed to a leaf blower or ducted fan. Interestingly the pulse jet starts up well when the restriction is used on the end, but not when it isn't:

![[Pasted image 20260908221658.png]]

This could be either because the narrow jet of air is more turbulent and does a better job of fuel-air mixing, or (more likely) just that the fast jet entrains more air in a venturi effect and so more is delivered down the inlet of the pulse jet.

### Pressure sensor idea

The academic literature generally uses piezo transducers to measure the pressure waves at a number of points across the combustion chamber of a pulse jet. There is a problem with this though:
- A piezo element is inherently sensitive to vibrations, since as you accelerate it back and forth a force is placed across it
- The wall of a pulse jet is subject to huge vibrations
Hence, the piezo element will pick up a large signal that is of the same frequency roughly of what you 

![[Pasted image 20260909075249.png]]