As far as I can tell, there exists no waveform generator that is easy to use. By easy to use, I mean you have to be able to get a waveform from a completely fresh computer in the following three steps:

1) plug it in to computer and oscilloscope
2) pip install my_scope_lib
3) `my_scope.send(np.sin(np.linspace(0, 2 * np.pi, 1000)))`

That's it. That's all I should have to do. Yet every one requires some SCPI nonsense or has a weirdo interface or whatever. Like just send my data, it's really not that hard.

# Architecture.

Here would be a really simple way to do it:

![[Pasted image 20240902204646.png]]

And here it is, on my bench:

![[Pasted image 20240902205214.png]]

Using the rather excellent colorlight fpga module. Loads of credit to [Tom's blog post](https://tomverbeure.github.io/2021/01/22/The-Colorlight-i5-as-FPGA-development-board.html) for documentation on this. I originally got this setup working with an ice40 from an [Upduino](https://tinyvision.ai/products/upduino-v3-1?srsltid=AfmBOorqgBwYec1BzLKdIRsDrCUKg5r-K7ZpOxGygR_LyuM8FPXdiTnD) board (with an extra FT232H), but the ice40 only wanted to synthesise up to about 40MHz and the FTDI clock is at 60MHz.

I also found [this](https://github.com/WangXuan95/FPGA-ftdi245fifo) github repository which made getting the FT232H working much easier than it otherwise would have been. 

# Output waveform

This is what a linear ramp looks like coming from the PC. Note that the resistors that I used were rando 1% value ones:
![[Pasted image 20240902205715.png]]

Quite a bit of nonlinearity there but very good for a first try!



