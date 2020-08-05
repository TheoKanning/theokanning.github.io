---
title: Android-Controller Wifi Rover
date: 2016-03-06T18:40:48+00:00
author: theo
layout: post
permalink: /wifi-rover/
us_og_image:
  - ""
  - ""
us_post_preview_layout:
  - ""
  - ""
us_header_sticky_pos:
  - ""
  - ""
us_titlebar_id:
  - __defaults__
  - __defaults__
us_sidebar_id:
  - __defaults__
  - __defaults__
us_sidebar_pos:
  - right
  - right
us_footer_id:
  - __defaults__
  - __defaults__
us_header_id:
  - __defaults__
us_content_id:
  - __defaults__
us_migration_version:
  - "6.0"
image: /wp-content/uploads/2015/03/IMG_20160306_123117231_HDR-e1534898697852-1568x1049.jpg
categories:
  - Uncategorized
---
<figure class="wp-block-image"><img src="https://i0.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123117231_HDR-e1534898697852-1024x685.jpg?resize=1024%2C685&#038;ssl=1" alt="" class="wp-image-201" srcset="https://i2.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123117231_HDR-e1534898697852.jpg?resize=1024%2C685&ssl=1 1024w, https://i2.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123117231_HDR-e1534898697852.jpg?resize=300%2C201&ssl=1 300w, https://i2.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123117231_HDR-e1534898697852.jpg?resize=768%2C514&ssl=1 768w, https://i2.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123117231_HDR-e1534898697852.jpg?resize=1568%2C1049&ssl=1 1568w, https://i2.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123117231_HDR-e1534898697852.jpg?w=1980&ssl=1 1980w" sizes="(max-width: 1024px) 100vw, 1024px" data-recalc-dims="1" /></figure> 

## Wifi Rover

Here's one of my favorite projects so far: a wifi-controlled robot that streams video to the user. I call it the Rover because it can work over any distance as long as it's on a wifi network, and I&nbsp;really feel like an explorer&nbsp;when I drive it around the office. This project was an absolute blast to put together, and it's really the result of putting together a few simple ideas into a single project.

## Software

The rover system works by using two android devices, which I'll call the driver phone and robot phone. The robot phone (in this case a Moto G 2nd gen) is mounted onto the rover and connects to an Arduino that controls the motors. Using a simple serial interface, this phone can send steering commands and control the robot. In addition, the robot phone records video and streams it to the driver phone. I chose QuickBlox as my streaming service, but I designed the app to switch between services with relative ease later on.

The driver phone receives the video stream and gives the user a virtual d-pad to control the rover, and that's all it takes to control the Rover! The actual code implementation is more complicated of course, but I think this project has a charming simplicity to it.

All code is available on my Github [page](https://github.com/TheoKanning/WiFi-Rover).

## Hardware<figure class="wp-block-image">

<img src="https://i1.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123136917-e1534898779417-1024x576.jpg?resize=1024%2C576&#038;ssl=1" alt="" class="wp-image-203" srcset="https://i2.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123136917-e1534898779417.jpg?resize=1024%2C576&ssl=1 1024w, https://i2.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123136917-e1534898779417.jpg?resize=300%2C169&ssl=1 300w, https://i2.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123136917-e1534898779417.jpg?resize=768%2C432&ssl=1 768w, https://i2.wp.com/theokanning.com/wp-content/uploads/2015/03/IMG_20160306_123136917-e1534898779417.jpg?resize=1568%2C882&ssl=1 1568w" sizes="(max-width: 1024px) 100vw, 1024px" data-recalc-dims="1" /> </figure> 

<a rel="noreferrer noopener" href="https://www.sparkfun.com/products/12090" target="_blank">Sparkfun 4WD Multi-Chassis</a>  
<a rel="noreferrer noopener" href="https://www.adafruit.com/products/1438" target="_blank">Adafruit Arduino Motor Shield</a>  
<a rel="noreferrer noopener" href="https://www.adafruit.com/products/50" target="_blank">Arduino Uno</a> (any Arduino that fits the motor shield will work)  
<a rel="noreferrer noopener" href="http://www.rcplanet.com/DuraTrax_NiMH_7_2V_Onyx_3000mAh_Stick_Battery_with_Deans_Univ_Plug_p/dtxc2054.htm?codesf=4012435173&gclid=CjwKEAiAx--2BRDO6q2T84_a52YSJABWAbfrrAg0F8SmmzSxNtwlTqbkXbxsYq0cbL6NpAOppr11tRoCi4Xw_wcB" target="_blank">Onyx 3000 mAh Battery</a>  
<a rel="noreferrer noopener" href="http://www.dx.com/p/micro-usb-male-to-usb-b-male-otg-data-cable-black-25cm-233994#.VtyE5pwrKUk" target="_blank">Micro Usb Male to Usb-B Male Cable</a>  


I used a sheet of acrylic to make the platform, and a basic phone tripod from Target to hold the robot phone. The green chip on the motor shield is a bluetooth chip from another project, and it's not necessary for the Rover to work properly.

## Demo

Here's a short video showing how it works. If you pay close attention, you'll notice that my steering worsens considerably when the Rover gets farther away. That's because once I have to rely entirely on the video stream, the lag makes precise handling pretty difficult, and that's why this robot did a great job of finding all of the wifi dead zones in the office.  
<figure class="wp-block-embed-youtube wp-block-embed is-type-video is-provider-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio">

<div class="wp-block-embed__wrapper">
  <span class="embed-youtube" style="text-align:center; display: block;"></span>
</div></figure>