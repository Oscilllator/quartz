The goal here is to precisely control the temperature of a water bath, for recrystallizing copper sulfate crystals. I have a esp32, a hotplate stirrer and a temp sensor off amazon.

## Hotplate stirrer mod
Here I have just wired the relay in line with the heating element:

![[Pasted image 20250921172814.png]]


## Time constant of bare hotplate

Here I taped the thermocouple to the hotplate underneath some paper towel for insulation, and turned the temperature on for a few seconds. The drift upwards is the thermal time constant for diffusion of heat from the element to the thermocouple:

![[Pasted image 20250921171232.png]]

## Working (bang bang)

here we have things set up so that the ESP receives a UDP packet that sets the temperature. Then the algorithm is just `heater_state = temp < target_temp`, so you get something like this:

![[Pasted image 20250921174908.png]]

Where the relay turns off once the target temp is reached. There is massive overshoot here, but there also isn't much thermal inertia in the system yet because this is a bare hotplate, not a beaker full of liquid.

## Beaker full of water.
Here is the result of a bang bang controller with the thermometer located outside the beaker hot glued to it with some paper towel as insulation:

![[Pasted image 20250921182035.png]]

I think the primary cause for this 5C+ overshoot is the lag between the liquid inside and the thermometer - i.e. it would be much much faster if I could immerse the thermometer. 

### Couple of oscillation cycles
Apparently it's not so easy to have a thermometer immersed in a copper sulfate solution - it will corrode stainless steel and most metals. So it would be good to be able to figure out a solution where the thermometer could stay on the outside.

![[Pasted image 20250921201616.png]]