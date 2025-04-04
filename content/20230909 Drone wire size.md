# What size should your drone wires be?
$$\sqrt[4]{\frac{i^2 \cdot \rho}{\pi^2 \cdot e \cdot d}}
$$
- i: Current(A)
- $\rho$: conductivity ($\Omega \cdot m$ ): Probably copper, 1.77e-8
- r: radius of wire (m)
- e: Efficiency of your drone motor+prop combo (watts/kg). A high efficiency drone might be 100w/kg
- d: Density of conductor (kg/m3): Probably copper, 8960.

That's it. Any lighter and the motors would be dissipating excess power. Any heavier and the wires will weigh you down. Notice that huge fourth root there - the wire size goes up very slowly!
Don't forget that the current experienced by a given phase of a motor is battery amps / num motors * 2/3. My optimum wire radius is 0.23mm. When I backcalculate the power dissipated at that diameter with the wire length of my drone I get 200mW which sounds plausible.

Here is the working out for this formula:
![[Pasted image 20230909135401.png]]

I suppose you could make this analysis more complicated since the efficiency changes with thrust etc. This seems good enough to pick a gauge though.

## It's 2023
![[Pasted image 20230909140801.png]]
...goddammit.
