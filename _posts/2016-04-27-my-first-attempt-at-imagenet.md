---
id: 233
title: My First Attempt at ImageNet
date: 2016-04-27T02:53:04+00:00
author: Theo Kanning
layout: post
guid: https://theokanning.com////?p=233
permalink: /my-first-attempt-at-imagenet/
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
image: /wp-content/uploads/2016/04/thumbnail-e1509592873777.jpg
categories:
  - Uncategorized
---
## **ImageNet**

If you haven&#8217;t heard of it, [ImageNet](http://image-net.org/) is an image data set used for training image recognition systems. It&#8217;s substantially more challenging than the classic MNIST data set, and the ImageNet Large Scale Visual Recognition Competition (ILSVRC) has brought out the best of the best in machine learning research and produced some fantastic papers, so I decided to try my hand at making a model. All of my code is available on [Github](https://github.com/TheoKanning/ImageNet-Classifier).

## **Inspiration**

After seeing Google&#8217;s [TensorFlow](https://www.tensorflow.org/) demo on Android, which I&#8217;ve blogged about [already](https://theokanning.com/////building-the-tensorflow-android-demo/), I wanted to make my own version, but with a few alterations. Google&#8217;s version is trained to recognize the 1000 different classes used in the ILSRVC. However, these classes are not necessarily the most fun to recognize around the home or office. As much as I&#8217;d love to try their app on a container ship, I don&#8217;t think I&#8217;m likely to run into one any time soon, so I cut the number of classes down to 20 for my first version. This also make training and testing much faster, which is always great.

## **Getting the Images**

ImageNet has a handy api that gives you a list of image urls for each class id. However, these list were made year ago and have not been maintained well, so a lot of error handling is required to handle dead links! Many links successfully returned Flickr&#8217;s &#8220;This image has been moved&#8221; image, but I found that checking for a minimum file size of 5kB and attempting to load each image after saving did a great job of weeding out any corrupted or missing links.

Here&#8217;s my code for downloading a single image. It&#8217;s a bit messier than I&#8217;d like, but I had to deal with every possibly error from thousands of links, so I guess it turned out alright.

<div class="gist-oembed" data-gist="986e83af3e640ec57dc7b84c8d097f5c.json" data-ts="8">
</div>

Note that I resize the images as I download them to save space. This prevents me from doing a lot of data augmentation before training, so I&#8217;ll likely change this later once I start to address the overfitting that this first version shows.

## **Loading Datasets**

Now that all the images are downloaded, they are split into training, validation, and test datasets. After splitting, each dataset is normalized by subtracting the training set mean and dividing by the training set std deviation.

My Dataset class is a modified version of the one in TensorFlow&#8217;s [MNIST](https://www.tensorflow.org/versions/r0.8/tutorials/mnist/beginners/index.html) tutorial in case you want a closer look.

## **Architecture**

As a starting point, I copied my architecture almost entirely from the revolutionary [AlexNet](https://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf) classifier. I highly recommend reading about AlexNet since it accomplishes an incredible amount without using overly sophisticated techniques, and many of its features can be found in more complex networks.

Anyway, the classifier has five convolutional layers and three fully-connected layers, and it has more than enough degress of freedom to fit the relatively tiny amount of training data that I have. Like I said earlier, I&#8217;ll have to work to reduce the overfitting this creates, but I found that creating an unnecessarily large model was a better first step.

<div style="width: 560px" class="wp-caption aligncenter">
  <img class="" src="https://i1.wp.com/www.eecs.berkeley.edu/~shhuang/img/alexnet_small.png?resize=550%2C172" width="550" height="172" data-recalc-dims="1" />
  
  <p class="wp-caption-text">
    AlexNet&#8217;s architecture. The two levels are implemented on separate GPUs, which I ignored for this model.
  </p>
</div>

## **Running the Model**

My classifier script is based off of TensorFlow&#8217;s advanced MNIST [tutorial](https://www.tensorflow.org/versions/r0.8/tutorials/mnist/pros/index.html#deep-mnist-for-experts), just with a lot more variables. When I started training this model, I found that my logits were in the billions, which meant that softmax always gave one class a probability of 1 and the rest zero. Since zero is _technically_ the correct answer for 19 of the 20 classes, my model&#8217;s gradient didn&#8217;t produce any learning. Once I added batch normalization after each layer, my model immediately started learning. Basically, batch normalization prevents logit scores from plowing up towards the final layers, which prevents softmax from giving highly skewed answers.

## **Results**

I found that after 15 minutes of training, the model got around 25% accuracy on the validation set. I&#8217;m incredibly happy with this as a starting point, and there&#8217;s plenty of room for improvement. First of all, this model shows tremendous overfitting, even with dropout. I plan to add data augmentation like translations, reflections, and maybe brightness adjustments to remedy this.

Another great idea is to reduce the number of parameters in this model since I&#8217;m fitting one fiftieth as many classes as AlexNet. This would aid with overfitting, not to mention the incredible speed boost. Once I have it working a bit better, I&#8217;ll throw it on a phone and take it around the office!

Let me know what you think, and I&#8217;d be glad to have suggestions on how I can make this better!