A good introduction and guide on how to make a fluxgate magnetometer can be found in the [Wireless world magazine, 1991](https://www.worldradiohistory.com/UK/Wireless-World/90s/Wireless-World-1991-09.pdf). I didn't really follow the guide but if you read it you'll get the general idea.

# Version 1
The idea of winding a toroid sounded too hard to me so I made two separate linear coils and connected them with some magic magnetic tape. Here are the two windings before I added the sense coil:

![[Pasted image 20240701184124.png]]

And here is what it looks like "fully assembled":

![[Pasted image 20240701184432.png]]

I drove it straight out of the signal generator and amazingly it worked out of the box. It's quite sensitive and was able to detect my twiddling of a bar magnet like 5 meters away!
This is quite significant as it represents the first time I have ever built an electronic device and had it (1) work on the first try and (2) had it be more sensitive than expected. I suppose it makes sense now how they were able to get them good enough in WWII to detect submarines from a plane.

The limit on the detection though was the 0 level. Even when I aligned the sensor such that it was normal to the ambient magnetic field, there was still quite a large signal measured on the scope. Reading around a bit ("Magnetic sensors and magnetometers" is a sensible book) it seems that one of the main reasons to use a toroid is that it evens out the variations in manufacturing that are the result of these residual errors. 

Since the magnetometers measurement comes from the asymmetry in how each side of the device magnetises/demagnetises, it makes sense that this would be worth switching the design.

# Version 2

So, time to suck it up and wind a toroid. The book also mentioned that one way to get low variation in your wound toroid is to wind it such that there windings are just touching along the inner race, since then the wire diameter is what sets the pitch. Good advice but that results in far more windings than is required in practice and I realised just after I started winding that I could have printed some notches in my 3D print which would have also defined the winding spacing and not required me to wind 7m of wire through a 35mmID toroid. Oh well.

### Toroid construction

Here is the inside of the toroid. I put two strips of metal ~2.75mm wide (hand cut with scissors, naturally) into the toroid which was sized to just fit the length of the strip.
![[Pasted image 20240701184920.png]]

And here it is all wound together:

![[Pasted image 20240701185051.png]]

...Not exactly a precision device, is it? But the 3d printed outer sense coil winding is critical. By rotating the inner toroid with respect to the outer one, I can move it to a point that minimizes the measurement when the sensor is perpendicular to the earths field. This makes quite a bit of difference.

### Zero field

Here is the output of the sensor, showing the maximum, minimum, and zero measurements achievable here on earth:

![[Pasted image 20240701185559.png]]

So that's (3.2 - -2.5) / 55e-6 = 100mV/uT. That's 103kV/tesla, which sounds good. That's also 10000 gamma/volt, and the above magazine article calibrates it to a maximum of 100 gamma/volt, or 100x more sensitive.

### Magazine schematic:

![[Pasted image 20240701190306.png]]

![[Pasted image 20240701190311.png]]

![[Pasted image 20240701190324.png]]

## Gating and filtering

Here's an idea: The signal has 0 DC level. So what we really want to do here is rectify it. But, the signal is small. So instead we can just grab the section of the signal that has the spike in it, and average around that!

Like this:

![[Pasted image 20240701190754.png]]

ta-da! Done using an SI2302 analog switch, aka a mosfet as recommended by the Art of Electronics:

![[Pasted image 20240701190843.png]]

It introduces a huge amount of charge injection but I'm going to wave my hands and say it's fine since the + and - section average to 0 anyway. Filtering this chopped signal and zooming into the noise floor, we get:

![[Pasted image 20240701193547.png]]

Which sure does look an awful lot like mains. So I guess we have reached the noise floor of this particular environment.

## Alternative to gating and filtering

I got annoyed at the above gating because of the charge injection that I couldn't get rid of. I tried adding a complementary pmos and when that didn't work gave up. Instead, how about rectifying the signal? It would need to be amplified first but that's OK as my boards with a bunch of amplifiers came in.

Here one is:

### Amplifier
![[Pasted image 20240702204618.png]]

It has a 10MHz gain bandwidth product (TP2311) so that looks about right.

![[Pasted image 20240702212131.png]]

here is what the magnetometer looks like detecting a 1KHz sine wave:

![[Pasted image 20240702212010.png]]

The magnetometer is being driven at 70kHz.

### Bandpass filter

![[Pasted image 20240702214700.png]]

![[Pasted image 20240702214711.png]]

...Not great.

## Using magnetometer to sense 11kHz magnetic field.

This is starting to get a bit tricky. I angled the magnetometer such that it was not receiving much magnetic field. Then I strapped a coil to it, and excited the coil at 11kHz (to fit inside the above bandpass later).

Setup:
![[Pasted image 20240703082710.png]]

There are three states here in the FFT plot:
1) No excitation, minimum magnetic field. This  resulted in a peak at basically only 50kHz
2) No excitation, max magnetic field. Strong peaks at 100 and 200kHz appear in proportion to the strength of the field
3) Exciting with external field. Base 11kHz modulation appears, but there is a much stronger peak at 100kHz +/- 11kHz. This is also in direct proportion to the volts going into the coil, and is also independent of the external magnetic field.
![[Pasted image 20240703081957.png]]

I had initially thought here that the strongest signal would show up at the base excitation freqency:
![[Pasted image 20240703082409.png]]

But from the above FFT it appears that this is not actually the case. 