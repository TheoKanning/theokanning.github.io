---
id: 425
title: 'Android Keyboard Part 3: TextInputLayout'
date: 2018-01-27T00:41:13+00:00
author: Theo Kanning
layout: post
guid: https://theokanning.com////?p=425
permalink: /keyboard-part-3-textinputlayout/
us_og_image:
  - ""
  - ""
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
us_header_id:
  - __defaults__
us_titlebar_id:
  - __defaults__
us_content_id:
  - __defaults__
us_migration_version:
  - "6.0"
image: /wp-content/uploads/2018/01/textinputlayout.gif
categories:
  - Android
  - Keyboard
---
By now you&#8217;ve probably noticed the fancy moving hints above the text views in the last two posts. How does that work? The answer is incredibly simple: the TextInputLayout. Added as part of the Design Support Library, TextInputLayout wraps a text field and gives you a lot of nice design options that are very easy to set up. Here&#8217;s an example of what they can do.

<img class="alignnone size-full wp-image-427" src="https://i0.wp.com/theokanning.com/////wp-content/uploads/2018/01/textinputlayout.gif?resize=500%2C333&#038;ssl=1" alt="" width="500" height="333" data-recalc-dims="1" /> 

There are a couple things going on here:

  * The password hint moves out of the way
  * The wrong password error message is much prettier than what you get with `editText.setError()`
  * The toggle changes to password visibility

All of these are built in feature of TextInputLayout! Let&#8217;s see how they work

## Setting up a TextInputLayout

Before you start, TextInputLayouts are part of this design support library, so add

<pre>implementation 'com.android.support:design:27.0.2'</pre>

to your build.gradle.

In order to use a TextInputLayout, simply wrap one around a [TextInputEditText](https://developer.android.com/reference/android/support/design/widget/TextInputEditText.html). TextInputEditText is a special type of EditText that&#8217;s designed to work well inside a TextInputLayout, and that&#8217;s why so much of this works. Here&#8217;s the xml I used to create the password field above.

<pre class="brush: xml; title: ; notranslate" title="">&lt;android.support.design.widget.TextInputLayout
    android:id="@+id/passwordWrapper"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:passwordToggleEnabled="true"
    &gt;

    &lt;android.support.design.widget.TextInputEditText
        android:id="@+id/password"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Password"
        android:imeOptions="actionDone"
        android:inputType="textPassword"
        /&gt;
&lt;/android.support.design.widget.TextInputLayout&gt;
</pre>

Because I&#8217;m using a TextInputEditText, the hint will automatically animate, no extra work required.

Take a look at the`app:passwordToggleEnabled="true"` line inside the TextInputLayout. That&#8217;s all you need to get a password toggle!

## Showing errors

Errors are displayed using `TextInputLayout#setError(String)`. Note that this is called on the _parent_ layout, not the text field. Here it is in Kotlin:

<pre class="brush: xml; title: ; notranslate" title="">private fun signIn() {
    if(password.text.toString() == "1234" ) {
        passwordWrapper.error = null
        Toast.makeText(context, "Success!", Toast.LENGTH_LONG).show()
    } else {
        passwordWrapper.error = "Wrong password"
    }
}
</pre>

Set the error text to display an error, or set it to null to hide it. That&#8217;s all!

TextInputLayouts are a great way to give your app a modern, professional feel, and they&#8217;re incredibly simple to use. Put them in all your apps!

&nbsp;