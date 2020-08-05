---
title: MIT Racecar Build
date: 2019-05-05T21:30:40+00:00
author: theo
layout: post
class: post-template
permalink: /mit-racecar-build/
tags:
  - robotics
---
Ever since taking Udacity's Robotics Nanodegree last year, I've wanted to try to build the [MIT Racecar](http://fast.scripts.mit.edu/racecar/hardware/), a powerful robotics development platform based on an actual MIT class. Its real strength is the number of helpful resources online (most notably [Jetson Hacks](http://www.jetsonhacks.com)[J](https://racecarj.com/)) that make the undertaking much easier.

{% include image.html
url="/assets/images/2019/racecar/racecar.jpg" %}
<br>

The full racecar is a pretty serious project; it includes a Hokuyo lidar and two(!) 3D cameras. I decided to get a much cheaper lidar and skip the 3D cameras for now. 

JetsonHacks already has great videos on how to assemble the racecar, so I won't go into detail about that. However, I did have some difficulty finding a battery to power the Jetson, and I'll share my solution here.

## Standard Parts

Most of the parts I used were straight off of the JetsonHacks [tutorials](https://www.jetsonhacks.com/racecar-j/). These include:

  * TRAXXAS Slash 4×4 Platinum Truck &#8211; [traxxas](https://traxxas.com/products/models/electric/6804Rslash4x4platinum)
  * Jetson TX2 &#8211; [nvidia](https://developer.nvidia.com/embedded/buy/jetson-tx2)
  * VESC (Speed Controller) &#8211; [alibaba](https://www.alibaba.com/product-detail/Maytech-VESC-4-12-Motor-controller_60532388864.html) &#8211; Made by Maytech
  * USB 3.0 Hub &#8211; [amazon](https://www.amazon.com/AmazonBasics-Port-2-5A-power-adapter/dp/B00DQFGH80)
  * Mounting Hardware &#8211; [racecarj](https://racecarj.com/products/mechanical-hardware) &#8211; Technically you could buy these screws on your own, but I didn't feel like it
  * Spring Upgrade &#8211; [racecarj](https://racecarj.com/products/spring-upgrade) &#8211; Necessary or the car will scrape the ground with all the added weight
  * Sparkfun 9DoF IMU &#8211; [sparkfun](https://www.sparkfun.com/products/14001)
  * 3000 mAh NiMH Battery &#8211; Any hobby store will have this
  * E-Stop Button &#8211; [amazon](https://www.amazon.com/gp/product/B00SDX0GD2/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1)

I also used 3M dual-lock tape to hold everything down.

## Modifications

#### Lidar

Since the Hokuyo lidar costs well over $1,000, I decided to buy the $100 RPLIDAR-A1 ([slamtech.com](http://www.slamtec.com/en/lidar/a1)) instead. It has a much smaller range, but I think it will work fine for now. If I have to upgrade later I'll probably go for the A2.<figure class="wp-block-image">

{% include image.html
url="/assets/images/2019/racecar/lidar.jpg"
description="The A1 barely has room, even with two extra standoffs" %}
<br>

Because the A1 doesn't fit into the hole in the frame, it actually sticks up higher than the Hokuyo, and I had to add extra standoffs to move the top level up.

#### Battery

The Jetson needs a separate battery to power it and all of the USB devices. JetsonHacks recommends the Energizer XP18000AB, which has a 19V output for the Jetson and a 12V output for the USB hub. Unfortunately, I couldn't find it for sale anywhere online, or any other power pack with 19V and 12V outputs, so I had to get creative.<figure class="wp-block-image is-resized">

{% include image.html
url="/assets/images/2019/racecar/battery.jpg"
description="My battery setup. I've updated it to power both the Jetson and usb hub via a barrel jack splitter." %}
<br>

My solution was to buy a PowerAdd Pilot Pro ([amazon](https://www.amazon.com/gp/product/B00DN0KBXU/ref=ppx_yo_dt_b_asin_title_o04_s00?ie=UTF8&psc=1)), and get a barrel jack splitter to power both the usb hub and jetson with 12V.
I originally powered the usb hub with a usb to barrel jack cord, but it wasn't supplying enough power and the lidar would randomly stop working.

#### Frame

I received a free RacecarJ frame from another Udacity ND student, but it didn't exactly match the two versions available online. I'm not sure if I got a prototype or what, but I'm not complaining.

I had to drill a few holes in it to mount the lidar and and IMU, but it wasn't a big deal.

## That's All

I had to drill a few holes and get creative with zip ties to mount everything together, but overall it was really enjoyable. Now let's see if I can get it running!
