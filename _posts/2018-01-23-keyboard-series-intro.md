---
id: 388
title: Android Keyboard Series Intro
date: 2018-01-23T02:22:30+00:00
author: Theo Kanning
layout: post
guid: https://theokanning.com////?p=388
permalink: /keyboard-series-intro/
us_sidebar_pos:
  - right
  - right
us_footer_id:
  - __defaults__
  - __defaults__
us_titlebar_image:
  - ""
  - ""
us_titlebar_bg_size:
  - ""
  - ""
us_titlebar_bg_repeat:
  - ""
  - ""
us_titlebar_bg_position:
  - ""
  - ""
us_titlebar_bg_parallax:
  - ""
  - ""
us_titlebar_overlay_color:
  - ""
  - ""
us_sidebar_id:
  - __defaults__
  - __defaults__
us_header_sticky_pos:
  - ""
  - ""
us_titlebar_subtitle:
  - ""
  - ""
us_titlebar_size:
  - ""
  - ""
us_titlebar_color:
  - ""
  - ""
us_titlebar_breadcrumbs:
  - ""
  - ""
us_og_image:
  - ""
  - ""
us_post_preview_layout:
  - ""
  - ""
us_header_id:
  - __defaults__
us_titlebar_id:
  - __defaults__
us_content_id:
  - __defaults__
us_migration_version:
  - "6.0"
image: /wp-content/uploads/2018/01/intro-featured.gif
categories:
  - Android
  - Keyboard
---
## The Keyboard

The Android keyboard is one of the most important and overlooked aspects of app development. A bad keyboard experience will instantly turn users away from your app, often in subtle ways that they don&#8217;t even realize. Making a great first impression with optimized keyboard interactions is a great way to give your app a polished, professional feel.

Dealing with the keyboard requires a lot of testing and development time, so why can&#8217;t we just use all of the default settings? Here are three main reasons why you can&#8217;t neglect the keyboard.

#### Reason #1: Typing is the Worst

No matter how big phones get, setting down my beer and typing my address is time-consuming and error-prone. We can&#8217;t do anything about the space constraints on mobile devices, but with proper UX and development patterns we can reduce the irritation of typing.

#### Reason #2: Everyone has an opinion

If you&#8217;re making an app that anyone will use, chances are those people will hours of experience typing on their phones. When I was a consultant, clients often missed loading state issues or basic design and UX flaws, but they immediately picked out every single keyboard issue. Nobody&#8217;s going to call you out for not using the new animation in the latest support library, but you can bet everyone will notice that pressing &#8220;next&#8221; took them to the wrong place. Save yourself the trouble and get this right the first time.

#### Reason #3: First impressions are important

Imagine you just downloaded a new app, and you&#8217;re really enjoying it. After a couple minutes, things are getting serious and you&#8217;re considering making an account and then BAM you have to create a username and password. This is the crucial moment for app developers. They&#8217;ve worked so hard to get you to this point, and now you have to show your dedication by filling out some lame form. If anything takes a second longer than it should, you&#8217;ll immediately lose interest, uninstall the app, and rant on Twitter about how much you hate it.

Drama aside, this scenario happens millions of times per day. First impressions are everything, and you need to make sure your sign-up screen is perfect in order to give your app a chance. Or just use [Google Sign-In](https://developers.google.com/identity/sign-in/android/start-integrating) and skip all of this.

## Okay, but what can the keyboard do?

Now that you get why the keyboard is so important (or quit reading to add Google Sign-In), here&#8217;s a list of what I&#8217;ll go over in this series.

  1. Input Types &#8211; How to let the user type in an email, password, phone number without any extra buttons.
  2. IME Options &#8211; How to make the keyboard show custom buttons for specific tasks.
  3. TextInputLayout &#8211; A five-minute way to make your app look way better
  4. Showing and hiding &#8211; Some easy rules to make sure your keyboard is always in the right place