I just bought a new computer with a big AMD CPU, but the motherboard only outputs VGA and I have no VGA cables anymore. 


I do have an oscilloscope though.

So I can simply read the data out of the scope, like so:

![[Pasted image 20231203183837.png]]

This is what the vsync and hsync lines look like zoomed in:

![[Pasted image 20231203184259.png]]

and what two scan lines of data look like:

![[Pasted image 20231203184343.png]]

The full code to extract the frame:

```python
import siglent_funcs as sf


def load_and_display():
    directory_path = '/home/asdf/Downloads/'
    bin_files = glob.glob(os.path.join(directory_path, '*.bin'))
    fn = max(bin_files, key=os.path.getmtime)
    print(f"loading {fn}")

    with open(fn, 'rb') as f:
        dt, volts = sf.extract_data(f)

    vsync, hsync, _, color = volts

    vsync_pulse = vsync - np.mean(vsync)
    vsync_pulse = np.diff(vsync_pulse, append=[vsync_pulse[-1]])

    frame_boundaries, _ = signal.find_peaks(vsync_pulse, height=0.02)
    assert(frame_boundaries.size == 2)
    
    volts = volts[:, frame_boundaries[0]:frame_boundaries[1]]
    vsync, hsync, _, color = volts

    hsync_pulse = hsync - np.mean(hsync)
    hsync_pulse = np.diff(hsync_pulse, append=[hsync_pulse[-1]])
    hline_boundaries, _ = signal.find_peaks(hsync_pulse, height=0.035)

    manual_sz = int(np.median(np.diff(hline_boundaries)))
    new_sz = volts.shape[1] - volts.shape[1] % manual_sz
    volts = volts[:, 0:new_sz]

    vsync, hsync, _, color = volts
    image = color.reshape((-1, manual_sz))

    plt.figure(figsize=(40, 40))
    plt.imshow(image, interpolation='none', aspect='auto')
    plt.show()

```

And the results:

![[Pasted image 20231203184647.png]]

Ta-da!

...It takes like 30sec to get a new image, but much better than nothing. I was able to get video over to the graphics card with it, at least.

It's also interesting navigating the bios. Lots of the menu items are arranged vertically which then translates to later in time looking at it live on the scope. So to some extent you can know what you are choosing.