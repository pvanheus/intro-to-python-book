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
    - name: Justin Bois
    - name: Peter van Heusden  
---

# Lesson 8: String methods

<hr>

+++

In the last lesson, we wrote some functions to parse strings and compute things like reverse complements. This helped us practice using functions and the iteration skills we learned.

You might think, "Hey, replacing characters in strings sounds like it may be pretty common." You would be right. You might also think, "I bet someone, possibly someone who is a really good programmer, already has written code to do this." You would again be right.

For common tasks, there are often already methods written by someone smart, and working with strings is no different. In this lesson, we will explore some of the string processing tools that come with Python's standard library.

+++

## Indexing and slicing of strings

Before getting into string methods, we pause to note that indexing and slicing of strings works just as it does for lists and tuples.

```{code-cell} ipython3
my_str = 'The Dude abides.'

print(my_str[5])
print(my_str[:6])
print(my_str[::2])
print(my_str[::-1])
```

## Revisiting previous examples using string methods

We'll start by revisiting some of the examples we've seen so far.

+++

### Computing GC content

If you remember from the [iteration lesson](l06_iteration.ipynb), we started by computing the GC content of a nucleic acid sequence. We counted the occurrences of `'G'` and `'C'` in the string using a **`for`** loop. We can use the `count()` string method do to this.

```{code-cell} ipython3
# Define sequence
seq = 'GACAGACUCCAUGCACGUGGGUAUCAUGUC'

# Count G's and C's
seq.count('G') + seq.count('C')
```

The `seq.count()` method enabled us to count the number times `G` and `C` occurred in the string `seq`. This notation is new. We have a variable, followed by a dot (`.`), and then a function. These functions are called **methods** in the language of object-oriented programming (OOP). If you have a string `my_str`, and you want to execute one of Python's built-in string methods on it, the syntax is

    my_str.string_method_of_choice(*args)
    
In general, the `count` method gives the number of times a substring appears in a string. We can learn more about its behavior by playing with it.

```{code-cell} ipython3
# Substrings of more than one characater
seq.count('GAC')
```

```{code-cell} ipython3
# Substrings cannot overlap
'AAAAAAA'.count('AA')
```

```{code-cell} ipython3
# Something that's not there.
seq.count('nonsense')
```

### Finding the index of a start codon

Another task in the [iteration lesson](l06_iteration.ipynb) was to find the index of the start codon in an RNA sequence. Let's do it with another string method.

```{code-cell} ipython3
seq.find('AUG')
```

Wow, that was easy. The `find()` method gives the index where the substring argument *first* appears. But, what if a substring is not in the string?

```{code-cell} ipython3
seq.find('nonsense')
```

In this case, `find()` returns `-1`. This is not to be interpreted as index `-1`! `find()` always returns positive indices if it finds a substring. Note that you should not use `find()` to *test* if a substring is present. Use the `in` operator we already learned about.

```{code-cell} ipython3
'AUG' in seq
```

### Finding the last index of a substring

Let's say we wanted to find the last instance of the start codon. We basically want to search from the right. This is exactly what the `rfind()` method does.

```{code-cell} ipython3
seq.rfind('AUG')
```

### Finding the complementary base

In our [lesson on functions](l07_intro_to_functions.ipynb), we wrote a function to compute a complementary base comparing against both the capital and lowercase letter. Here is that function implemented with some handy string methods.

```{code-cell} ipython3
def complement_base(base):
    """Returns the Watson-Crick complement of a base."""
    # Convert to lowercase
    base = base.lower()
    
    if base == 'a':
        return 'T'
    elif base == 't':
        return 'A'
    elif base == 'g':
        return 'C'
    else:
        return 'G'
```

We were able to avoid all the "`base in 'Tt'`"-style operations by just converting the base to lowercase using the `lower()` method. In general, the `lower()` method takes a string and converts any capital letters to lower case.  The `upper()` function works analogously.

```{code-cell} ipython3
'LeBron James'.lower()
```

```{code-cell} ipython3
'Make me aLl caPS.'.upper()
```

### Converting RNA to DNA

We also updated the complementary base function to account for RNA or DNA. Perhaps an easier way is just to replace all `U`s in an RNA sequence with `T`s to get a DNA sequence. The `replace()` method makes this easy.

```{code-cell} ipython3
seq.replace('U', 'T')
```

Note that `seq` did not change. Remember, strings are immutable, so the `replace()` method *returns* a new string, as does `lower()`, `upper()`, and any other string method that returns a string. So, the characters stored in the variable `seq` are unchanged.

```{code-cell} ipython3
seq
```

## The join() method

One of the most useful string methods is the `join()` method. Say we have a list of words that we want to craft into a sentence.

```{code-cell} ipython3
word_tuple = ('The', 'Dude', 'abides.')
```

Now, we would like to concatenate them into a single string. (This is sort of like the opposite of taking a string and making a list of its characters by doing a `list()` type conversion.) We need to know what we want to put between each word. In this case, we want a space. Here's the nifty syntax to do that.

```{code-cell} ipython3
' '.join(word_tuple)
```

We now have a single string with the elements of the tuple, separated by spaces. The string before the dot (`.`) specifies what goes between the strings in the list or tuple (or other iterable). If we wanted "` * `" between each word, we could do that, too.

```{code-cell} ipython3
' * '.join(word_tuple)
```

## The format() method

The `format()` method is very powerful. We not go over all use cases here, but I'll show you what I think is most intuitive and commonly used. Again, this is best learned by example.

```{code-cell} ipython3
my_str = """
Let's do a Mad Lib!
During this bootcamp, I feel {adjective}.
The instructors give us {plural_noun}.
""".format(adjective='truculent', plural_noun='haircuts')

print(my_str)
```

See the pattern? Given a string, the `format()` method takes kwargs that are themselves strings. Within the string, the name of the kwargs are given in braces. Then, the arguments in the `format()` method inserts the strings at the places delimited by braces.

Now, what if we want to insert a number into a string? We could convert it to a string, but we should instead use **string conversions**. These are short directives that specify how the number should be represented in a string.  A complete list is [here](https://docs.python.org/3/library/stdtypes.html#printf-style-bytes-formatting). The table below shows some that are commonly used.

|conversion|description|
|:----------:|-----------|
|`d`| integer|
|`04d`| integer with four digits, possibly with leading zeros|
|`f`| float, default to six digits after decimal|
|`.8f`| float with 8 digits after the decimal|
|`e`| scientific notation, default to six digits after decimal|
|`.16e`| scientific notation with 16 digits after the decimal|
|`s`| display as a string|

Below are examples of all of these.

```{code-cell} ipython3
print('There are {n:d} states in the US.'.format(n=50))
print('Your file number is {n:d}.'.format(n=23))
print('π is approximately {pi:f}.'.format(pi=3.14))
print('e is approximately {e:.8f}.'.format(e=2.7182818284590451))
print("Avogadro's number is approximately {N_A:e}.".format(N_A=6.022e23))
print('ε₀ is approximately {eps_0:.16e} F/m.'.format(eps_0=8.854187817e-12))
print('That {thing:s} really tied the room together.'.format(thing='rug'))
```

Note the syntax. In the braces, we specify the name of the kwarg, and then we put a colon followed by the string conversion. Note also that I used double quotes on the outside of the string containing Avogadro's number so that I could include an apostrophe in the string. Finally, note that we got a subscript zero using the [Unicode](https://en.wikipedia.org/wiki/Unicode) character, `₀`.

+++

## f-strings

**f-strings** are strings that are prefixed with an `f` or `F` that allow convenient insertion of entries into strings. Here are some examples. 

```{code-cell} ipython3
n_states = 50
file_number = 23
pi = 3.14
e = 2.7182818284590451
N_A = 6.022e23
eps_0=8.854187817e-12
thing = 'rug'

print(f'There are {n_states} states in the US.')
print(f'Your file number is {file_number}.')
print(f'π is approximately {pi}.')
print(f'e is approximately {e:.8f}.')
print(f"Avogadro's number is approximately {N_A}.")
print(f'ε₀ is approximately {eps_0} F/m.')
print(f'That {thing} really tied the room together.')
```

## There are many more string methods

You can find a complete list of string methods from [the Python doc pages](https://docs.python.org/3/library/stdtypes.html#string-methods).  Various methods will come in handy when parsing strings going forward.

+++

## Computing environment

```{code-cell} ipython3
:tags: [hide-input]

%load_ext watermark
%watermark -v -p jupyterlab
```
