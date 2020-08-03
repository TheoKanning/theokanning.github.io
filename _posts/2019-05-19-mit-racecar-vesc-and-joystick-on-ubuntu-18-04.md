---
id: 562
title: MIT Racecar VESC and Joystick on Ubuntu 18.04
date: 2019-05-19T02:27:34+00:00
author: Theo Kanning
layout: post
guid: https://theokanning.com/?p=562
permalink: /mit-racecar-vesc-and-joystick-on-ubuntu-18-04/
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
image: /wp-content/uploads/2019/05/00100lPORTRAIT_00100_BURST20190523213628844_COVER-e1558926616341.jpg
categories:
  - Uncategorized
---
After building the MIT Racecar in my last post, I started installing all of the peripherals so I could run it in teleop mode. Unfortunately, using a new Jetson image meant that I couldn&#8217;t use the pre-compiled drivers online. Here&#8217;s how I managed to get the VESC and joystick working.

## VESC Firmware

After buying the VESC from Maytech, I updated the firmware according to the [instructions](https://www.jetsonhacks.com/2018/02/13/racecar-j-programming-the-electronic-speed-controller/) on JetsonHacks (I had to use the instalBLDCTool script). The MIT Racecar requires a specific firmware build that allows controlling the servo via the controller, and fortunately JetsonHacks provides a copy of it.

Also, the new VESC-Tool that replaced BLDCTool will not accept the firmware version that JetsonHacks has available. If you want to compile the servo-out change into a newer version of the firmware, then the VESC-Tool should work.

## Connecting to the VESC

The VESC uses the USB Abstract Control Module protocol, which requires a special cdc_acm driver. I couldn&#8217;t find a compiled version for kernel version 4.9.140, so I had to build the 4.9.140 kernel on the Jetson and include the cdc-acm module.

As usual, [JetsonHacks](https://www.jetsonhacks.com/2017/03/25/build-kernel-and-modules-nvidia-jetson-tx2/) has great instructions on how to build the kernel, but I had to modify their [scripts](https://github.com/TheoKanning/buildJetsonTX2Kernel) to work for 4.9.140. Here&#8217;s a link to my compiled cdc-acm driver in case it helps someone.

<div class="wp-block-file">
  <a href="https://theokanning.com/wp-content/uploads/2019/05/cdc-acm.zip">4.9.140 cdc-acm driver</a><a href="https://theokanning.com/wp-content/uploads/2019/05/cdc-acm.zip" class="wp-block-file__button" download>Download</a>
</div>

To install the cdc-acm driver, I copied it from the compiled kernel output into live `/lib/modules/4.9.140/kernel/drivers/usb/class` folder.

I had to add the following line to `/etc/modules` to load cdc-acm automatically.

<pre class="wp-block-preformatted"># /etc/modules
cdc-acm</pre>

And the following line to `/etc/udev/rules.d/10-racecar.rules` (or any rules file) to make the VESC consistently appear as `/dev/vesc`

<pre class="wp-block-preformatted"># /etc/udev/rules.d/10-racecar.rules
ACTION=="add", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", SYMLINK+="vesc"</pre>

## Connection to the Joystick

In order to use the Logitech F710 joystick, I had to install xboxdrv and run it on startup in daemon mode.

<pre class="wp-block-preformatted">sudo apt-get install xboxdrv</pre>

<pre class="wp-block-preformatted"># /etc/init/xboxdrv.conf<br />exec xboxdrv -D -d --silent</pre>

## Conclusion

That&#8217;s everything required to run the racecar in teleop mode! Build the catkin workspace then run `roslaunch racecar teleop.launch` to drive it around!