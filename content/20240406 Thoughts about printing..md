What we really need is a printer that can deposit just about anything that can survive high temperatures. If we had a printer that could put downs copper, steel, and some kind of insulator then you would be able to print an entire robot straight up.

One approach to printing that I have not heard about is getting a drop or particle of material, applying a charge to it, then flinging it down with electric fields to put it in the right spot to build up an object. Like a laser printer but 3D. I went and asked ChatGPT a bunch of things and it isn't immediately obvious that it wouldn't work. 

Some things that seem important: 
- The charge a sphere gets at a given voltage is proportional to its diameter. So the acceleration it would feel is inversely proportional to its diameter then obviously. We want high accelerations here for high material deposition rates I think.
- This makes me think that maybe we want to use laser ablation to gassify the material. Then you'd really be able to accelerate it. But the latent heat of vaporisation of copper seems high (5kJ/g, and we want at least 1g/s right?) as opposed to just melting it.
- Ablating a material would then give you a velocity _distribution_ as opposed to a well controlled velocity from single well defined droplets. "Laser ablation and its applications" on the section on space propulsion says that you would get a "Maxwell-Boltzmann velocity distribution":
![[Pasted image 20240406060813.png]]
I have no idea how narrow that is in practice. It would seem though like what you would end up here is something like an electron microscope set of optics. Electron microscopes have the advantage though that they can just throw away the electrons that they don't want. If a printer did that the entire inside would fill up with trash pretty quick. So a printer would have to accept a) the whole cone angle of ablated material and b) the whole velocity distribution of electrons. 

a) seems like by far the hardest. It would seem to correspond to ab absurd numerical aperture and almost on that basis alone I want to discard the ablation idea. So it seems like investigating controlled melting of droplets is what is really desired if practical.

