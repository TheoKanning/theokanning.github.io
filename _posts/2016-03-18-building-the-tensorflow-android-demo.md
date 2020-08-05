---
title: Building the TensorFlow Android Demo
date: 2016-03-18T04:43:40+00:00
author: theo
layout: post
class: post-template
permalink: /building-the-tensorflow-android-demo/
excerpt: Building Google's mobile TensorFlow demo
tags:
  - machine learning
---
## **Dog == Diaper?**

I recently tried out Google's TensorFlow [Android example](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/examples/android), and it's one of the coolest tech demos I've seen.
Basically, the app uses an image recognition model to classify whatever appears on your camera, and it does this all without sending the pictures to a server. I was honestly amazed when it identified a friend's dog as a Pembroke Corgi, but then it identified another dog as a diaper, so I guess we don't have to worry about our phones taking over the world just yet.

Anyway, I'm working on some image recognition myself, and I think putting a trained model into an app seems like a great start for some new projects. Unfortunately, the build process for this app ended up being more complicated than I expected, so it grew into a post of its own. Nevertheless, it can be done, and I hope I can condense some of the information I found and make things easier for someone else.

**Note:** I did all of this on Linux Mint 17.3, but I think these steps will be beneficial on any OS.

## **Bazel**

Bazel is Google's build tool, and it's optimized for speed and accuracy for their massive projects. I had never used Bazel before, but I didn't have to change anything except for two paths. I'll get more acquainted with it as I start to add my own models, but for now I just installed it according to the [instructions](http://bazel.io/docs/install.html).

## **Android NDK**

This project uses the Android NDK, which allows apps to run native C/C++ code. Since TensorFlow models don't have a Java interface, this step is necessary to communicate with them, but the example project already has all the native code we'll need, and swapping models should require relatively few changes in the future.

**Warning****:** My build failed when using the latest NDK (r11b) due to a missing RELEASE.txt file. A missing text file doesn't sound too important on it's own, but I downloaded a previous version as suggested in this [bug report](https://github.com/tensorflow/tensorflow/issues/1468). That download is a binary file, so it has to be extracted with 7zip and then installed.

## **Cloning and Building**

Now you'll have to clone the entire TensorFlow [repository](https://github.com/tensorflow/tensorflow). The root folder should contain a file called WORKSPACE: this file has the paths to the android SDK and NDK at the very top. Fill in the paths on your system, and be sure to uncomment the blocks! Then perform the following commands to download and extract the trained model:

<pre><pre class="brush: bash; title: ; notranslate" title="">
$ wget https://storage.googleapis.com/download.tensorflow.org/models/inception5h.zip -O /tmp/inception5h.zip
$ unzip /tmp/inception5h.zip -d tensorflow/examples/android/assets/
</pre></pre>

Now you're ready to start building! Run this command from the WORKSPACE root:

<pre><pre class="brush: bash; title: ; notranslate" title="">
$ bazel build //tensorflow/examples/android:tensorflow_demo
</pre></pre>

If you get an error about a missing extenstion file, you'll have to update the repository submodules.

<pre><pre class="brush: bash; title: ; notranslate" title="">git submodule update --init</pre></pre>

I got an error about missing Android Build Tools 23.0.1 being missing, and I just installed it rather than changing all of the references to point to the current version, 23.0.2.  
After about two minutes of building, you'll have an apk! All that's left is installing it with adb.

<pre class="wp-block-preformatted"><pre class="brush: bash; title: ; notranslate" title="">adb install bazel-bin/tensorflow/examples/android/tensorflow_demo.apk</pre></pre>

Now you can scan dogs&nbsp;too! Here's a [link](http://ci.tensorflow.org/view/Nightly/job/nightly-matrix-android/TF_BUILD_CONTAINER_TYPE=ANDROID,TF_BUILD_IS_OPT=OPT,TF_BUILD_IS_PIP=NO_PIP,TF_BUILD_PYTHON_VERSION=PYTHON2,label=android-slave/lastSuccessfulBuild/artifact/bazel-out/local_linux/bin/tensorflow/examples/android/tensorflow_demo.apk) to the nightly build if you want to get updates asap.

I hope you found this useful, and I'll be sure to post more once I start adding my own models. Good luck!
