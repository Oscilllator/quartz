
Using OpenFOAM and the literature gathered from [[20260729 Pulse jet|here]] Mr Claude furnished me with this simulation of a small pulse jet:

![[2026-08-07 19-30-14.mp4]]

Net thrust 0.09N, lovely.

# Thrust on a plate

Since the net force on the pulse jet body at 0 speed is quite small as a result of the pulse jet inlet facing in opposition to the outlet, we can do in the simulation what was done in the real lockwood paper, which is place two plates at either end of the pulse jet and measure the forces on those plates. Perhaps this could be done non-physically in the simulation but let's do it 'for real' here with a real plate.

### Puff hitting a plate
An interesting observation: In the sim we can see that the force on the inlet plate spikes super high and then shortly afterwards _goes negative_, kind of like it's "AC coupled":

![[Pasted image 20261011173929.png]]


Velocity showing the puff of air about to exit the inlet:

![[Pasted image 20261011173733.png]]

Colored by pressure:

![[Pasted image 20261011173834.png]]

Here it is when there is peak force on the plate pushing the plate away from the pulse jet:

![[Pasted image 20261011174153.png]]

And here it is when the force is swung in the other direction and is on net pulling the plate directly _towards_ the pulse jet:

![[Pasted image 20261011174322.png]]

These curling pressure pulses look real but not really related to how a pulse jet would work in normal operation, where the jets of gas don't hit a plate. I don't really understand how this method of measuring thrust used by the lockwood paper is valid.

# Optimisation of current pulse jet, HH-M2

This is claudes best guess of what the simulation should look like with the pulse jet that I've actually built, and which is called HH-M2 in the lockwood papers.

![[pulsejet_hhm2hard_start_long_p_43-53ms.webp]]

This is the temperature layer:

![[pulsejet_hhm2hard_start_long_T_30-40ms.webp]]

The CO2 layer actually also looks pretty good, but something here is a bit off, the CO2 seems to diffuse away into nothing in the exhaust. I feel like that wouldn't actually happen: 

![[pulsejet_hhm2hard_start_long_CO2_20-29ms.webp]]

Actually, why am I pasting gifs? claude, paste the whole app [here](https://harrydb.com/static/pulsejet-hhm2-optimisation.html).
