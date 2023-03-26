I need a light to wake me up since daylight savings mean the sun isn't doing a good job. I've been getting some great mileage out of my LED driving circuit. Here it is again:

![[Pasted image 20230319112415.png]]

Only thing of note here is that I changed R3/R7 to 100R for smaller minimum pulse widths, as it's important that the LED has a really low minimum brightness.
I also made one using a FET driver but it didn't arrive on time:

![[Pasted image 20230319112523.png]]

And of course the circuit is reverse polarity protected:

![[Pasted image 20230319112547.png]]

I also have a [Yuuuge LED](https://store.yujiintl.com/products/cri-max-cri-95-150w-high-bay-ufo-led-light-4000k-5000k) that takes a 0-10V analog input to control it. The minimum brightness is too high for a wakeup light but I would still like to be able to control it from the pi, so this circuit is in order:
![[Pasted image 20230319113615.png]]

..OK maybe I shouldn't popular R13 like that.But the circuit works well. 