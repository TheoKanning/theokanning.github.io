---
title: 'Android Keyboart Part 2: Input Method Actions'
date: 2018-01-26T20:30:21+00:00
author: theo
layout: post
class: post-template
permalink: /keyboard-part-2-input-method-actions/
tags:
  - android
---
On to the second important part of the Android keyboard: Input Method Actions! Input Method Actions, or IME Actions as they’re sometimes called, are a way to change the effect of the carriage return button on the keyboard.

{% include image.html
url="https://i1.wp.com/theokanning.com/////wp-content/uploads/2018/01/input-method-actions-1.gif?resize=500%2C889&ssl=1" %}
For example, if you’re making a search field, you would change the carriage return button to a search symbol to let the user know what will happen when the button is pressed. Here’s a quick example of some button options.

The blue action button on the keyboard changes each time and allows the user to do different things. Setting Input Method Actions is easy, let’s give it a try!

## How to Set Input Method Actions
Just like setting the Input Type back in part 1, setting the input method action is done through xml.
Note that `android:inputType` often has to be set as well for these to function correctly. Don’t ask me why.

{% highlight xml %}
<EditText
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:hint="Search"
    android:imeOptions="actionSearch"
    android:inputType="text"
    />
{% endhighlight %}
The `"actionSearch"` option is what tells android to display a search icon on the keyboard. Not only is this helpful for the user, it also gives you more control over how to handle button clicks.

## Responding to Input Method Actions
In order to respond to a button click on the keyboard, you must set an `OnEditorActionListener` on the `EditText` you wish to listen to.
The `OnEditorActionListener` has a single callback method, `onEditorAction`, that will fire each time the action button is pressed.

The method has three parameters: 
- `textView`: the view that receives the input action
- `actionId`: an integer that tells you which action was selected
- `KeyEvent`: an event enum that tells you if the user just pressed down, released, etc.

Here’s how to listen for IME Actions.

{% highlight kotlin %}
editText.setOnEditorActionListener(object : TextView.OnEditorActionListener {

    override fun onEditorAction(textView: TextView, actionId: Int, event: KeyEvent?): Boolean {
        when(actionId) {
            EditorInfo.IME_ACTION_SEARCH -> toast("Search Pressed")
            EditorInfo.IME_ACTION_DONE -> toast("Done Pressed")
        }
        return false // return true to consume event and prevent keyboard from disappearing
    }
})
{% endhighlight %}

Note that `onEditorAction` returns a `Boolean`. If this returns true, you’re telling Android that you’ve consumed the event, and it will not notify any other listeners or take other actions. If you return false, then pressing certain action buttons, like “search” or “done”, will automatically hide the keyboard.

## Summary
Input Method Actions are a little more complicated than Input Types, but they give you a large amount of control over how the user interacts with the keyboard.
Entering text is often frustrating, but using the correct input action can save your users time and make your app mor enjoyable.

Here’s a link to the full [documentation](https://developer.android.com/reference/android/widget/TextView#attr_android:imeOptions)
