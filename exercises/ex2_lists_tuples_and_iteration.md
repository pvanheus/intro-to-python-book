---
jupytext:
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.19.1
kernelspec:
  display_name: Python 3 (ipykernel)
  language: python
  name: python3
authors:
    - name: Peter van Heusden  
---

# Exercise 2: Lists and Tuples

<hr/>

+++

1. Imagine that you have a list of matching percentages, `matches = [0.6, 0.8, 0.94, 0.2, 0.4]`, write code to create a new list `good_matches` which only includes matches better than `0.7`.

2. The previous list didn't include the name of the sample that the match was associated with. Now imagine that the list consists of both sample names and their match percentiles.  Write code to return a new list `good_samples` that includes the sample names only where the match is better than `0.7`. Here is an example input list:

```{code-cell} python3
:tags: [remove-output]
sample_matches = [
  ['SAM1', 0.6],
  ['SAM2', 0.8],
  ['SAM3', 0.94],
  ['SAM4', 0.2],
  ['SAM5', 0.4]
  ]
```

 
3. Write a function `find_good_matches` that takes a match threshold (e.g. `0.7`) and a list like the one presented as `good_matches` and returns a list of tuples where each tuple contains the sample name and the percentage match for samples over match threshold.

4. Write a function `double_it` that takes a list of numbers and doubles each of them *in place*.

5. What effect does the `double_it` function have on the original list that you pass as a parameter to the `double_it` function? What is this effect called?

6. Write a function `double_it2` that takes a list of numbers and returns a new list of the numbers, doubled. Would `double_it2` work with a tuple of numbers? Would `double_it` work with a tuple? Why?
