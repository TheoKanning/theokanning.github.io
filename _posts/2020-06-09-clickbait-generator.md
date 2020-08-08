---
title: Clickbait Headline Generator
date: 2020-06-09T18:54:22+00.00
author: theo
layout: post
class: post-template
permalink: /clickbait-generator/
excerpt: As LSTM model that generates clickbait headlines
tags:
  - machine learning
---

Generating high-quality text with LSTMs is very difficult, but clickbait headlines are inherently low quality. An simple LSTM should have no trouble generating them!

Code on [Github](https://github.com/TheoKanning/clickbait-generator)


## Data
### Source
I used a database of clickbait headlines collected by the team behind [Stop Clickbait: Detecting and Preventing Clickbaits in Online News Media](https://github.com/bhargaviparanjape/clickbait)

The database contains 17,000 headlines from the following august publications:
- BuzzFeed
- Upworthy
- ViralNova
- Thatscoop
- Scoopwhoop
- ViralStories

### Preprocessing
In order to feed the data into the model, I read the entire 17,000 headline dataset as a single string and split it into 20-word samples.

## Model
My model was a two-layer LSTM with 256 units and 20% dropout.
I experimented with using GloVe embeddings, but I found that clickbait headlines have too many made up words that don't exist in GloVe.
Manually training embeddings gave much better results.

I made the actual model using tf2 and keras.

{% highlight python %}
def create_model(sample_length, vocab_size):
    input_layer = Input(shape=(sample_length,))
    
    m = Embedding(vocab_size, 10, input_length=sample_length)(input_layer)
    m = LSTM(256, dropout=0.2, return_sequences=True)(m)
    m = LSTM(256, dropout=0.2)(m)
    m = Dense(300, activation='relu')(m)
    m = Dropout(0.2)(m)
    m = Dense(vocab_size, activation='softmax')(m)
    
    model = Model(inputs=[input_layer], outputs=m)
    
    return model
{% endhighlight %}

## Results
See for yourself! Here are some of the best headlines it's generated so far:
- we know your zodiac sign based on your zodiac sign
- the 17 most important canadian celebrity moments of 2015
- here's how to make a vampire
- can you guess your favorite '90s movie based on your favorite kitten
- are you more a canadian or taylor swift or oprah

These could easily pass for headlines on any of the esteemed websites listed above.


## Next Steps
The easiest way to improve this would be to add more samples.
I couldn't find a bigger dataset online, but a simple web scraper would be able to get thousands more with only moderate effort.

## References
Inspired by Lars Eidnes' [blog post](https://larseidnes.com/2015/10/13/auto-generating-clickbait-with-recurrent-neural-networks/)  
"Stop Clickbait: Detecting and Preventing Clickbaits in Online News Media" [link](https://github.com/bhargaviparanjape/clickbait)  
Excellent RNN intro by Andrej Karpathy [link](http://karpathy.github.io/2015/05/21/rnn-effectiveness/)
