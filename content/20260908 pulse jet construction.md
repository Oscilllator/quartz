

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
Hence, the piezo element will pick up a large signal that is of the same frequency of what you are trying to measure. If you aren't careful in isolating and calibrating out the signal you want the results will look quite plausible and be completely wrong. Most pulse jet papers that have a waveform in them of the pressure at various points in the combustion chamber, for example the [german one](https://harrydb.com/heise-pulsejet/index.htm) that is so promising for supersonic operation. But unless they account for this the results will be garbage most likely.

So how about this idea:
![[Pasted image 20260909075249.png]]

I feel like this could actually work. Mr claude of course agrees, but I did not find its analysis convincing.

However it does have the problem that you have to make a new one for each new location that you want to measure the pressure at.

### Pressure sensor idea 2

A better idea that was suggested to me would be to have a pressure sensor on the end of a stick, and then sweep the stick down through the pulse jet. The pressure sensor would of course have to be water cooled somehow, but the idea here is that if you put the pressure sensor down the end of a tube with a long enough l/d ratio, then maybe the airflow at the bottom would become stagnant, and so the head transfer into a small sensor at the bottom would not be that bad. Something like this:

![[Pasted image 20260909210507.png]]

## Pressure sensor idea #3

I buy a noncooled pressure sensor like [this one](https://www.ebay.com/itm/306888344994?utm_source=chatgpt.com), a [XCQ-093-50SG](https://kulite.com/assets/media/2017/06/XCQ-093.pdf?utm_source=chatgpt.com) and stick it in a cooling jacket. Like this:

![[Pasted image 20260913154531.png]]

The orange part above can be printed from stainless steel for cheap, and goes inside two stainless steel pipes. The wire for the sensor will go all the way up the center pipe. At the other end of the pipes I'll 3D print some doodad to enable water in/out + electrical connections. Then, since the whole thing is a 1/2" rod basically, hopefully it can be swept down the combustion chamber whilst the combustion chamber is running and the direct pressure vs axial distance function can be obtained (with the aid of one external microphone to get a phase reference.) 

Provided that the pressure sensor does not interfere with the operation of the pulsejet this will be far superior to the "3-4 monitors going through the case" tactic that most people seem to use.

### Simulation

I gave the above section alongside the relevant step files to Mr Sol medium and told it to calculate the flow resistance. It came up with [this interactive 3D CFD report](https://harrydb.com/static/water-jacket-cfd.html).

You can see from it that there is a constriction at the three vents that lead to the outer annulus for the return path (point 2) and also at the construction where it has to go around the actual sensor (point 1):

![[Pasted image 20260914073918.png]]

These results actually look pretty good - this is the first time I've gotten useful one-shot CFD results out of a model. You can see that a lot of the pressure is being dropped around the three slots that connect to the outer annulus of fluid, so I increased their size by a lot and put a small taper at the top:

![[Pasted image 20260913212254.png]]

Re-running the simulation gives [these updated 3D CFD results](https://harrydb.com/static/water-jacket-cfd-widened.html). You can see now that the previous restriction is gone:

![[Pasted image 20260914074026.png]]

### Clearance vs press fit

I had originally intended the tubes to be epoxied in place, but perhaps that won't work out for thermal reasons. So I added a variance that does a press fit on the end:

![[Pasted image 20260914075537.png]]

Hopefully we can rescue the design if the gluing doesn't work out.

## Experiment jot down.

Some quick experiments we did whilst waiting for the 3d printed parts to arrive.

#### Measure thrust
Run a strain gauge to try and measure thrust whilst the pulse jet was operating. There was ~0 thrust of course and the web app served by the esp32 was super slow and flaky even after claude worked on it a while trying to get good retransmission and dropout resilience. So I'm switching to a good ol serial port to a computer.
#### Measure effect on operation with a dummy sensor
Get a 1/2" rod (the same diameter as the real pressure sensor will be) and stick it gradually down the throat of the pulse jet whilst it was operating, to see if it would affect its operation. It didn't stop it from operating and in fact made it work quite a bit better (or at least louder) in some locations. When you look at the actual construction of the pulse jet:
![[Pasted image 20260919124242.png]]
For some reason the outlet is bigger than the inlet. That seems odd and pretty unintuitive to me, but sure enough the [[#Chosen design]] above has that. Worth searching about and seeing why this is the case.
#### Heat transfer
We didn't have a proper thermocouple meter, but we did have a thermocouple. Got a 1/2" copper pipe, and put a smaller copper pipe down it with a thermocouple taped to the end. Flowed water down the inner pipe and out the outer pipe. Blasted the engine and tried to measure the thermocouple voltage. Got to about 0.3mV. But the water flowing back out was pretty warm to my hand, probably at least 40C. What does this mean? It means bring a thermocouple reader next time. fwiw mr GPT says that 0.3mV corresponds to 32C, which is in the right ballpark.

# Data collection

## Test setup:

![[Pasted image 20260922123702.png]]

## Data

I ported the previous data collection system from streaming to a web app over the esp32's wifi connection to a serial port. Unsurprisingly this is much more reliable. However, there are still quite a lot of data dropouts when the spark plug is running, visualised here:

![[Pasted image 20260922123237.png]]

Unlike last time though when the spark plug is turned off, data is streamed without loss when the pulse jet is operating (spark plug is only required for startup). So this means that we can finally get a first official measurement of the thrust of the pulse jet:

![[Pasted image 20260922123447.png]]

A whole 80g of thrust! 40% of the thrust in a straight-tube configuration apparently comes out the inlet, so this means that the "gross" thrust is probably `~80*1/(0.8-0.6)` 400g. that's kind of in line with what's plausible.

## Inlet restriction.

You can see from the above test stand photo that there is a threaded rod jammed down the inlet. In fact the threaded rod has a nut+washer on the end of it. If you position it in just the right location (and the fuel line of course) then the jet is able to operate by itself with no compressed air assistance indefinitely, which is the first time we've gotten this far. In hindsight this kind of makese sense because you would think you would want the inlet smaller diameter to the outlet. But hindsight is no basis for an engine program and so I think a good next step here whilst waiting for the water jacket 3D print to arrive is to take a look over the literature and try and find design rules of thumb, debugging techniques, etc to help build intuition as to what design change should be made. Currently we just wiggle the fuel line around until it's just right to get it to operate but I don't think we can do that all the way to a supersonic airplane.
