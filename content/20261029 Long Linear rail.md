

# Cogging

The cogging with this linear rail is extremely severe. the motor jerks is extremely jerky in a start-stop fashion at low speeds, it practically comes to a stop then leaps forward again. It is however being run with an odrive, which is of course open source. So I asked claude to build a table of motor currents as a function of position so that it could invert this cogging in the driven motor currents to get a smooth velocity, which resulted in this:

<object type="image/svg+xml" data="/static/plots/odesc-cogging-sweep.svg" style="display:block;width:100%;height:auto;aspect-ratio:1000 / 560"><img src="/static/plots/odesc-cogging-sweep.svg"></object>

Here is a video showing the incredibly jerky motion:

![[PXL_20261029_044217965.LS.mp4]]

## Jerkiness compensation

Now the motor has a quite excellent encoder on it. So it should be possible to build a lookup table where you have an fft of the motor position and measure all the different components from the cogging, slots, pulley teeth, pulley eccentricity etc. Then iteratively measure -> compensate->measure again, until the error is quite small.

I asked Mr claude to perform this compensation:
### Results

![[PXL_20261030_035844175.LS.mp4]]

Here is an FFT showing the amount of reduction:

![[Pasted image 20261101082944.png]]

Or, as a time series:

![[judder_time_0-3.4s.png]]

### SNR of audio amp
top: 2Mhz adc of the teensy. Bottom: 48kHz audio ADC. the latter has about 20x higher snr apparently, but also quite a bit lower sampling rate. Looks like the rise time is still pretty good though.

![[Pasted image 20261101214504.png]]

### New temp cal

The new PCB has a modulation voltage of 10V. This actually heats up the sensor quite a lot, so this time I requested that the temp cal app only operate the sensor at a 1% duty cycle, which is just fine for measuring the temperature. Here is the data used for calibration, it only takes a few points as the sensor is very linear:

![[used.png]]

In fact, according to this calibration, when operated with no water in the cooling channels the pressure sensor sits at 72.5C, which it reaches within ~10s of being plugged in.