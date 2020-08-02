---
id: 431
title: 'Android Keyboard Part 4: Showing and Hiding'
date: 2018-01-28T11:18:31+00:00
author: Theo Kanning
layout: post
guid: https://theokanning.com////?p=431
permalink: /keyboard-part-4-showing-and-hiding/
us_og_image:
  - https://theokanning.com/////wp-content/uploads/2018/01/show-and-hide.gif
  - https://theokanning.com/////wp-content/uploads/2018/01/show-and-hide.gif
us_post_preview_layout:
  - ""
  - ""
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
us_sidebar_pos:
  - right
  - right
us_footer_id:
  - __defaults__
  - __defaults__
us_titlebar_id:
  - __defaults__
us_header_id:
  - __defaults__
us_content_id:
  - __defaults__
us_migration_version:
  - "6.0"
image: /wp-content/uploads/2018/01/show-hide-featured.gif
categories:
  - Android
  - Keyboard
---
Now it&#8217;s time for the final part of my Android Keyboard series, and one of the most challenging parts of UI development: showing and hiding the keyboard. What seems like a simple task can often become very complicated, but I&#8217;ll show some examples of how to get the behavior you want, and explain some of the weirdness we see along the way.

<img class="alignnone size-full wp-image-436" src="https://i1.wp.com/theokanning.com/////wp-content/uploads/2018/01/show-and-hide.gif?resize=500%2C889&#038;ssl=1" alt="" width="500" height="889" data-recalc-dims="1" /> 

## Input Method Manager

At the heart of all of this is the [InputMethodManager](https://developer.android.com/reference/android/view/inputmethod/InputMethodManager.html), Android&#8217;s one-stop-shop for any programmatic keyboard features. InputMethodManager is responsible for the interaction between you app and whatever InputMethod (keyboard) the user&#8217;s phone is configured to use. Most of the communication to handle things like key presses, IME Actions, and switching text fields is handle automatically, so I won&#8217;t talk about it here.

We&#8217;re only interested in two methods right now:

  * showSoftInput(View view, int flags)
  * hideSoftInputFromWindow(IBinder windowToken, int flags)

Those two will cover 99% of your keyboard needs, so let&#8217;s look into them a bit more.

## Showing the keyboard

As you might have guessed, `InputMethodManager#showSoftInput` is for showing the soft keyboard. It takes in a View and an integer representing a set of bit flags. The View should be the EditText that you want the user to start typing in. Note that the keyboard won&#8217;t appear unless that EditText is currently in focus!

The integer parameter allows you to specify whether the keyboard is being shown implicitly, or as a result of user action. Setting it to 0 works fine.

<pre class="brush: java; title: ; notranslate" title="">private fun showKeyboard(view : View) {
    val inputMethodManager = activity!!.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
    view.requestFocus()
    inputMethodManager.showSoftInput(view, 0)
}
</pre>

There are three steps here:

  * Get the InputMethodManager from the Activity
  * Make sure that the specified view has focus, or else the keyboard won&#8217;t appear
  * Call `showSoftInput` with the view and all flags set to 0

And that&#8217;s it!

## Hiding the Keyboard

Hiding the keyboard follows a pretty similar pattern. `InputMethodManager#hideSoftInputFromWindow` takes an IBinder and another set of integer flags.

You might think that Android would just let you close the keyboard, but you have to provide an IBinder from an active View for security purposes. IBinder tokens are unique across the entire operating system, and Android uses them to make sure apps can&#8217;t close a keyboard that&#8217;s being used by another process.

Just like with showing the keyboard, the set of integer flags allows you to tell the operating system if the keyboard is being closed implicitly or by the user. This can safely be set to 0.

<pre class="brush: java; title: ; notranslate" title="">private fun hideKeyboard(view : View) {
    val inputMethodManager = activity!!.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
    inputMethodManager.hideSoftInputFromWindow(view.windowToken, 0)
}
</pre>

Here we get the IBinder by calling `view.getWindowToken()` on any active view.

That&#8217;s all you have to do! I hope you got a lot out of this keyboard series, and now it&#8217;s time to add these great features to your own apps.
