# Background: underlay+overlay
A common process in biology is something called an "underlay" (or its cousin the overlay). This is  a process of separating cells from other gunk by density. This is done like so:
![[Pasted image 20230129181721.png]]
Say the  cells are density x and the surrounding garbage   is all significantly higher or lower density. by having  two fluids sitting on top of each other and then centrifuging hard for a long time, the cells will float to the _middle_ of the tube, where they can be collected. 
Setting this up is a tedious, time consuming and manual process  that is prone to error. For an underlay, you first fill the tube halfway with fluid density $x - \Delta$,  gently insert a pipette  to the bottom of the  tube, and sloooowly inject the fluid of density $x+\Delta$. You do the reverse with an overlay, which a lot of people prefer. $\Delta$ is very small. Idk how small, but small.
This seems to  me to be a process that could be automated fairly easily. Some nice flow control  on a pump and a barometer to sense fluid levels should be all that's required I would think.

# Valves and such
I have acquired a resin printer (elegoo mars) and so am now  capable of printing airtight structures  with tubes and such going through them. This should be perfect for the job. The first thing I did was print up a very simple manifold that directed the air around so I could either pump air in or  out of a pipette. That looked like  this:
![[Pasted image 20230129182329.png]]
Which had the following circuit diagram:
![[Pasted image 20230129182532.png]]
Where green are  hoses and purple is the thing that I printed. That worked well, but had loads of hoses going all over  the place. What I really want is a single block of printed stuff that I attach moving bits to that then does the  job flawlessly. 
The first step in achieving this goal is to make some  printable valves. Here is  what I came up with:
![[Pasted image 20230129183002.png]]
The air wants to flow from left to right from the red to the orange channel. But it can't because the rubber sheet (light blue) is being pressed down over the junction by a  solenoid (dark blue).
In CAD it looks like this:
 Top view | Side view
:-----------------------:|:--------------------------:
![[Pasted image 20230129183223.png\|200]]  |  ![[Pasted image 20230129183710.png\|200]]
![[Pasted image 20230129183836.png|400]]

![[Pasted image 20230129183856.png]]
And it works!
https://photos.app.goo.gl/qWQjEG1SU8D5AsPk7
