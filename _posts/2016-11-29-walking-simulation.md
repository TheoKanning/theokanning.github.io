---
title: Walking with Genetic Algorithms and Neural Networks
date: 2016-11-29T05:12:10+00:00
author: theo
layout: post
class: post-template
permalink: /walking-simulation/
excerpt: Training a human model to walk with neural networks!
tags:
  - machine learning
---
## What's this?

<iframe width="560" height="315" src="https://www.youtube.com/embed/CSuDdG7DB4w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

After seeing [MarI/O](https://www.youtube.com/watch?v=qv6UVOQ0F44) and reading the paper behind the evolution algorithm that SethBling used, I wanted try to make my own simulated person and see if I could teach him how to walk. I made my own humanoid test dummy using Pymunk, and used neural networks and the NEAT algorithm to train him. This ended up being way harder than I expected, but it's one of the coolest things I've ever built.

## Who is that guy?

It's Jerry from Rick and Morty!

![](/assets/images/2016/jerry/jerry.gif)

Jerry made an excellent test subject, and I couldn't have done all this science without his tireless efforts.

## Physics Simulation
### Tools

Simulating humanoid walking is about as difficult as it sounds, but it's possible to get a low-accuracy prototype that's good enough for Jerry. For the physics simulation, I used a simulator called [pymunk](http://www.pymunk.org/en/latest/), which is a python wrapper for the C++ Chipmunk physics engine. Chipmunk has been ported to lots of different platforms for mobile games and silly projects like this one, so it seemed like a good starting point.

I used Pygame for the visualization, and as you can see it's not the prettiest option for something like this. I unfortunately didn't realize that until it was too late, so we're stuck with a pixelated Jerry for now.

### Human Body Model
Simulations in pymunk consist of three basic objects: mass-containing bodies, colliding shapes, and constraints. Each segment of Jerry (thigh, torso etc) consists of a body to contain its mass and a shape to handle its collisions with other shapes. Each of his joints (shoulder, elbow etc) attaches two segments together using three kinds of constraints:

  1. Pivot Joint: attaches the two segments together but allows them to rotate
  2. Rotary Limit Joint: restricts the rotating range of the two segments
  3. Motor: allows setting the angular rate of the joint

I gave each joint a realistic range, and that was enough to create a pretty rough simulation of a human body. My former biomedical engineering professors would disagree, but I think the blatant inaccuracies make it more fun to watch. Good thing I'm here simulating cartoons instead of designing medical devices! Seriously though, it would be interesting to retry this using a more accurate simulator like [OpenSim](http://opensim.stanford.edu/) and see how much of a difference it makes.

### Test Runs
Each test run starts the same way, and they all end if Jerry's upper body touches the ground or if he goes five seconds without making any forward progress. I avoided adding arbitrary constraints to make him walk a certain way &#8211; which is obvious once you see what he came up with &#8211; because I thought it would ruin the purity of the simulation. The only concessions I made were to restrict his hip range slightly and eliminate motion of his elbows. Elbows aren't all that useful anyway, and they were adding size to tiny his neural network brain.

## Neural Networks
### Overview
Neural networks are a natural choice for controlling a walking person; they can learn complex nonlinear behaviors, they're fun, and hey, they're how humans actually walk. At their simplest level, neural networks take a set of inputs, apply weights and biases to them through multiple layers, and produce a set of outputs. Mathematically, the weights and biases can replicate any nonlinear function, so neural networks should be a good fit for the complex control required for walking.

If you're not familiar with neural networks, I recommend Michael Nielsen's excellent [guide](http://neuralnetworksanddeeplearning.com/chap1.html) (the first chapter is enough to get what I'm doing here, but I won't be offended if you keep reading and forget this project entirely).

### Controlling Jerry
Now that we know what tool to use, how do we go about controlling Jerry's joints?
First let's think about the input data we have available. We can get the angle and rate of all of his joints, and if we include the angle and rate of his torso relative to the simulation world, then he'll know everything about his current state.
However, since we control the joint rates directly, sending them as inputs doesn't add any new information. Therefore, Jerry has 8 (joint angles) + 1 (torso angle) + 1  (torso rate) = 10 inputs.

As for his outputs, Jerry can control each joint's rate, so he has 8 outputs (elbows are still ignored).

I used a single hidden layer with 9 neurons, and I initialized the network with a small, random set of connections. That way Jerry can still have plenty of room to learn, and the first generation won't be completely identical.

Now that we've gone through all effort to learn how neural networks work, we'll use a python library to do all of that work for us! But first, let's see how genetic evolution can generate a neural network that solves our walking problem.

## Genetic Evolution

Genetic algorithms mimic the process of Darwinian evolution to generate a solution to an optimization problem (I'm pretty much copying nature whenever I can). Let's break that down a bit:

  * Optimization problem: This (roughly) implies that a solution to our problem can be scored instead of merely being a success or failure. We'll see later that we use this score, called _fitness_, to create continuous improvements to our solution.
  * Darwinian evolution: We generate a set of neural networks, called a _population_, and measure the fitness of each individual. A genetic algorithm then combines individuals with higher fitness scores, applies some random mutations, and tests the fitness of the new population. Over time, this will make beneficial genes in the networks more common, and the fitness of the population will increase over each generation.

These types of algorithms do a great job of solving very complex problems like this, but they can take many generations to reach a solution. The beauty of genetic algorithms is all new features in individuals come from pure randomness, and natural selection organically makes them more common. Hooray! Now let's find a library to do all of this for us.

## NEAT

The NeuroEvolution of Augmenting Topologies algorithm is a genetic evolution algorithm designed specifically for neural networks, and the excellent [paper](http://nn.cs.utexas.edu/downloads/papers/stanley.ec02.pdf) describes all of its features in depth. I found out about [NEAT](https://www.youtube.com/watch?v=Hm3JodBR-vs) through SethBling's [MarI/O](https://www.youtube.com/watch?v=qv6UVOQ0F44) experiment in which he uses NEAT to create a Super Mario World AI.

Each block, enemy, and item in the first level of Super Mario World corresponded to an input to a neural network, and each output corresponded to one the the buttons on the controller. After many generations, the neural network correctly associates inputs with actions, and Mario finally makes it to the end of the level.

NEAT's advantages are very subtle, but its main advantage is that it describes how to combine, mutate, and create neural networks to create a _minimal_ solution. A minimal solution uses as few connections as possible, and it's best to keep neural networks as simple as possible so that no extraneous signals are interfering with normal operation. We'll be using [NEAT-python](http://neat-python.readthedocs.io/en/latest/), an excellent Python implementation of the NEAT algorithm. NEAT-python will create and update the neural network population for us, and all we have to do is take a single neural network and calculate its fitness. Sounds pretty neat!

Sorry.

## Calculating Fitness

In a genetic algorithm, fitness is basically a score that is calculated for each individual, and a higher fitness means a higher chance of surviving to the next generation. Since we're trying to teach Jerry to walk, we need a fitness function that rewards walking. The fitness function has a huge effect on the kind of solutions a genetic algorithm will generate, so it's important to pick one that incentivizes the correct behavior.

My fitness function changed over time as I found problems with it, and here's a general history.

  1. Reward distance traveled to the right. 
      1. This was enough to get him moving, but he just dove to the right instead of trying to walk
  2. I reduced the fitness bonus gained while travelling with a torso angle, and an angle greater than 30 degrees results in no points gained 
      1. This kept him more vertical, but he started arching his back while falling forward
  3. Penalty for losing height 
      1. This made falling less acceptable

And that's all! I don't have any rule saying he has to put one foot in front of the other, so he's learning naturally without any extra help.

To help visualize Jerry's progress, I added a black line that shows his current fitness expressed as a distance. If Jerry stays vertical and up high, each pixel he travels will give him 1 point, and the black line will stay with him. However, if he learns forward of starts to fall, he'll get less credit for his distance, and the black line will start to lag behind him.

## Let's Go!

Now it's time to set Jerry free and see how he does! I used an initial population of 100 Jerry's and let the simulation run for a while. The initial population was very bad, mostly falling over. Over time, he started to fall forward, and then he started to stay upright. Here's a clip of his best run so far.

<iframe width="560" height="315" src="https://www.youtube.com/embed/dVgcb00HR6k" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Not only did Jerry successfully walking across the entire simulation, he even created a new, better method of walking! Okay, maybe his sliding dance bounce isn't the best way to walk, but I'm still very happy with the results here. This really shows the importance of the fitness function; Jerry isn't rewarded for putting one foot in front of the other, so he learns the simplest way to move first.

I looked around at some other examples of using neural networks to learn walking, and I was unable to find an experiment that didn't impose _any_  artificial constraints to make the subject follow a normal human gait.
All examples either rewarded putting one foot in front of the other or used separate logic for difference phases of walking.
I didn't want to to enforce any arbitrary constraints like this because they felt like cheating (and they're more work), but I humans technically  learn to walk by watching others, so I think it's worth trying.

## Further Work

Despite Jerry's success, I have a few main areas to improve this simulation.

  * Tune weights better: If Jerry's neural network has weights that are too large, his neurons will saturate, and he won't be able to react to changes as quickly. I never really figured out the best min and max weight values despite a lot of experimentation. Removing his hidden nodes might also help with this.
  * Add artificial constraints: Other people have earned PhDs making simulations with artificial gait constraints to make their subjects walk more naturally, so I guess I shouldn't feel bad about adding any special constraints here.
  * Control joint forces instead of rates: When Jerry has no inputs, he will set all of his joints to 0 velocity and use his unreasonable strength to keep them there. If his joint angles can't change, then his outputs never changes, and nothing ever happens. If he controlled the force on each joint instead, his joints wouldn't be frozen by default, and more change would beget more interesting outputs.
  * More accurate anatomy: Right now all of Jerry's joints are equally strong. Enough said.
  * Better physics simulator: Using a nice tool designed for anatomical simulations would give Jerry a much better chance of walking naturally. Unfortunately, I don't know if OpenSim is able to add a Jerry skin to a simulated body, and that's a deal breaker for me.
  * Better recording: Recording videos with pygame is a HUGE pain right now, and if I had a better setup I could make more videos without driving myself crazy.

I think it would be fun to make Jerry do a backflip or something too.

![](/assets/images/2016/jerry/meeseeks.gif)

## Thanks!

Thanks for reading about Jerry's journey, and I hope you enjoyed all of this science! All code is available on [Github](https://github.com/TheoKanning/Walking-with-Neural-Networks), and I'll be happy to answer any questions you might have.

