# System setup
Arduino TTGO lora oled jobbie attached to a tf mini plus and a pcm5201a audio i2s thingo.

# Images

![[Pasted image 20220926193645.png]]


![[Pasted image 20220926193659.png]]


## Jitter fixes
I discovered that writing to the I2C OLED display took about 25ms and made the CDF of my processing time graph look atrocious:

![[Pasted image 20220926194317.png]]

Something simply must be done.

### New thread
But after moving the display write to another thread my processing time looked like this:

![[Pasted image 20220926194049.png]]

Exquisite.
I think I can even hear a difference in the sound too. If I were an audiophile I'd describe it as more of a liquid burble when sweeping around. Good job I'm not.

## Frequency to distance
The blindar measures distance. That's the easy bit. The hard bit is passing that information to the user in an intuitive way.
The most naive wait to do it is a straightforward frequency mapping: higher distance, higher frequency.  This is good enough for someone to not bump into things like walls but is entirely inadequate for a number of reasons:
- The user doesn't really know a priori what this mapping is. "The pitch is quite low right now, but is the wall 30cm away or 1m away?". The answer to that is both important and not apparent. It gets better with use, but not that much.
- Small shifts  in distance are imperceptible. A 10cm jump in distance 2m away is  inaudible as a frequency shift (it might correspond to something like a 200->220Hz shift). But this distance jump is very important! That's the road kerb we're talking about here! You can't miss that!
I have addressed the latter issue by attempting to measure small jumps in frequency and then apply in _distortion_ to the sound wave (going from sin wave to square wave). Here's an example distance sweep back and forth over a smooth area and then over some cables I put on the  ground:

![[Pasted image 20221006214254.png]]

Zooming in to the cables:

![[Pasted image 20221006214324.png]]

This is in essence just a highpass filter, detecting fast changes in distance. If you sweep the lidar in front of your like a blind person with a stick as I have done in the above image then it works quite well. 
If you wave the lidar around willy nilly it works appallingly. Small changes in the pitch axis of course produce large changes in distance and so the user can't really flick it up and down.
### More information
I think that adding an imu and doing some basic short term pose tracking could work quite well here. That should easily be able to distinguish between a large change in distance due to pitching up the lidar vs actually hitting an object. Data must be collected...







