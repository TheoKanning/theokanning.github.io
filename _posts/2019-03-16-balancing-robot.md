---
id: 521
title: Dexter the Two-Wheeled Balancing Robot
date: 2019-03-16T16:17:39+00:00
author: Theo Kanning
layout: post
guid: https://theokanning.com/?p=521
permalink: /balancing-robot/
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
image: /wp-content/uploads/2019/03/dexter-1-e1552753362695.jpg
categories:
  - Uncategorized
---
<figure class="wp-block-image"><img src="https://i2.wp.com/theokanning.com/wp-content/uploads/2019/03/dexter.jpg?resize=768%2C1024&#038;ssl=1" alt="" class="wp-image-522" srcset="https://i2.wp.com/theokanning.com/wp-content/uploads/2019/03/dexter.jpg?resize=768%2C1024&ssl=1 768w, https://i2.wp.com/theokanning.com/wp-content/uploads/2019/03/dexter.jpg?resize=225%2C300&ssl=1 225w, https://i2.wp.com/theokanning.com/wp-content/uploads/2019/03/dexter.jpg?w=1518&ssl=1 1518w" sizes="(max-width: 768px) 100vw, 768px" data-recalc-dims="1" /><figcaption>Introducing Dexter: the cutest balancing robot ever made  
</figcaption></figure> 

## Dexter

Dexter is a two-wheeled balancing robot controlled by an Android App. I originally created Dexter as a modified version of the [wifi-rover](https://theokanning.com/wifi-rover/) project that I made a few years ago. This time I was looking for a bigger challenge and for something to do with the stepper motors I had lying around.

## Hardware

  * Teensy LC Microncontroller&nbsp;[pjrc](https://www.pjrc.com/teensy/teensyLC.html)
  * MPU-6050 IMU&nbsp;[sparkfun](https://www.sparkfun.com/products/11028)
  * 2 A4988 Stepper Drivers&nbsp;[pololu](https://www.pololu.com/product/1182)
  * HC-05 Bluetooth Module&nbsp;[amazon](https://www.amazon.com/LeaningTech-HC-05-Module-Pass-Through-Communication/dp/B00INWZRNC)
  * 2 Stepper Motors&nbsp;[sparkfun](https://www.sparkfun.com/products/9238)
  * 1300 mAh 3S LiPo Battery

The Teensy LC was a good fit for this project because it has 3 hardware serial lines and multiple timers. Dexter uses serial to communicate with the HC-05, and the stepper drivers each require a 16 bit timer to work.

I don&#8217;t know the exact model number of the motors I used, but they look pretty standard.

I also added some iron weight on top for added stability.

## Custom Frame and PCB

<ul class="wp-block-gallery columns-2 is-cropped">
  <li class="blocks-gallery-item">
    <figure><img src="https://i0.wp.com/theokanning.com/wp-content/uploads/2019/03/frame.jpg?resize=768%2C1024&#038;ssl=1" alt="" data-id="527" data-link="https://theokanning.com/frame/" class="wp-image-527" srcset="https://i0.wp.com/theokanning.com/wp-content/uploads/2019/03/frame.jpg?resize=768%2C1024&ssl=1 768w, https://i0.wp.com/theokanning.com/wp-content/uploads/2019/03/frame.jpg?resize=225%2C300&ssl=1 225w, https://i0.wp.com/theokanning.com/wp-content/uploads/2019/03/frame.jpg?w=1518&ssl=1 1518w" sizes="(max-width: 768px) 100vw, 768px" data-recalc-dims="1" /></figure>
  </li>
  <li class="blocks-gallery-item">
    <figure><img src="https://i1.wp.com/theokanning.com/wp-content/uploads/2019/03/pcb.jpg?resize=768%2C1024&#038;ssl=1" alt="" data-id="528" data-link="https://theokanning.com/pcb/" class="wp-image-528" srcset="https://i1.wp.com/theokanning.com/wp-content/uploads/2019/03/pcb.jpg?resize=768%2C1024&ssl=1 768w, https://i1.wp.com/theokanning.com/wp-content/uploads/2019/03/pcb.jpg?resize=225%2C300&ssl=1 225w, https://i1.wp.com/theokanning.com/wp-content/uploads/2019/03/pcb.jpg?w=1518&ssl=1 1518w" sizes="(max-width: 768px) 100vw, 768px" data-recalc-dims="1" /></figure>
  </li>
</ul>

I designed the 3D-printed frame using Fusion 360, and designed the custom circuit board in Eagle.  
  
[Frame STP File](https://theokanning.com/wp-content/uploads/2019/03/Dexter-v1.zip)  
[PCB Eagle Design Block](https://theokanning.com/wp-content/uploads/2019/03/dexter_design_block.zip)

## IMU

The MPU-6050 IMU includes a gyroscope and accelerometer, and I combined the measured angle from the accelerometer with the rate from the gyro using a basic filter. A more advanced Kalman filter would be more accurate, but IMU accuracy was not a limiting factor.

`pitch = 0.99 * (pitch + G_y * dt) - 0.01 * atan2(A_x, A_z)`

The rate from the gyroscope reacts quickly to changes in pitch, and the small correction from the accelerometer prevents drifting over time. The accelerometer is very sensitive to quick movements, so it can&#8217;t be used by itself.

IMU code was taken from the Arduino example ([link](https://playground.arduino.cc/Main/MPU-6050#sketch))

## Motor Drivers  


The Teensy controls the A4988 motor drivers by sending pulses; each time the Teensy sends a pulse, the driver takes one step. To send pulses, I used the&nbsp;`TimerOne`&nbsp;and&nbsp;`TimerThree`&nbsp;libraries. These libraries trigger a callback funciton at a specified frequency, and in the callback function I send a pulse by toggling the trigger pin on and off.

Both motors were operated in 1/8 microstepping mode for smoother motion.

## PID Control

Dexter uses two cascading controllers. First, the ground speed PI controller calculates the desired angle based on the speed error. Second, the angle PD controller calculates the output steps per second to reach the desired angle. Since these motors don&#8217;t have encoders, the only way to measure the current ground speed is to use the steps per second value calculated by the angle controller.

To tune Dexter, I added a basic&nbsp;[Twiddle](https://www.youtube.com/watch?v=2uQ2BSzDvXs)&nbsp;function. If Dexter receives the letter &#8220;t&#8221; over bluetooth, he will drive forward for a few seconds, stop, drive back, and report the total error during the trip. All of the PID constants can be changed over bluetooth and optimized to reduce the twiddle error.

## Android App

The included Android app steers Dexter by reading the accelerometer. In order to tune the PID constants, I used a bluetooth terminal app ([Play Store Link](https://play.google.com/store/apps/details?id=com.giumig.apps.bluetoothserialmonitor&hl=en_US))

## Github

Android and Arduino source code [link](https://github.com/TheoKanning/Dexter)

## [](https://github.com/TheoKanning/Dexter#sources)References

I found both of these examples to be extremely helpful  
[jjrobots B-robot EVO 2](https://github.com/jjrobots/B-ROBOT_EVO2/tree/master/Arduino/BROBOT_EVO2)  
[Brokking YABR](http://www.brokking.net/yabr_main.html)