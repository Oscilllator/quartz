
Trying to build a plasma toroid following this guide:

https://docs.google.com/document/d/1AyaO-RaTiaOmyT3-89UxPdrMHEBCCrxb1irZKsVMg_8/edit
https://docs.google.com/document/d/1-jMPQOSs6-Flp181TTa8cNMSs2XumzDEahg9DVD0hKk/edit

Here is the circuit in LT spice:

![[Pasted image 20240208194901.png]]

My transistor is a CS9N90 (lcsc special):

![[Pasted image 20240208195012.png]]

My capacitors are only rated to 50V, and so I get a squealing noise, but the circuit does oscillate:

![[Pasted image 20240208195058.png]]

I wonder why it only oscillates for a while... possibly it is the high voltage on the caps (150V!) that causes them to be lower in capacitance and stop the oscillation.
