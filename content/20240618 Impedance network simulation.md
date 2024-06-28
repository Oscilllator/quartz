# Background


The goal here was to build some kind of metal detector that could operate at a wide range of frequencies. Previous work [[20240529 Metal detection|here]]. It seems rather impractical/impossible(?) to make a coil that actually resonates across a decade+ frequency range of like 1-10kHz, ideally 100kHz. We want such a large frequency range becaue iron ore and so on has a quite different response vs frequency to gold, and so doing a full frequency sweep should provide a bunch of information.
### Why resonate?
It's obviously possible to put a whole bunch of energy in a tx coil across many frequencies via some kind of class-D amplifier setup. And you could open-circuit the rx coil and measure the voltage across it too, if you wanted. But I don't think that that would be a good way to operate the device. Operating the coil with a capacitor in parallel as a tank circuit at the tx coil frequency is univerally how metal detectors are designed, and with good reason I think. It is not so much that the tank circuit provides _gain_ by resonating, but that it presents as a different impedance. It actually absorbs more of the energy in the oscillating magnetic field. So it's not equivalent at all to sticking a super low noise amplifier on the output of the coil.

### Briefly: Why not operate at different frequencies sequentially?
You could trivially design a setup that used a switched capacitor network or tapped off the inductor to operate at different frequencies sequentially. I find this to be against the ideals of the project and refuse on that basis. When I think about what a good metal detector should be doing it is blasting the environment with as much wideband energy as it possibly can on the tx side, and using a 

# Example filters:
```python
# 9-11khz bandpass filter from lc filter design tool.
def setup_bandpass():
    grid = torch.zeros(2, 3, 3)
    grid[C, 0, 0] = 298.7e-9
    grid[L, 0, 0] = 856.4e-3
    grid[C, 0, 1] = 308e-6
    grid[L, 1, 2] = 830.7e-6
    grid[C, 2, 2] = 298.7e-6
    grid[L, 2, 2] = 856.4e-3
    # current enters port 0 and exits port 1
    I = torch.tensor([1.0, 0.0, -1.0])
```
![[Pasted image 20240618235739.png]]

![[Pasted image 20240623161130.png]]

bandpass again:

![[Pasted image 20240625213530.png]]
### Bandstop


![[Pasted image 20240623161022.png]]

![[Pasted image 20240623173640.png]]

(1-indexed in screenshot, 0-indexed in simulation.)



## Overnight run

I did an overnight run of the highpass filter:

Which gave me this histogram of errors:

![[Pasted image 20240628075349.png]]

It looks like there are a couple here that converged to the right answer! The mininim error here was 1.0002.

## Comparison Table
(Thank you chatgpt for the formatting)

| Best Convergence |          |          | Ground Truth |          |          |
|------------------|----------|----------|--------------|----------|----------|
| 4.95e+01         | 0.00e+00 | 0.00e+00 | 5.00e+01     | 0.00e+00 | 0.00e+00 |
| 0.00e+00         | 0.00e+00 | 0.00e+00 | 0.00e+00     | 0.00e+00 | 0.00e+00 |
| 0.00e+00         | 0.00e+00 | 5.01e+01 | 0.00e+00     | 0.00e+00 | 5.00e+01 |
| 7.23e-04         | 0.00e+00 | 0.00e+00 | 6.94e-04     | 0.00e+00 | 0.00e+00 |
| 0.00e+00         | 4.11e-04 | 0.00e+00 | 0.00e+00     | 4.03e-04 | 0.00e+00 |
| 0.00e+00         | 0.00e+00 | 7.20e-04 | 0.00e+00     | 0.00e+00 | 6.94e-04 |
| 0.00e+00         | 2.20e-07 | 0.00e+00 | 0.00e+00     | 2.32e-07 | 0.00e+00 |
| 0.00e+00         | 0.00e+00 | 2.31e-07 | 0.00e+00     | 0.00e+00 | 2.32e-07 |
| 0.00e+00         | 0.00e+00 | 0.00e+00 | 0.00e+00     | 0.00e+00 | 0.00e+00 |
