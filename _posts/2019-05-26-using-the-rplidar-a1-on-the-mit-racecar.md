---
title: Using the RPLIDAR A1 on the MIT Racecar
date: 2019-05-26T17:58:09+00:00
author: theo
layout: post
class: post-template
permalink: /using-the-rplidar-a1-on-the-mit-racecar/
tags:
  - robotics
---
Using the A1 lidar with ROS is easy! RoboPeak provides a ROS driver that worked out-of-the-box, and I only made slight modifications to the Racecar code. Here&#8217;s what I did.

## The RPLIDAR A1
The MIT Racecar normally has a Hokuyo UST-10LX lidar, but I decided to save $1,000 and use an RPLIDAR A1 instead.
The A1 has good enough accuracy for me, but if I ever want to upgrade I can get an A2 or A3 for a couple hundred dollars more.

## Connecting to the A1

The A1 typically appears as `/dev/ttyUSB0`, but I gave it a more readable, consistent name using udev rules. By adding the following line to my rules file (any rules file will work, but I have one for racecar-specific rules), the A1 will always appear as `/dev/rplidar`

<pre class="wp-block-preformatted"># etc/udev/rules.d/10-racecar.rules
KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE:="0777", SYMLINK+="rplidar"</pre>

I found the vendor and product id via `lsusb`

## ROS Package

The A1 driver node connects to the lidar and converts its data into `LaserScan` messages. A Hokuyo will publish the same `LaserScan` message, just with more data points included, so any navigation system using a lidar will work with either.

First, I cloned the ROS package to my catkin workspace

<pre class="wp-block-preformatted">cd ~/racecar_ws/src
git clone https://github.com/robopeak/rplidar_ros</pre>

and added the rplidar dependencies to my `CMakeLists.txt` and `package.xml` files.

<pre class="wp-block-preformatted"># CMakeLists.txt
catkin_package(
    CATKIN_DEPENDS
    rplidar
    ...

# package.xml
&lt;run_depend&gt;rplidar&lt;/run_depend&gt;
</pre>

Then I updated the racecar launch files to start the RPLIDAR node instead of the Hokuyo node. I turned on angle compensation to reduce shaking, and it works really well!

<pre class="wp-block-preformatted"># sensors.launch
&lt;!-- laser -->
&lt;node pkg="rplidar_ros" type="rplidarNode" name="laser_node">
  &lt;param name="angle_compensate" value="true"/>
&lt;/node>
</pre>

I also told the node to use the new symlink I created earlier.

<pre class="wp-block-preformatted"># sensors.yaml
laser_node:
  serial_port: /dev/rplidar</pre>

## Updating TF data

In order to build a map of an environment, a mapping package like `gmapping` needs to know the position of the lidar relative to the racecar base link. ROS uses a handy library called `tf2` to publish static coordinate frame transform data like this.

The default racecar project already defines the default coordinate transforms between the `base_link` and `laser` frames.. Since the A1 doesn&#8217;t fit in the existing lidar slot, I had to moveit up 2cm and back 2cm. The exact measurements will depend on your setup.

<pre class="wp-block-preformatted"># static_transforms.launch.xml
&lt;node pkg="tf2_ros" type="static_transform_publisher" name="base_link_to_laser" 
 args="0.265 0.0 0.147 0.0 0.0 0.0 1.0 /base_link /laser" /&gt;
</pre>

## Seeing lidar data

The A1 driver includes a handy launch file to visualize the lidar data. This command starts the lidar and shows its scan data in rviz.

<pre class="wp-block-preformatted">roslaunch rplidar_ros view_rplidar.launch</pre><figure class="wp-block-image">

{% include image.html
url="/assets/images/2019/rplidar/rviz.png" %}
<br>

Now that the lidar works in teleop mode, the next step is to use `gmapping` to build a map of my apartment. See you soon!
