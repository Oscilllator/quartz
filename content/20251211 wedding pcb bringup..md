# \[top] checklist for next time
- pulldown for flash voltage
- pwm on gps lock pin for brightness
- Right thickness coin cell holder
- wire up gps backup pin FET
- pulldown on gps FET input?
- Move USB connector so it isn't right next to screen?
# Schematic

![[Pasted image 20251211200746.png]]
# The PCB

![[Pasted image 20251211200618.png]]

# Bringup
I pasted images of the schematics into Gemini 3 and asked it to come up with a bringup arduino sketch. It got a couple of the pin numbers wrong, but so far I have turned on the debug LED, flashed all the LED's in the LED matrix, and the I2C scanner alleges to have found some thing at 0x3C. Nice.
### GPS backup pin
I put this circuit in to be able to see if the backup pin was in:
![[Pasted image 20251213211638.png]]

Missed actually wiring this to the esp32. should have put a very weak pulldown on vbat, too.
### Flash pin
When I pasted the schematics in for a design review, gemini also pointed out that GPIO 12 was read on bootup to set the voltage of the internal flash, and so I could not use it to drive the LED matrix. Nice catch. I don't know if I read the subsequent recommendation properly, but anyway I put a pullup on IO 12 when I should have put a pulldown instead. oh well.

![[Pasted image 20251211201029.png]]

## I2C display and GPS
Boom.
![[Pasted image 20251211213508.png]]

Both work out of the box. Nice

# Compass
This is where the troubles start. You would expect nothing less from a compass. The default arduino library for the compass (MMC5603NJ) I am using does not actually measure the magnetic field very well, because the default measurement includes all the internal compass offsets. These offsets are huge and make the sensor useless out of the box. Instead to get a real measurement the datasheet says you have to do this to get a "bias-free" measurement:

```c++
bool Adafruit_MMC5603::getEventNoOffset(sensors_event_t *event)
{
  // 1) SET
  _ctrl0_reg->write(0b1000);
  delay(1); // REQUIRED: t_SR = 1ms per datasheet

  // 2) measure
  sensors_event_t event1;
  if (!getEvent(&event1)) return false;

  // 3) RESET
  _ctrl0_reg->write(0b1'0000);
  delay(1); // REQUIRED: t_SR = 1ms per datasheet

  // 4) measure
  sensors_event_t event2;
  if (!getEvent(&event2)) return false;

  // 5) result is (e1 - e2) / 2
  *event = event1;
  event->magnetic.x = (event1.magnetic.x - event2.magnetic.x) / 2.0;
  event->magnetic.y = (event1.magnetic.y - event2.magnetic.y) / 2.0;
  event->magnetic.z = (event1.magnetic.z - event2.magnetic.z) / 2.0;

  return true;
}
```

Which seems like a pain. I put in a pull request [here](https://github.com/adafruit/Adafruit_MMC56x3/pull/5) to add the method, we shall see if it is accepted.

Even with these biases removed, the results are not great. There is still up to a 40 degree heading error. I'm sure it could be removed via further calibration but that is not a rabbit hole I wish to go down.

# LED brightness and ambient light
The LED's are bright. Too bright.

![[Pasted image 20251213193841.png]]

So I asked mr gemini if there were any parts in jlcpcb's standard parts catalog that could be use to detect ambient light, and it suggest the ol 'led as a photodiode' trick. It had a good method too which I would not have thought to use: reverse bias the photodiode then switch your digital pin to input. This charges the LED capacitance and so the discharge time is dependent on the photocurrent from the LED. Brilliant, [Dan Gelbart would approve](https://youtu.be/W6q_JRZCaZM?list=PLlkx3gSXbdKAl4oUtflEJE_vSX-hYZHrn&t=4532).

Anyway I hooked it up and it works great, it takes 6000us in close to complete darkness and 2us with a phone torch pushed up against the LED.