
# Flashing firmware

The guide [here](https://ffbeast.github.io/docs/en/software_firmware_flashing.html) says this is how to enter DFU mode. 
![[Pasted image 20250301195350.png]]


If it is, it doesn't seem to work with this board.  I ordered an ST-link V2 and was able to program the [official firmware](https://github.com/odriverobotics/ODrive/releases) with this command:
```
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program ODriveFirmware_v3.6-24V_0.5.6.elf verify reset exit"
```

# USB control latency

Measuring the control latency with Grok by setting a command velocity and then polling the encoder until the position changes:
> [!Code]-
> 
> ```python
> import odrive
> from odrive.enums import *
> import time
> import numpy as np
> 
> # Connect to ODESC
> odrv0 = odrive.find_any()
> if odrv0 is None:
>     raise Exception("No ODESC found!")
> 
> # Configure for velocity control
> odrv0.axis0.controller.config.control_mode = CONTROL_MODE_VELOCITY_CONTROL
> odrv0.axis0.requested_state = AXIS_STATE_CLOSED_LOOP_CONTROL
> 
> # Encoder setup (16k PPR = 4000 pulses/rev x 4 for quadrature)
> counts_per_rev = 16000  # 16k PPR confirmed
> vel_command = 100.0  # 1 rev/s velocity command
> 
> # Store latency measurements
> latencies = []
> 
> print("Starting 100 trials...")
> for trial in range(100):
>     # 1) Poll position for a bit to establish baseline
>     initial_positions = []
>     for _ in range(100):  # Poll 100 times to ensure stability
>         initial_positions.append(odrv0.axis0.encoder.shadow_count)
>     
>     # Check if motor is stopped (velocity ~0)
>     while True:
>         pos1 = odrv0.axis0.encoder.shadow_count
>         time.sleep(0.001)  # Minimal delay to measure velocity
>         pos2 = odrv0.axis0.encoder.shadow_count
>         vel = (pos2 - pos1) * 1000 / counts_per_rev  # rev/s
>         if abs(vel) < 0.01:  # Stopped if < 0.01 rev/s
>             break
>     
>     initial_pos = odrv0.axis0.encoder.shadow_count
>     
>     # 2) Set velocity command and record start time
>     start_time = time.time()
>     odrv0.axis0.controller.input_vel = vel_command
>     
>     # 3) Poll position until it changes
>     while True:
>         current_pos = odrv0.axis0.encoder.shadow_count
>         if abs(current_pos - initial_pos) > 10:  # Moved >10 counts (~0.002 rev)
>             break_time = time.time()
>             break
>     
>     # Record latency
>     latency = (break_time - start_time) * 1000  # Convert to ms
>     latencies.append(latency)
>     
>     # 4) Stop the motor
>     odrv0.axis0.controller.input_vel = 0
>     # Wait until stopped
>     while True:
>         pos1 = odrv0.axis0.encoder.shadow_count
>         time.sleep(0.001)  # Minimal delay for velocity calc
>         pos2 = odrv0.axis0.encoder.shadow_count
>         vel = (pos2 - pos1) * 1000 / counts_per_rev  # rev/s
>         if abs(vel) < 0.01:  # Stopped if < 0.01 rev/s
>             break
> 
> # 5) Calculate mean and stddev
> mean_latency = np.mean(latencies)
> stddev_latency = np.std(latencies)
> 
> # Stop motor and cleanup
> odrv0.axis0.requested_state = AXIS_STATE_IDLE
> 
> print(f"Completed 100 trials")
> print(f"Mean latency from command to motion: {mean_latency:.2f} ms")
> print(f"Standard deviation: {stddev_latency:.2f} ms")
> 
> # matplotlib histogram of latencies:
> import matplotlib.pyplot as plt
> 
> plt.hist(latencies, bins=20)
> plt.title("Latency Histogram")
> plt.xlabel("Latency (ms)")
> plt.ylabel("Frequency")
> plt.show()
> ```

I get this:

![[Pasted image 20250308145753.png]]

Not bad. I don't think a USB connection could really get much faster.