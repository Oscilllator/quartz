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

