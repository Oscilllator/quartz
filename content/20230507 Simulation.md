# Idea 
## Justification
So far nobody seems to know about how to make an enzyme from scratch that achieves a given task. Being able to do this is one of those "duh, worth trillions" ideas so presumably people are working on it. But there don't seem to be that many.
There do seem to be pieces scattered about that form part of the solution though. There's that one protein folding paper, of course. But there have also been many examples of the use of NN's to perform physics simulations which seems to me to be a highly understudied area. 
## Approach
It seems like a fairly obvious idea to me that one could create a net that was capable of quite good high level chemistry simulations via doing something like this:
- Get a lot of small-scale but accurate data (e.g. burning methane) using existing simulations. Then you could train a net on these small sections in such a way that it scaled better to larger simulations, since one of the problems with existing simulations is the scaling laws that they follow (e.g. N body simulation naively grows with N^2, but it's obvious it doesn't have to really) and one of the things that neural nets can be good at is paying _attention_ to stuff that is important.
- Such a neural net might be good at small stuff but it would presumable fail on something larger. I analogise this to a pretrained LLM that's good at nitty gritty but lacks directedness. The analogy is not really that good though. 
- So then one could then train it on larger datasets. Even telling it "This protein here is an enormous molecule but it's stable. Stop predicting that it catches fire" would probably help a fair bit.
- This is where the unclear and hard parts come in. I don't know how good existing datasets cover the functioning of enzymes, or how one would train such a thing. You would have to explain to the net that "carboxylic acid just sits here but carboxylic acid + enzyme gets reduced to aldehyde". Where "enzyme" is expressed as the actual structure of the enzyme, not just the sequence.
## Possibility
Fundamentally I just don't think that the operation of enzymes are that complicated. A typical enzyme has like 10k-100k atoms in it. You would probably need to simulate a total of 1e6 atoms or so to cover the environment the enzyme is in and stuff but the interactions between atoms are not that complicated in the informational sense - the number of bytes required to write down the physics equations that describe chemical reactions is not large, it's just tremendously nonlinear.
So I think a device that can do like 1e12 operations per second could probably crank out some good simulations of this stuff. If you needed to simulate like 1e6 enzymes to find the one that worked then I think things would start to get infeasible, but that's not really how modern NN's work - ChatGPT does not search millions of sentences to output, it just outputs one. 
## Architecture
It's clear though that great care is going to need to be put into the architecture of the net. In particular because the whole point of this net is computational efficiency (not something nets are known for), the net is going to need to learn to rearrange the internal data structure to fit its needs. It will have to be able to move the weights for adjacent atoms next to each other and then _not even perform calculations_ on far away atoms, or at least do so at some aggregate level. There's no other way to avoid this N^2 scaling behaviour. I just went and watched karparty's GPT lectures to try and find out exactly how this attention mechanism works. It's not totally clear to me but it seems the main way is that the "attention" is done via applying different weights to different sections of the data rather than actually fetching different parts of the data. If that's the case it won't work for this situation since 0\*0 takes the same number of flops as 3\*4, although only the latter is useful.
Again, the necessity and utility of this data fetching approach is obvious. So it either already exists, or is hard to make. So one of the first things to discover is how feasible it is.
### Keep the bitter lesson in mind
Thinking about this stuff there are already a whole bunch of weirdo index fetching frankenstein hand tuned architectures that are coming to mind. I need to make sure not to spend too much time trying to implement them - The history of neural nets is the history of "gpu go brrrr", and I need to respect that. Having learned efficiency seems like it could be a huge win, though.

# Trivial example: n body simulation
I know that people have already done this before, but I think that a good first step would be training a model to simulate N body graviational physics. 
- It's easy to make such a simulation. F = Gmm/r^2 bro.
- It has N^2 scaling when you add more bodies. A naive gpu simulation takes 70ms to simulate one 5k body timestep using pytorch.
- If you look at the simulation by eye you can tell if it's egregiously wrong. e.g. if you make a cloud of spinny stuff it should orbit.
So if  I can't get this to work in a reasonable amount of time I should probably just give up. From there we can work up to something more complicated - I imagine just wrangling the datasets and simulation stuff for small molecule simulations is pretty complicated so this is a good sanity check I think.

## Small aside: ChatGPT is great for this stuff
I have never used pytorch before. So having all the syntax explained and predicted is a huge help here. I don't think it would be worth doing this project without it, it would just take me too long to futz about looking at docs and stuff. Same goes with doing visualizations - I have used pyqtgraph before a bunch but getting a net to write out all the API stuff is a performance boost on the order of 2-10x. If you know what you want the code to look like, but just don't know the magic incantation to get it to work, LLM's are brilliant.


# After actually googling stuff

People have definitely been looking at this but it seems my central point about nobody having actually achieved it is correct. 

#### Large language models generate functional protein sequences across diverse families
This paper seems to have gotten the furthest. They actually synthesised the proteins they generated, but their goal seemed to be "generate protein that does a previously-known task with a different sequence".



## Ideas for specfic enzymes
- Carbon nanotube polymerase
- Light + H2O -> O2 + H2
- 