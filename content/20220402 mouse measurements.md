# Problem
Currently experiments have no good way of measuring mouse health over time so they use weight as a heuristic. Mice are manually measured every day. This is clearly dumb and a bit of maths + some scales should be able to overcome this.

# Idea
Mice live in a small plastic cage. Suspend the cage via three force transducers and monitor those constantly. With one mouse it's trivial to measure the weight over the time. Measuring the weight of 3+ mice over time is an underdermined problem, but is most likely possible if you attempt to estimate the positions of the mice as well and have some model of the mices movement (they are unlikely to teleport).

![[Pasted image 20220402090659.png]]

This would still run into problems of unique identification of mice since two mice could weigh the same as each other and then climb on top of each other at some point.
RFID tags is the obvious way to solve this problem, but there could be others that I haven't thought of yet, like an incredibly precise scale that is able to measure the weight of a mice to such a level that they never have the same weight.
One other thing that will need consideration is that the measurement of the weight is going to be _very_ noisy - if you have like 100Hz bandwidth then stuff like footsteps, standing up etc will be tricky to deal with I think.

# Maths
## One mouse, one dimension:
Step 0: one mouse in 1D with two transducers:

![[Pasted image 20220402091407.png]]

I've put the origin in the middle here cause we are about to take the sum of the moments and idk what to do about that when the distance is 0 there.
Eqn 1: $$F_1 + F_2 = m$$
$$ \sum Moments = 0$$
Which leads to:
$$ F_2 \frac{L}{2} - F_2\frac{L}{2} - xm = 0$$
Blah blah blah I'm sure you can reduce this to an exact solution. Two equations and two unknowns and all that.
## One mouse, two dimensions
Here is the sich from the top down:

![[Pasted image 20220402092007.png]]

So as before, we have:
$$F_0 + F_1 + F_2 = M_0$$
(duh). But now the moments get a bit more tricky. Let's do some vector notation so $\vec{F} = [F_0, F_1, F_2]$ etc.
The same moment thing applies, but now in both the x and y directions:
$$ \vec{M}_F \cdot \vec{M}_x = \vec{F}_F \cdot \vec{F}_x$$
$$ \vec{M}_F \cdot \vec{M}_y = \vec{F}_F \cdot \vec{F}_y$$
Where it's important to remember that the mouse vector $\vec{M}$ and the measurement vector $\vec{F}$ are two different lengths, with the mouse vector probably being longer.
$\vec{F}_F$ is what we measure over time, $\vec{F}_{xy}$ is the known position of the force transducers, and $\vec{M}_{Fxy}$ is what we are trying to estimate.
Now the measurements are going to be made multiple times per second and I think that a reasonable extra constraint to add when solving is to minimise the difference in position of the mice measured at time $t$ and $t + 1$ . 
Surely there is some off the shelf optimisation package (is this a 'convex optimisation' problem?) that can help with this but it might be easier to just diy it iteratively. Two weeks of experiments measured at 80Hz is $2*7*24*60*60*80 = 100e6$ measurements. Probably a bunch of filtering can reduce that by 10x but it isn't really that many numbers so if it can be done in a couple of lines of numpy instead it probably should be.
