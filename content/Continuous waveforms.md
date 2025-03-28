
Since this AWG streams continuously from the PC, it needs to be constantly sending data without much interruption. The acceptable interruption time is the memory capacity of the awg divided by the transmission rate of the waveform generator.

The awg has a FIFO where it receives data. Here I have set the depth of the FIFO to 14 bits, and the FIFO is 8 bits wide, since that's the bus width of the FT232 chip. The waveform generator itself is "16" bits, 14 for the actual AD9744 and 2 bonus digital bits. It transmits at 10MSa/s
So that's `2**14 / (2*10e6) = 0.8192ms`

Here is what a transmission interruption looks like:

## Measured interruptions
```verilog
    assign logic_out[0] = ftdi_rxf_n;
    assign logic_out[1] = ftdi_txe_n;
    assign logic_out[2] = ftdi_rd_n;
    assign logic_out[3] = ftdi_wr_n;
    assign logic_out[4] = ftdi_siwu;
    assign logic_out[5] = ftdi_clk;
    assign logic_out[6] = ftdi_oe_n;
    assign logic_out[7] = ftdi_pwrsav;

    assign logic_out[8] = ftdi_fsm_ready;
    assign logic_out[9] = ftdi_fsm_valid;
    assign logic_out[10] = ftdi_fsm_data;
```

![[Pasted image 20250325212410.png]]

So that all lines up and looks right. with a 13 bit FIFO depth:

![[Pasted image 20250325212758.png]]

Also good. with a 15 bit depth I don't observe dropouts.

## Device utilization

14 bit depth:
```
Info: 	          TRELLIS_IO:      62/    245    25%
Info: 	                DCCA:       2/     56     3%
Info: 	              DP16KD:      10/    108     9%
Info: 	          MULT18X18D:       0/     72     0%
Info: 	              ALU54B:       0/     36     0%
Info: 	             EHXPLLL:       2/      4    50%
Info: 	             EXTREFB:       0/      2     0%
Info: 	                DCUA:       0/      2     0%
Info: 	           PCSCLKDIV:       0/      2     0%
Info: 	             IOLOGIC:       0/    160     0%
Info: 	            SIOLOGIC:       0/     85     0%
Info: 	                 GSR:       0/      1     0%
Info: 	               JTAGG:       0/      1     0%
Info: 	                OSCG:       0/      1     0%
Info: 	               SEDGA:       0/      1     0%
Info: 	                 DTR:       0/      1     0%
Info: 	             USRMCLK:       0/      1     0%
Info: 	             CLKDIVF:       0/      4     0%
Info: 	           ECLKSYNCB:       0/     10     0%
Info: 	             DLLDELD:       0/      8     0%
Info: 	              DDRDLL:       0/      4     0%
Info: 	             DQSBUFM:       0/     10     0%
Info: 	     TRELLIS_ECLKBUF:       0/      8     0%
Info: 	        ECLKBRIDGECS:       0/      2     0%
Info: 	                DCSC:       0/      2     0%
Info: 	          TRELLIS_FF:     473/  43848     1%
Info: 	        TRELLIS_COMB:     821/  43848     1%
Info: 	        TRELLIS_RAMW:       0/   5481     0%
```
15 bit:
```
Info: Device utilisation:
Info: 	          TRELLIS_IO:      62/    245    25%
Info: 	                DCCA:       2/     56     3%
Info: 	              DP16KD:      18/    108    16%
Info: 	          MULT18X18D:       0/     72     0%
Info: 	              ALU54B:       0/     36     0%
Info: 	             EHXPLLL:       2/      4    50%
Info: 	             EXTREFB:       0/      2     0%
Info: 	                DCUA:       0/      2     0%
Info: 	           PCSCLKDIV:       0/      2     0%
Info: 	             IOLOGIC:       0/    160     0%
Info: 	            SIOLOGIC:       0/     85     0%
Info: 	                 GSR:       0/      1     0%
Info: 	               JTAGG:       0/      1     0%
Info: 	                OSCG:       0/      1     0%
Info: 	               SEDGA:       0/      1     0%
Info: 	                 DTR:       0/      1     0%
Info: 	             USRMCLK:       0/      1     0%
Info: 	             CLKDIVF:       0/      4     0%
Info: 	           ECLKSYNCB:       0/     10     0%
Info: 	             DLLDELD:       0/      8     0%
Info: 	              DDRDLL:       0/      4     0%
Info: 	             DQSBUFM:       0/     10     0%
Info: 	     TRELLIS_ECLKBUF:       0/      8     0%
Info: 	        ECLKBRIDGECS:       0/      2     0%
Info: 	                DCSC:       0/      2     0%
Info: 	          TRELLIS_FF:     482/  43848     1%
Info: 	        TRELLIS_COMB:     786/  43848     1%
Info: 	        TRELLIS_RAMW:       0/   5481     0%

```
16 bit:
With a 16 bit depth the timing also fails, I can only hit 90/100MHz:
```
ERROR: Max frequency for clock                 '$glbnet$clk100': 90.20 MHz (FAIL at 100.00 MHz)
```
```
Info: 	          TRELLIS_IO:      62/    245    25%
Info: 	                DCCA:       2/     56     3%
Info: 	              DP16KD:      66/    108    61%
Info: 	          MULT18X18D:       0/     72     0%
Info: 	              ALU54B:       0/     36     0%
Info: 	             EHXPLLL:       2/      4    50%
Info: 	             EXTREFB:       0/      2     0%
Info: 	                DCUA:       0/      2     0%
Info: 	           PCSCLKDIV:       0/      2     0%
Info: 	             IOLOGIC:       0/    160     0%
Info: 	            SIOLOGIC:       0/     85     0%
Info: 	                 GSR:       0/      1     0%
Info: 	               JTAGG:       0/      1     0%
Info: 	                OSCG:       0/      1     0%
Info: 	               SEDGA:       0/      1     0%
Info: 	                 DTR:       0/      1     0%
Info: 	             USRMCLK:       0/      1     0%
Info: 	             CLKDIVF:       0/      4     0%
Info: 	           ECLKSYNCB:       0/     10     0%
Info: 	             DLLDELD:       0/      8     0%
Info: 	              DDRDLL:       0/      4     0%
Info: 	             DQSBUFM:       0/     10     0%
Info: 	     TRELLIS_ECLKBUF:       0/      8     0%
Info: 	        ECLKBRIDGECS:       0/      2     0%
Info: 	                DCSC:       0/      2     0%
Info: 	          TRELLIS_FF:     500/  43848     1%
Info: 	        TRELLIS_COMB:     940/  43848     2%
Info: 	        TRELLIS_RAMW:       0/   5481     0%

```

## Latency
If it takes a significant % of 1 cpu core to calculate the sample wire format, then that's no good at all!

This is where it's currently at:

![[Pasted image 20250325214243.png]]

completely unacceptable. Needs to be >10MSa/s, and should be more like 100e6. However when I ask ChatGPT to translate the python code into C it goes to 100e6 samples/s, so that's nice. I will avoid adding a C library dependency into the python package for the moment, but that's something that can be done in the future.

### Overnight test

Here I ran the scope capture overnight. Found one instance in which the data was interrupted for 3.5ms. Not good!