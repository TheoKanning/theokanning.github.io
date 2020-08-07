---
title: 'Android Keyboard Part 1: Input Types'
date: 2018-01-24T20:29:34+00:00
author: theo
layout: post
class: post-template
permalink: /keyboard-part-1-input-types/
excerpt: Adding Input Types to control what characters the keyboard will display
tags:
  - android
---

Let’s start off with one of the easiest keyboard features: Input Types. Specifying an Input Type allows you to control which characters the keyboard will display.

![](/assets/images/2018/keyboard-1-input-types/input-types.gif)

For example, if you need the user to enter a phone number, you should specify the `"phone"` Input Type and the keyboard will only display digits and valid phone number symbols.


## How to specify an Input Type
Setting an Input Type is extremely easy, just set the android:inputType xml attribute and you’re all set! Here’s an example of how to set your text field to accept a phone number.

{% highlight xml %}
<EditText
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:inputType="phone"
    />
{% endhighlight %}

Here are a few other common Input Types:
- email
- number
- text
- decimal
- password (makes text appear as dots)

## Summary
That’s all there is to it! There are dozens of other options, and they can even be combined to give special fields like a hidden password field that only accepts numbers.
Since specifying an Input Type is so easy and so useful, there’s no excuse not to do it.

If you want to learn more, here’s a link to the full Android documentation.
