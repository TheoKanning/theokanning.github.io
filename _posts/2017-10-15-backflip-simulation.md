---
title: Neural Network Backflip Simulation
date: 2017-10-15T18:04:05+00:00
author: theo
layout: post
class: post-template
permalink: /backflip-simulation/
excerpt: 'An update to my previous Jerry simulation, this time with backflips!'
tags:
  - machine learning
---
# What's new?

![](/assets/images/2017/jerry-backflip/backflip.gif)

In my first simulation [experiment](https://theokanning.com/////walking-simulation/), I successfully trained a human model (hereafter referred to as &#8220;Jerry&#8221;) to &#8220;walk&#8221; across the screen. Despite this success, Jerry's motion was awkward and rigid, and the strange walking gait left me feeling unsatisfied. Here were my main issues with the initial simulation:

  1. Stiff, unrealistic motion
  2. No reaction to any stimuli

As it turns out, fixing these was simpler than I thought. After a large refactor to allow separate simulations for walking and backflipping, I got to work.

# Realistic Motion

The cause of Jerry's unnatural motion was his neural network directly controlled his joint speeds. For example, if a particular output of the network was zero, then Jerry would set his left knee's speed to zero and resist all motion. Because an output of zero is quite common in a sparsely weighted network, this resulted in Jerry holding most of his joints completely still.

When humans walk, our muscles provide a _torque_ around our joints, not a set speed. When a finite torque is applied, each joint will bend in response to forces from the environment, which makes the whole simulation look much more realistic.

I changed Jerry to control joint torque instead of speed, and his behavior changed immediately. Since most of his joints were set to zero torque by default, he started most simulations by falling. After a few generations he fell much less often.

# Reacting

The entire point of this simulation is to teach Jerry to react to a set of inputs, but I noticed that his joint outputs rarely changed during a single run. Clearly, something had to be done.

I suspected that the neural network controlling his motion was saturated, which means that it's being activated too much to respond to any stimuli. I was able to fix this by dramatically reducing the starting weights and biases in his network.

I also added Jerry's joint rates as extra inputs to his neural network. This gave him more varied inputs, and therefore more varied outputs.

# Results

After a long time, Jerry is able to flip almost all of the way around onto his stomach. Ideally, he would tuck his legs in the air and spin faster, but I haven't seen it happen yet.

Here's a video of the full simulation.



# Next Steps

Ideally, Jerry would tuck in his legs and rotate faster. Improving the parameters of the NEAT algorithm could make react better while in the air.

[Source](https://github.com/TheoKanning/Jerry-Learns)
