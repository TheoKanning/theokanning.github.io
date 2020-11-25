---
title: Crossword Generator
date: 2020-11-24T18:22:53-06:00
author: theo
layout: post
class: post-template
permalink: /crossword-generator/
excerpt: A crossword UI and generator written in Python
tags:
  - python
---

Crosswords have been a great distraction this year, and I decided to spend even more time on them by making my own crossword creation tool.
Its suggestions make grid filling much easier, and I also made a generator to fill in grids automatically.

Code on [Github](https://github.com/TheoKanning/crossword)

## GUI Tool
The PyQt5 GUI allows the user to create a crossword grid and add words.
It supports across/down text entry, automatic suggestions, and radial block symmetry.

{% include image.html
url="/assets/images/2020/crossword/ui.png"
%}

## Dictionary
The automatic suggestions come from the dictionary at [xwordinfo.com](xwordinfo.com).
Since it's not free, I can't include it in the repo, but it's a single text file formatted like this:

```
aaa;50
aaaa;25
aaabattery;60
aaabonds;60
aaacell;50
...
```

Each line is a word and its score. Better words have a higher score.

### Dictionary Speed
The crossword dictionary has over 200,000 words, so a regex search over the entire file takes 30ms, good enough for the UI but not fast enough for generation.

With a couple simple tricks I increased the speed from 30 to 1,800 searches per second.

- Split the dictionary based on word length
- Store dictionaries in memory instead of reading from the file each time
- Add `@lru_cache` decorator to save the last 32 searches

## Automatic Generation
I've always liked optimization problems, so I created an automatic crossword generator to fill in a grid using words in the dictionary.

### Backtracking Algorithm
The backtracking algorithm solves contraint optimization problems such as the 8 queens puzzle, sudokus, or crosswords.
It works by guessing and then backtracking when it finds a contradiction.


Here are the basic steps:

{% highlight python %}
def search(grid):

    if grid.is_complete():
        # every square is filled in, so return True
        return True

    target = get_target_square(grid)
    words = get_valid_words(grid, target, dictionary)

    for word in words:
        grid.set_word(word, target)
        success = search(grid)

        if success:
            return True
        else:
            # continue to the next word
            grid.remove_word(word, target)

# none of the words worked, so backtrack one level and try again
return False
{% endhighlight %}

This algorithm will eventually try every word in every position, so it will always find a solution if one exists.
However, a brute force search will take a prohibitive amount of time.

Fortunately, there's a near-infinite number of valid solutions, and the backtracking algorithm works great as long as it finds contradictions quickly.

### Picking a Target
First the backtracking algorithm has to choose a target square and direction.
Rather than searching randomly across the grid, the algorithm should focus on a small area and finish it before moving on.
Bad target selection can lead to very inefficient search trees!

For example, if the generator partially fills out the top left, then finishes the top right, then returns to the top left
and immediately finds a contradiction, it will have to fill in the top right each time it tries a new word on the left.
It's much more efficient to find contradictions earlier.

This is my target sorting logic:
- prefer targets that are almost filled in
- take the top ten targets resort them by how many words would fit in them, fewest first

Once I added the top 10 searching, the generator filled a 15x15 grid in 200 nodes instead of 150,000!

### Choosing a word
Compared to choosing a target, picking which word to guess is relatively simple.
- search dictionary for all compatible words
- filter out words that would cause an immediate contradiction somewhere
- take them in order because they're sorted by score

## Next Steps
The generator can fill in crossword grids easily, but it can't replicate the creativity and fun of hand-made crosswords.
Ideally, I could add the generator to the UI tool so that it can fill in tricky corners for me, and I'll handle the rest.

