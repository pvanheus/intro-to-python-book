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

# Exercise 1: Testing your knowledge of simple types and conditionals

<hr/>

+++

The `FINDHOM` tool produces text output which we need to interpret using the concept of matches, queries and scores and statistics about matches. We'll deal with extracting information from it's output in later lessons but let's start with some use of Python types.

Let's start with this statement

```{code-cell} python3
:tags: [remove-output]
best_match_identity = 0.8
```

1. When you run this code in a notebook, do you expect to see output? Why or why not?

2. Imagine that you want to test to see if the identity of a new match (stored in `new_match`) is as good as the best match (i.e. `best_match_identity`). Would you use the following code? Explain.

```python
if new_match == best_match_identity:
    print('The new match is equally good as the best match')
```

3. If you wanted to see if your new match has better identify than the current match, could you use the following code? Explain why and why the answer might be different to the previous question

```python
if new_match > best_match_identify:
    print('The new match is better than the current best match')
```

4. If you wanted to test that two floating point values were equal up to 3 decimal points in Python, how could you do that? Think about `if`, `float` types and other ways of representing numbers.

5. Sandflies of the sub-family `Phlebotominae` are vectors for diseases such as leishmaniasis. In the "Old World", two genera of sandflies are typically found, _Phlebotomus_ and _Sergentomyia_. If the sample genus name is in a variable `sample_genus`, how would you test to see if it is one of these two genera or perhaps another, unknown, genus?

The answers to these exercises will be discussed in the next lesson.