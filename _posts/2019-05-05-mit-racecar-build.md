---
id: 556
title: MIT Racecar Build
date: 2019-05-05T21:30:40+00:00
author: Theo Kanning
layout: post
guid: https://theokanning.com/?p=556
permalink: /mit-racecar-build/
us_og_image:
  - ""
us_post_preview_layout:
  - ""
us_header_sticky_pos:
  - ""
us_titlebar_id:
  - __defaults__
us_sidebar_id:
  - __defaults__
us_sidebar_pos:
  - right
us_footer_id:
  - __defaults__
us_header_id:
  - __defaults__
us_content_id:
  - __defaults__
us_migration_version:
  - "6.0"
image: /wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505151605141_COVER-1-e1557092151558.jpg
categories:
  - Uncategorized
---
<figure class="wp-block-image"><img src="https://i2.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505151605141_COVER.jpg?fit=1024%2C768&ssl=1" alt="" class="wp-image-557" srcset="https://i1.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505151605141_COVER.jpg?w=4032&ssl=1 4032w, https://i1.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505151605141_COVER.jpg?resize=300%2C225&ssl=1 300w, https://i1.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505151605141_COVER.jpg?resize=1024%2C768&ssl=1 1024w, https://i1.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505151605141_COVER.jpg?resize=768%2C576&ssl=1 768w, https://i1.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505151605141_COVER.jpg?w=2280&ssl=1 2280w, https://i1.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505151605141_COVER.jpg?w=3420&ssl=1 3420w" sizes="(max-width: 1140px) 100vw, 1140px" /></figure> 

Ever since taking Udacity&#8217;s Robotics Nanodegree last year, I&#8217;ve wanted to try to build the [MIT Racecar](http://fast.scripts.mit.edu/racecar/hardware/), a powerful robotics development platform based on an actual MIT class. Its real strength is the number of helpful resources online (most notably [Jetson Hacks](http://www.jetsonhacks.com)[J](https://racecarj.com/)) that make the undertaking much easier.

The full racecar is a pretty serious project; it includes a Hokuyo lidar and two(!) 3D cameras. I decided to get a much cheaper lidar and skip the 3D cameras for now. 

JetsonHacks already has great videos on how to assemble the racecar, so I won&#8217;t go into detail about that. However, I did have some difficulty finding a battery to power the Jetson, and I&#8217;ll share my solution here.

## Standard Parts

Most of the parts I used were straight off of the JetsonHacks [tutorials](https://www.jetsonhacks.com/racecar-j/). These include:

  * TRAXXAS Slash 4×4 Platinum Truck &#8211; [traxxas](https://traxxas.com/products/models/electric/6804Rslash4x4platinum)
  * Jetson TX2 &#8211; [nvidia](https://developer.nvidia.com/embedded/buy/jetson-tx2)
  * VESC (Speed Controller) &#8211; [alibaba](https://www.alibaba.com/product-detail/Maytech-VESC-4-12-Motor-controller_60532388864.html) &#8211; Made by Maytech
  * USB 3.0 Hub &#8211; [amazon](https://www.amazon.com/AmazonBasics-Port-2-5A-power-adapter/dp/B00DQFGH80)
  * Mounting Hardware &#8211; [racecarj](https://racecarj.com/products/mechanical-hardware) &#8211; Technically you could buy these screws on your own, but I didn&#8217;t feel like it
  * Spring Upgrade &#8211; [racecarj](https://racecarj.com/products/spring-upgrade) &#8211; Necessary or the car will scrape the ground with all the added weight
  * Sparkfun 9DoF IMU &#8211; [sparkfun](https://www.sparkfun.com/products/14001)
  * 3000 mAh NiMH Battery &#8211; Any hobby store will have this
  * E-Stop Button &#8211; [amazon](https://www.amazon.com/gp/product/B00SDX0GD2/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1)

I also used 3M dual-lock tape to hold everything down.

## Modifications

#### Lidar

Since the Hokuyo lidar costs well over $1,000, I decided to buy the $100 RPLIDAR-A1 ([slamtech.com](http://www.slamtec.com/en/lidar/a1)) instead. It has a much smaller range, but I think it will work fine for now. If I have to upgrade later I&#8217;ll probably go for the A2.<figure class="wp-block-image">

<img src="https://i1.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505161249546_COVER.jpg?fit=1024%2C768&ssl=1" alt="" class="wp-image-558" srcset="https://i2.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505161249546_COVER.jpg?w=4032&ssl=1 4032w, https://i2.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505161249546_COVER.jpg?resize=300%2C225&ssl=1 300w, https://i2.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505161249546_COVER.jpg?resize=1024%2C768&ssl=1 1024w, https://i2.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505161249546_COVER.jpg?resize=768%2C576&ssl=1 768w, https://i2.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505161249546_COVER.jpg?w=2280&ssl=1 2280w, https://i2.wp.com/theokanning.com/wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190505161249546_COVER.jpg?w=3420&ssl=1 3420w" sizes="(max-width: 1140px) 100vw, 1140px" /> <figcaption> The A1 barely has room, even with two extra standoffs</figcaption></figure> 

Because the A1 doesn&#8217;t fit into the hole in the frame, it actually sticks up higher than the Hokuyo, and I had to add extra standoffs to move the top level up.

#### Battery

The Jetson needs a separate battery to power it and all of the USB devices. JetsonHacks recommends the Energizer XP18000AB, which has a 19V output for the Jetson and a 12V output for the USB hub. Unfortunately, I couldn&#8217;t find it for sale anywhere online, or any other power pack with 19V and 12V outputs, so I had to get creative.<figure class="wp-block-image is-resized">

<img src="https://i2.wp.com/theokanning.com/wp-content/uploads/2019/05/IMG_20190518_171337.jpg?fit=1024%2C768&ssl=1" alt="" class="wp-image-577" width="1008" height="756" srcset="https://i0.wp.com/theokanning.com/wp-content/uploads/2019/05/IMG_20190518_171337.jpg?w=4032&ssl=1 4032w, https://i0.wp.com/theokanning.com/wp-content/uploads/2019/05/IMG_20190518_171337.jpg?resize=300%2C225&ssl=1 300w, https://i0.wp.com/theokanning.com/wp-content/uploads/2019/05/IMG_20190518_171337.jpg?resize=1024%2C768&ssl=1 1024w, https://i0.wp.com/theokanning.com/wp-content/uploads/2019/05/IMG_20190518_171337.jpg?resize=768%2C576&ssl=1 768w, https://i0.wp.com/theokanning.com/wp-content/uploads/2019/05/IMG_20190518_171337.jpg?w=2280&ssl=1 2280w, https://i0.wp.com/theokanning.com/wp-content/uploads/2019/05/IMG_20190518_171337.jpg?w=3420&ssl=1 3420w" sizes="(max-width: 1008px) 100vw, 1008px" /> <figcaption>My battery setup. USB hub power on the left, Jetson power on the right.</figcaption></figure> 

My solution was to buy a PowerAdd Pilot Pro ([amazon](https://www.amazon.com/gp/product/B00DN0KBXU/ref=ppx_yo_dt_b_asin_title_o04_s00?ie=UTF8&psc=1)), use its 19V output for the Jetson, and get a USB to barrel jack adapter to power the USB hub. I ended up getting a 2.1mm [connector](https://www.amazon.com/CCYC-Barrel-Wireless-Router-Speakers/dp/B079K2DS3H/ref=asc_df_B079K2DS3H/) and using the 4.75 x 1.7 HP laptop adapter included with the battery to connect it to the USB hub.

#### Frame

I received a free RacecarJ frame from another Udacity ND student, but it didn&#8217;t exactly match the two versions available online. I&#8217;m not sure if I got a prototype or what, but I&#8217;m not complaining.

I had to drill a few holes in it to mount the lidar and and IMU, but it wasn&#8217;t a big deal.

## That&#8217;s All

I had to drill a few holes and get creative with zip ties to mount everything together, but overall it was really enjoyable. Now let&#8217;s see if I can get it running!