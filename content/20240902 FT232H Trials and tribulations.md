

# ostensible read pattern:
![[Pasted image 20240902153609.png]]

Taken from [here](https://ftdichip.com/wp-content/uploads/2020/08/AN_130_FT2232H_Used_In_FT245-Synchronous-FIFO-Mode.pdf).

Here is what I observe:

![[Pasted image 20240902153714.png]]

above logic analyzer signals are in the same order as the official ftdi screenshot. Looks like rxf# is going low rather slowly.

..This turned out not to be the issue. the issue was just that I wasn't putting the ft232h into the right sync fifo mode.

## Working, effect of coax loading

Here is the r2r dac working properly finally. I have a ramp, the falling edge of which can be seen here:

![[Pasted image 20240902203647.png]]

This is with 1kR resistors. So to meet the 10MHz spec they would need to be 1/2 of what they are to go from 200ns fall time to 100ns.

