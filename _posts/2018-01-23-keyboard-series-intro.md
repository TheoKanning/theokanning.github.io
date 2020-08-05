---
title: Android Keyboard Series Intro
date: 2018-01-23T02:22:30+00:00
author: theo
layout: post
class: post-template
permalink: /keyboard-series-intro/
excerpt: An overview of my four part series on the Android keyboard.
tags:
  - android
---
## The Keyboard

The Android keyboard is one of the most important and overlooked aspects of app development. A bad keyboard experience will instantly turn users away from your app, often in subtle ways that they don't even realize. Making a great first impression with optimized keyboard interactions is a great way to give your app a polished, professional feel.

Dealing with the keyboard requires a lot of testing and development time, so why can't we just use all of the default settings? Here are three main reasons why you can't neglect the keyboard.

#### Reason #1: Typing is the Worst

No matter how big phones get, setting down my beer and typing my address is time-consuming and error-prone. We can't do anything about the space constraints on mobile devices, but with proper UX and development patterns we can reduce the irritation of typing.

#### Reason #2: Everyone has an opinion

If you're making an app that anyone will use, chances are those people will hours of experience typing on their phones. When I was a consultant, clients often missed loading state issues or basic design and UX flaws, but they immediately picked out every single keyboard issue. Nobody's going to call you out for not using the new animation in the latest support library, but you can bet everyone will notice that pressing &#8220;next&#8221; took them to the wrong place. Save yourself the trouble and get this right the first time.

#### Reason #3: First impressions are important

Imagine you just downloaded a new app, and you're really enjoying it. After a couple minutes, things are getting serious and you're considering making an account and then BAM you have to create a username and password. This is the crucial moment for app developers. They've worked so hard to get you to this point, and now you have to show your dedication by filling out some lame form. If anything takes a second longer than it should, you'll immediately lose interest, uninstall the app, and rant on Twitter about how much you hate it.

Drama aside, this scenario happens millions of times per day. First impressions are everything, and you need to make sure your sign-up screen is perfect in order to give your app a chance. Or just use [Google Sign-In](https://developers.google.com/identity/sign-in/android/start-integrating) and skip all of this.

## Okay, but what can the keyboard do?

Now that you get why the keyboard is so important (or quit reading to add Google Sign-In), here's a list of what I'll go over in this series.

  1. Input Types -  How to let the user type in an email, password, phone number without any extra buttons.
  2. IME Options - How to make the keyboard show custom buttons for specific tasks.
  3. TextInputLayout - A five-minute way to make your app look way better
  4. Showing and hiding - Some easy rules to make sure your keyboard is always in the right place
