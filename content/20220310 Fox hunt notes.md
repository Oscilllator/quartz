# Model
Power received by the antenna is proportional to the inverse square of the distance obviously. A little bit of maths later:

![[Pasted image 20220310201423.png]]

And we can see that if you make an observation of power P at a location of [x, y] then it's pretty easy to solve for the location of the transmitter [x0, y0] in a least squares fashion.
# Radio

python is a PITA as usual. Initial power spectrum using python of a radio station found with the cubesdr software:

![[Pasted image 20220310195408.png]]

