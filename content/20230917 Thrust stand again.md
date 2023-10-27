# New current measurement
[[20230325 Thrust stand|Previously]] I constructed a thrust stand, however the measurements that it spat out were highly suspect and noisy.
I have a hantek power supply that has a serial port and I thought I would use it to get current measurements so as to get better data. The serial port interface is incredibly bad, it drops packets all the time, is slow to update etc. But it does eventually settle on a correct measurement. And I can use an arduino to send out the pwm signal to the ESC.

# Propellers
These are the propellers that I had on hand:
![[Pasted image 20230917164110.png]]
Some of them are from master airscrew, the bottom one is from some aliexpress site and the others I printed with a piece of parametric propeller design software I found on thingiverse.
# Motors
I only had two motors to be tested:
- [SunnySky X2204 1480kv](https://sunnyskyusa.com/products/sunnysky-x2204-brushless-motors)
- [SunnySky X Series V3 X2302](https://sunnyskyusa.com/products/sunnysky-x2302)
Here is the thrust test stand data for both of them:
![[Pasted image 20230917164656.png]]
Now they seem to be measuring more or less correct. Here is the manufacturer data for the 2204 with an 8040 prop again:
![[Pasted image 20230917164820.png]]
The data for the 2302 doesn't look correct though. The manufacturer has it at 13.2g/w with 100g thrust, 8043 prop:
![[Pasted image 20230917165114.png]]
weird.

# Even moar propellers

I printed up a nice big batch of propellers:

![[Pasted image 20230924201733.png]]

That I generated using an iterated version of the script that I think originated [here](https://www.techmonkeybusiness.com/articles/Parametric_Propellers.html). 

None of them seem any good though. In the below plot the above propellers are marked with an 'x' (I didn't measure them all) and the ones from the above dataset have an 'o':

![[Pasted image 20230924202242.png]]

The format of the printed propellers is 'print\_{diameter in inches}\_{pitch in inches}\_{chord in mm}'

Dismal. Just dismal. I had high hopes in particular for the last printed one which was D10 p2. I spent a little bit of extra time adjusting  chord as a function of radius function, as well as increasing the thickness a tad because the other propellers seemed a bit thin and flappy. 

![[Pasted image 20230924202504.png]]
![[Pasted image 20230924202517.png]]

I guess the lift/drag ratio probably just came out terrible.

## Efficiency
As I understand it drone propellers operate at low reynolds numbers, mostly because they are tiny compared to e.g. aeroplane wings. I thought that perhaps given that I was 3d printing these I would be able to produce a large hollow prop that was both lightweight (since it's hollow), large diameter and stiff. I think I did do that, it just turns out such a propeller isn't any good. 
ChatGPT tells me that as the reynolds number decreases, the relative penalty for thickening a propeller actually increases. So a thick airfoil designed for high reynolds numbers is worse than a thick one designed for low reynolds numbers. That's the opposite to what I would have thought, but it does seem to be true.

### Another off the shelf 8040 propeller

![[Pasted image 20231016080548.png]]