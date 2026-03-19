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

# Lesson 7: Introduction to functions

<hr>

+++

A **function** is a key element in writing programs. You can think of a function in a computing language in much the same way you think of a mathematical function. The function takes in **arguments**, performs some operation based on the identities of the arguments, and then **returns** a result. For example, the mathematical function

\begin{align}
f(x, y) = \frac{x}{y}
\end{align}

takes arguments $x$ and $y$ and then returns the ratio between the two, $x/y$. In this lesson, we will learn how to construct functions in Python.

+++

## Basic function syntax

For our first example, we will translate the above function into Python. A function is **defined** using the `def` keyword. This is best seen by example.

```{code-cell} ipython3
def ratio(x, y):
    """The ratio of `x` to `y`."""
    return x / y
```

Following the `def` keyword is a **function signature** which indicates the function's name and its arguments. Just like in mathematics, the arguments are separated by commas and enclosed in parentheses. The indentation following the `def` line specifies what is part of the function. As soon as the indentation goes to the left again, aligned with `def`, the contents of the functions are complete.

Immediately following the function definition is the **doc string** (short for documentation string), a brief description of the function. The first string after the function definition is always defined as the doc string. Usually, it is in triple quotes, as doc strings often span multiple lines.

Doc strings are more than just comments for your code, the doc string is what is returned by the native python function `help()` when someone is looking to learn more about your function. For example:

```{code-cell} ipython3
help(ratio)
```

They are also printed out when you use the `?` in a Jupyter notebook or JupyterLab console.

```{code-cell} ipython3
ratio?
```

You are free to type whatever you like in doc strings, or even omit them, but you should always have a doc string with some information about what your function is doing. True, this example of a function is kind of silly, since it is easier to type `x / y` than `ratio(x, y)`, but it is still good form to have a doc string. This is worth saying explicitly.

<div style="color: dodgerblue; text-align: center; font-weight: bold;">

All functions should have doc strings.
    
</div>

In the next line of the function, we see a **return** keyword. Whatever is after the **return** statement is, you guessed it, returned by the function. Any code after the **return** is *not* executed because the function has already returned!

+++

### Calling a function

Now that we have defined our function, we can **call** it.

```{code-cell} ipython3
ratio(5, 4)
```

```{code-cell} ipython3
ratio(4, 2)
```

```{code-cell} ipython3
ratio(90.0, 8.4)
```

In each case, the function returns a `float` with the ratio of its arguments.

+++

### Functions need not have arguments

A function does not need arguments. As a silly example, let's consider a function that just returns 42 every time. Of course, it does not matter what its arguments are, so we can define a function without arguments.

```{code-cell} ipython3
def answer_to_the_ultimate_question_of_life_the_universe_and_everything():
    """Simpler program than Deep Thought's, I bet."""
    return 42
```

We still needed the open and closed parentheses at the end of the function name. Similarly, even though it has no arguments, we still have to call it with parentheses.

```{code-cell} ipython3
answer_to_the_ultimate_question_of_life_the_universe_and_everything()
```

### Functions need not return anything

Just like they do not necessarily need arguments, functions also do not need to return anything. If a function does not have a `return` statement (or it is never encountered in the execution of the function), the function runs to completion and returns `None` by default. `None` is a special Python keyword which basically means "nothing." For example, a function could simply print something to the screen.

```{code-cell} ipython3
def think_too_much():
    """Express Caesar's skepticism about Cassius"""
    print("""Yond Cassius has a lean and hungry look,
He thinks too much; such men are dangerous.""")
```

We call this function as all others, but we can show that the result it returns is `None`.

```{code-cell} ipython3
return_val = think_too_much()

# Print a blank line
print()

# Print the return value
print(return_val)
```

## Built-in functions in Python

The Python programming language has several built-in functions. We have already encountered `print()`, `id()`, `ord()`, `len()`, `range()`, `enumerate()`, `zip()`, and `reversed()`, in addition to type conversions such as `list()`.  The complete set of **built-in functions** can be found [here](https://docs.python.org/3/library/functions.html). A word of warning about these functions and naming your own.

<div style="color: dodgerblue; text-align: center; font-weight: bold;">

Never define a function or variable with the same name as a built-in function.
    
</div>

Additionally, Python has **keywords** (such as `def`, `for`, `in`, `if`, `True`, `None`, etc.), many of which we have already encountered. A complete list of them is [here](https://docs.python.org/3/reference/lexical_analysis.html#keywords). The interpreter will throw an error if you try to define a function or variable with the same name as a keyword.

+++

## An example function: reverse complement

Let's write a function that does not do something so trivial as computing ratios or giving us the Answer to the Ultimate Question of Life, the Universe, and Everything. We'll write a function to compute the reverse complement of a sequence of DNA. Within the function, we'll use some of our newly acquired iteration skills.

```{code-cell} ipython3
def complement_base(base):
    """Returns the Watson-Crick complement of a base."""
    if base in 'Aa':
        return 'T'
    elif base in 'Tt':
        return 'A'
    elif base in 'Gg':
        return 'C'
    else:
        return 'G'


def reverse_complement(seq):
    """Compute reverse complement of a sequence."""
    # Initialize reverse complement
    rev_seq = ''
    
    # Loop through and populate list with reverse complement
    for base in reversed(seq):
        rev_seq += complement_base(base)
        
    return rev_seq
```

Note that we do not have error checking here, which we should definitely do, but we'll cover that in a future lesson. For now, let's test it to see if it works.

```{code-cell} ipython3
reverse_complement('GCAGTTGCA')
```

It looks good, but we might want to write yet another function to display the template strand (from 5$'$ to 3$'$) above its reverse complement (from 3$'$ to 5$'$). This makes it easier to verify.

```{code-cell} ipython3
def display_complements(seq):
    """Print sequence above its reverse complement."""
    # Compute the reverse complement
    rev_comp = reverse_complement(seq)
    
    # Print template
    print(seq)
    
    # Print "base pairs"
    for base in seq:
        print('|', end='')
    
    # Print final newline character after base pairs
    print()
            
    # Print reverse complement
    for base in reversed(rev_comp):
        print(base, end='')
        
    # Print final newline character
    print()
```

Let's call this function and display the input sequence and the reverse complement returned by the function.

```{code-cell} ipython3
seq = 'GCAGTTGCA'
display_complements(seq)
```

Ok, now it's clear that the result looks good! This example demonstrates an important programming principle regarding functions. We used three functions to compute and display the reverse complement.

1. `complement_base()` gives the Watson-Crick complement of a given base.
2. `reverse_complement()` computes the reverse complement.
3. `display_complements()` displays the sequence and the reverse complement.

We could very well have written a single function to compute the reverse complement with the `if` statements included within the `for` loop.  Instead, we split this larger operation up into smaller functions. This is an example of **modular** programming, in which the desired functionality is split up into small, independent, interchangeable modules. This is a very, very important concept.

<div style="color: dodgerblue; text-align: center; font-weight: bold;">

Write small functions that do single, simple tasks.
    
</div>

+++

## Pause and think about testing

Let's pause for a moment and think about what the `complement_base()` and `reverse_complement()` functions do. They do a well-defined operation on string inputs. If we're doing some bioinformatics, we might use these functions over and over again. We should therefore thoroughly **test** the functions. For example, we should test that `reverse_complement('GCAGTTGCA')` returns `'TGCAACTGC'`. For now, we will proceed without writing tests, but we will soon cover **test-driven development**, in which your functions are built around tests. For now, I will tell you this: **If your functions are not thoroughly tested, you are entering a world of pain. A world of pain.** Test your functions.

+++

## Keyword arguments

Now let's say that instead of the reverse DNA complement, we want the reverse RNA complement. We could re-write the `complement_base()` function to do this. Better yet, let's modify it.

```{code-cell} ipython3
def complement_base(base, material='DNA'):
    """Returns the Watson-Crick complement of a base."""
    if base in 'Aa':
        if material == 'DNA':
            return 'T'
        elif material == 'RNA':
            return 'U'
    elif base in 'TtUu':
        return 'A'
    elif base in 'Gg':
        return 'C'
    else:
        return 'G'
    
def reverse_complement(seq, material='DNA'):
    """Compute reverse complement of a sequence."""
    # Initialize reverse complement
    rev_seq = ''
    
    # Loop through and populate list with reverse complement
    for base in reversed(seq):
        rev_seq += complement_base(base, material=material)
        
    return rev_seq
```

We have added a **named keyword argument**, also known as a **named kwarg**. The syntax for a named kwarg is

    kwarg_name=default_value
    
in the `def` clause of the function definition. In this case, we say that the default material is DNA, but we could call the function with another material (RNA). Conveniently, when you call the function and omit the kwargs, they take on the default value within the function. So, if we wanted to use the default material of DNA, we don't have to do anything different in the function call.

```{code-cell} ipython3
reverse_complement('GCAGTTGCA')
```

But, if we want RNA, we can use the kwarg. We use the same syntax to call it that we did when defining it.

```{code-cell} ipython3
reverse_complement('GCAGTTGCA', material='RNA')
```

## Calling a function with a splat

Python offers another convenient way to call functions. Say a function takes three arguments, `a`, `b`, and `c`, taken to be the sides of a triangle, and determines whether or not the triangle is a right triangle. I.e., it checks to see if $a^2 + b^2 = c^2$.

```{code-cell} ipython3
def is_almost_right(a, b, c):
    """
    Checks to see if a triangle with side lengths
    `a`, `b`, and `c` is right.
    """
    # Use sorted(), which gives a sorted list
    a, b, c = sorted([a, b, c])
    
    # Check to see if it is almost a right triangle
    if abs(a**2 + b**2 - c**2) < 1e-12:
        return True
    else:
        return False
```

Remember our warning from before: never use equality checks with `float`s. We therefore just check to see if the Pythagorean theorem *almost* holds. The function works as expected.

```{code-cell} ipython3
is_almost_right(13, 5, 12)
```

```{code-cell} ipython3
is_almost_right(1, 1, 1.4)
```

Now, let's say we had a tuple with the triangle side lengths in it.

```{code-cell} ipython3
side_lengths = (13, 5, 12)
```

We can pass these all in separately by splitting the tuple but putting a `*` in front of it. A `*` before a tuple used in this way is referred an **unpacking operator**, and is referred to by some programmers as a "splat."

```{code-cell} ipython3
is_almost_right(*side_lengths)
```

This can be very convenient, and we will definitely use this feature later in the bootcamp when we do some string formatting.

+++

## Anonymous (a.k.a. lambda) functions

So far, we have written functions using a `def` statement, followed by an indented block of code defining what will be executed when the function is called. Sometimes the functions are very short, like the `ratio()` function at the beginning of this lesson. We might wish to more succinctly define a function like this. Python’s `lambda` keyword enables this. As an example, let's look at how we could define the `ratio()` function from before.

```{code-cell} ipython3
f = lambda x, y: x / y

f(3, 5)
```

The syntax for defining an anonymous function, which must be on one line, is as follows.

1. The keyword `lambda`.
2. The arguments of the anonymous function, separated by commas.
3. An expression that is the return value of the function.

You may be thinking that anonymous functions run contrary to the idea that all functions should have doc strings. You're right. Anonymous functions are typically only used when another function requires a function as an argument. In the `is_almost_right()` function above, we employed the `sorted()` function is used to sort a list. The `sorted()` function takes a `key` keyword argument that gives a function that is applied to each entry in the list and then the values returned by that function are used in the sorting. As an example, we can sort a list of names of goalscorers for LAFC in [the epic 2022 MLS Cup final](https://www.youtube.com/watch?v=WbeVQI5mPYk).

```{code-cell} ipython3
sorted(['Kellyn Acosta', 'Jesus Murillo', 'Gareth Bale'])
```

This sorted by their first names, but we want to sort for their last names. As we will learn in the [next lesson on string methods](l08_string_methods.ipynb), we can find the index of a space in a string using `my_string.find(' ')`, so that the letter at the start of a last name for a player with string `x` is `x[x.find(' ')+1]`. We can use a lambda function to give this as the key and get a nicely sorted list.

```{code-cell} ipython3
sorted(['Kellyn Acosta', 'Jesus Murillo', 'Gareth Bale'], key=lambda x: x[x.find(' ')+1])
```

## Computing environment

```{code-cell} ipython3
:tags: [hide-input]

%load_ext watermark
%watermark -v -p jupyterlab
```
