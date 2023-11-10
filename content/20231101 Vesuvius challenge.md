I am faffing about with the vesuvius challenge. At the moment this has been limited to getting chatGPT to generate me my very first autoencoder, which is a simple 3d convolutional model:

```python
class Autoencoder(nn.Module):
    def __init__(self, cube_size: int):
        super(Autoencoder, self).__init__()
        self.cube_size = cube_size

        # Encoder
        layers = 3
        expansion_init = 32
        self.encs = nn.ModuleList()
        self.encs.append(nn.Conv3d(1, expansion_init, kernel_size=3, stride=1, padding=1))
        for i in range(layers):
           self.encs.append(nn.Conv3d(expansion_init * 2**i, expansion_init * 2**(i+1), kernel_size=3, stride=1, padding=1))
        final_expansion = expansion_init * 2**layers
        
        self.pool = nn.MaxPool3d(2, stride=2)
        
        self.final_side_len = cube_size // 2**(layers + 1)
        assert(self.final_side_len > 0)
        self.final_channels = cube_size * 2**layers
        self.final_paramcount = cube_size**3 // (2**(layers+1))
        print(f"Final dimensionality before latent space will be {self.final_channels, self.final_side_len, self.final_side_len, self.final_side_len}")
        latent_size = 512
        # Latent vectors mu and logvar
        self.fc1 = nn.Linear(self.final_paramcount, latent_size)
        self.fc2 = nn.Linear(self.final_paramcount, latent_size)

        # Decoder
        self.dec1 = nn.Linear(latent_size, self.final_paramcount)
        self.decs  = nn.ModuleList()
        for i in range(layers):
           self.decs.append(nn.ConvTranspose3d(final_expansion // 2**i, final_expansion // 2**(i+1), kernel_size=2, stride=2))
        self.decs.append(nn.ConvTranspose3d(final_expansion // 2**layers, 1, kernel_size=2, stride=2))

    def reparameterize(self, mu, logvar):
        std = logvar.mul(0.5).exp_()
        eps = torch.randn(*mu.size())
        return mu + std * eps

    def encode(self, x):
        for enc in self.encs:
            x = F.relu(enc(x))
            x = self.pool(x)
        x = x.view(x.size(0), -1)
        mu = self.fc1(x)
        logvar = self.fc2(x)
        return mu, logvar

    def decode(self, z):
        z = self.dec1(z)
        z = z.view(z.size(0), self.final_channels, self.final_side_len, self.final_side_len, self.final_side_len)

        d1, d2, d3, d4 = self.decs
        z = F.relu(d1(z))
        z = F.relu(d2(z))
        z = F.relu(d3(z))
        z = d4(z)

        z = torch.sigmoid(z)
        return z

    def forward(self, x):
        mu, logvar = self.encode(x)
        z = self.reparameterize(mu, logvar)
        decoded = self.decode(z)
        return decoded, mu, logvar
        # return self.decode(z), mu, logvar
```
^^That's the slightly upgraded variational version. What I have done is tr y to get it to reconstruct arbitrary 32\*\*3 cubes of the scroll, picked from a 'safe' middle region:
![[Pasted image 20231109080424.png]]
In the future if I ever get anywhere with this I can do proper masking of where the scroll actually is.
Here is what the results look like:
![[Pasted image 20231109080524.png]]
which seems pretty reasonable to me, considering it was reconstructed from 512 parameters.




# Estimating the ground truth:

![[Pasted image 20231109080312.png]]
