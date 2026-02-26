The boards have arrived:

![[Pasted image 20260222082625.png]]
# It's covered in lead

![[Pasted image 20260221215819.png]]

The default surface finish option when ordering from JLCPCB is HASL _with lead_. I did so many dry runs through the ordering process that I forgot to pick ENIG. Now all the lovely pads that people are supposed to hold onto are coated with lead. I aim to address this by conformal coating the text, and 3D printing coverslips to go over the finger pads:

![[Pasted image 20260221220624.png]]

Since I don't trust the conformal coating not to scratch off under constant rubbing.

### Actual functionality

Seems fine as far as I can tell. Have not programmed all the PCB's yet, but the few that I have operate fine. I got claude to add a self check program to see that data was coming in from the imu, compass and gps as well as that a valid i2c transaction could be issued to the screen. All boards have worked so far.

## Personalised names

I've laser etched the name of each of the attendees on all the PCB's. Here is a zoomed in photo of one of the letters:

![[Pasted image 20260222172529.png]]

Pretty good!

## Conformal coating application

Here is the mask I used to only apply the coating to the writing:

![[Pasted image 20260222173042.png]]

I thought about selectively masking out the switches, USB port, screen, and battery holder selectively so that the whole board could be coated but it seemed like less effort to just selectively coat the center text instead.

The conformal coating needs to be cured for a while so to get it done faster I built a small hair dryer powered incubator in which all the PCB's could be stacked at once and held for 50C for a few hours to cure them:

![[Pasted image 20260222172724.png]]

Here are the stacked racks, which together with the floor of the cardboard box was just able to accomodate the 40 PCB's.

![[Pasted image 20260222172740.png]]

Here is the box in operation:

![[Pasted image 20260222173324.png]]

Nice and toasty.


