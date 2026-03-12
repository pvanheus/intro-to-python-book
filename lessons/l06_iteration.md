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

# Lesson 6: Iteration

<hr> 

+++

We often want a computer program to do a similar operation many times. For example, we may want to analyze many codons, one after another, and find the start and stop codons in order to determine the length of the open reading frame. Or, as a simpler example, we may wish to find the GC content of a specific sequence. We check each base to see if it is `G` or `C` and keep a count. Doing these repeated operations in a program is called **iteration**.

+++

## Introducing the for loop

The first method of iteration we will discuss is the **for loop**. As an example of its use, we compute the GC content of an RNA sequence.

```{code-cell} ipython3
# The sequence we want to analyze
seq = 'GACAGACUCCAUGCACGUGGGUAUCUGUC'

# Initialize GC counter
n_gc = 0

# Initialize sequence length
len_seq = 0

# Loop through sequence and count G's and C's
for base in seq:
    len_seq += 1
    if base in 'GCgc':
        n_gc += 1
        
# Divide to get GC content
n_gc / len_seq
```

Let's look carefully at what we did here. We took a string containing a sequence of nucleotides and then we did something for each character (base) in that string (nucleic acid sequence). A string is a ***sequence*** in the sense of the programming language as well; just like a list or tuple, the string is an ordered collection of characters.  (So as not to confuse between biological sequences and *sequences* as a part of the Python language, we will always write the latter in italics.)

Now, let's translate the new syntax in the above code to English.

**Python**: `for base in seq`:

**English**: for each character in the string whose variable name is `seq`, do the following, with that character taking the name `base`

This exposes a general way of doing things repeatedly in Python. For every item in a _sequence_, we do something. That something follows the `for` clause and is contained in an indentation block. When we do this, we say are "looping over a *sequence*." In the context of a `for` clause, the membership operator, `in`, means that we consider in order each item in the *sequence* or iterator (we'll talk about iterators in a moment).

Now, looking within the loop, the first thing we do is increment the length of the sequence. For each base we encounter in the loop, we add one to the sequence length. Makes sense!

Next, we have an `if` statement. We use the membership operator again. We ask if the current base is a `G` or a `C`. To be safe, we also included lower case characters in case the sequence was entered that way. If the base is a `G` or a `C`, we increment the counter of GC bases by one.

Finally, we get the fractional GC content by dividing the number of GC's by the total length of the sequence.

+++

### Aside: the len() function

Note in the last example that we determined the length of the RNA sequence by iterating the `len_seq` counter within the `for` loop. This works, but Python has a built-in function (like `print()` is a built-in function) to compute the length of a string (or list, tuple, or other *sequence*). To find out the length of a *sequence*, simply use it as an argument to the `len()` function.

```{code-cell} ipython3
len(seq)
```

### Example and watchout: modifying a list

Let's look at another example of iterating through a list. Say we have a list of integers, and we want to change it by doubling each one. Let's just do it.

```{code-cell} ipython3
# We'll do one through 5
my_integers = [1, 2, 3, 4, 5]

# Double each one
for n in my_integers:
    n *= 2
    
# Check out the result
my_integers
```

Whoa! It didn't seem to double any of the integers! This is because `my_integers` was converted to an **iterator** in the `for` clause, and the iterator returns a *copy* of the item in a list, not a reference to it. Therefore, the `n` inside the `for` block is not a view into the original list, and doubling it does nothing meaningful.

We've seen how to change individual list elements with indexing:

```{code-cell} ipython3
# Don't do things this way
my_integers[0] *= 2
my_integers[1] *= 2
my_integers[2] *= 2
my_integers[3] *= 2
my_integers[4] *= 2

my_integers
```

But we'd obviously like a better way to do this, with less typing and without knowing ahead of time the length of the list. Let's look at a new concept that will help with this example.

+++

## Iterators

In the previous example, we iterated over a *sequence*. A sequence is one of many iterable objects, called **iterables**. Under the hood, the Python interpreter actually converts an iterable to an **iterator**. An iterator is a special object that gives values in succession. A major difference between a *sequence* and an iterator is that you cannot index an iterator. This seems like a trivial difference, but iterators make for more efficient computing than directly using a *sequence* with indexing.

We can explicitly convert a *sequence* to an iterator using the built-in function `iter()`, but we will not bother with that here because the Python interpreter automatically does this for you when you use a *sequence* in a loop. (This is incidentally why the previous example didn't work; when the list is converted to an iterator, a copy is made of each element so the original list is unchanged.)

Instead, we will now explore how we can create useful iterators using the `range()`, `enumerate()`, and `zip()` functions. I know we have not yet covered functions, but the syntax should not be so complicated that you cannot understand what these functions are doing, just like with the `print()` and `len()` functions.

+++

### The range() function

The `range()` function gives an iterable that enables counting. Let's look at an example.

```{code-cell} ipython3
for i in range(10):
    print(i, end='  ')
```

We see that `range(10)` gives us ten numbers, from `0` to `9`. As with indexing, `range()` inclusively starts at zero by default, and the ending is exclusive.

It turns out that the arguments of the `range()` function work much like indexing. If you have a single argument, you get that many integers, starting at 0 and incrementing by one. If you give two arguments, you start inclusively at the first and increment by one ending exclusively at the second argument. Finally, you can specify a stride with the third argument.

```{code-cell} ipython3
# Print numbers 2 through 9
for i in range(2, 10):
    print(i, end='  ')

# Print a newline
print()
    
# Print even numbers, 2 through 9
for i in range(2, 10, 2):
    print(i, end='     ')
```

It is often useful to make a list or tuple that has the same entries that a corresponding `range` object would have. We can do this with type conversion.

```{code-cell} ipython3
list(range(10))
```

We can use the `range()` function along with the `len()` function on lists to double the elements of our list from a bit ago:

```{code-cell} ipython3
my_integers = [1, 2, 3, 4, 5]

# Since len(my_integers) = 5, this takes i from 0 to 4, 
# exactly the indices of my_integers
for i in range(len(my_integers)):
    my_integers[i] *= 2
    
my_integers
```

This works, but there is an even better way to do this, with the next function.

+++

### The enumerate() function

Let's say we want to print the indices of all `G` bases in a DNA sequence. We could do this by modifying our previous program.

```{code-cell} ipython3
# Initialize GC counter
n_gc = 0

# Initialized sequence length
len_seq = 0

# Loop through sequence and print index of G's
for base in seq:
    if base in 'Gg':
        print(len_seq, end='  ')
    len_seq += 1
```

This is not so bad, but there is an easier way to do this. The `enumerate()` function gives an iterator that provides *both* the index and the item of a *sequence*. Again, this is best demonstrated in practice.

```{code-cell} ipython3
# Loop through sequence and print index of G's
for i, base in enumerate(seq):
    if base in 'Gg':
        print(i, end='  ')
```

The `enumerate()` function allowed us to use an index and a base at the same time. To make it more clear, we can print the index and base type for each base in the sequence.

```{code-cell} ipython3
# Print index and identity of bases
for i, base in enumerate(seq):
    print(i, base)
```

The `enumerate()` function is really useful and should be used in favor of just doing indexing. For example, many programmers, especially those first trained in lower-level languages, would write the above code similar to how we did the list doubling, with the `range()` and `len()` functions, but this is not good practice in Python.

Using `enumerate()`, the list doubling code looks like this:

```{code-cell} ipython3
my_integers = [1, 2, 3, 4, 5]

# Double each one
for i, _ in enumerate(my_integers):
    my_integers[i] *= 2
    
# Check out the result
my_integers
```

`enumerate()` is more generic and the overhead for returning a reference to an object isn't an issue. The `range(len())` construct will break on an object without support for `len()`. In addition, you are more likely to introduce bugs by imposing indexing on objects that are iterable but not unambiguously indexable. It is better to use the `enumerate()` function.

Note that we used the underscore, `_`, as a throwaway variable that we do not use. There is no rule for this, but this is generally accepted Python syntax and helps signal that you are not going to use the variable.

One last gotcha: if we tried to do a similar technique with a string, we get a `TypeError` because a string is immutable. We'll revisit examples like this in [lesson 8](l08_string_methods.ipynb).

```{code-cell} ipython3
:tags: [raises-exception]
# Try to convert capital G to lower g
for i, base in enumerate(seq):
    if base == 'G':
        seq[i] = 'g'
```

### The zip() function

The `zip()` function enables us to iterate over several iterables at once. In the example below we iterate over the jersey numbers, names, and positions of the LAFC players who scored in the 2022 MLS Cup Final.

```{code-cell} ipython3
names = ('Acosta', 'Murillo', 'Bale')
positions = ('MF', 'D', 'F')
numbers = (23, 3, 11)

for num, pos, name in zip(numbers, positions, names):
    print(num, name, pos)
```

### The reversed() function

This function is useful for giving an iterator that goes in the reverse direction. We'll see that this can be convenient in the next lesson. For now, let's pretend we're NASA and need to count down.

```{code-cell} ipython3
count_up = ('ignition', 1, 2, 3, 4, 5, 6, 7, 8 ,9, 10)

for count in reversed(count_up):
    print(count)
```

## The while loop

The `for` loop is very powerful and allows us to construct iterative calculations. When we use a `for` loop, we need to set up an iterator. A `while` loop, on the other hand, allows iteration until a conditional expression evaluates `False`.

As an example of a `while` loop, we will calculate the length of a sequence before hitting a start codon.

```{code-cell} ipython3
# Define start codon
start_codon = 'AUG'

# Initialize sequence index
i = 0

# Scan sequence until we hit the start codon
while seq[i:i+3] != start_codon:
    i += 1
    
# Show the result
print('The start codon starts at index', i)
```

Let's walk through the `while` loop. The value of `i` is changing with each iteration, being incremented by one. Each time we consider doing another iteration, the conditional is checked: do the next three bases match the start codon? We set up the conditional to evaluate to `True` when the bases are *not* the start codon, so the iteration continues. In other words, iteration continues in a `while` loop until the conditional returns `False`.

Notice that we sliced the string the same way we sliced lists and tuples. In the case of strings, a slice gives another string, i.e., a sequential collection of characters.

Let's try looking for another codon....  But, let's actually not do that. If you run the code below, it will run forever and nothing will get printed to the screen.

```python
# Define codon of interest
codon = 'GCC'

# Initialize sequence index
i = 0

# Scan sequence until we hit the start codon, but DON'T DO THIS!!!!!
while seq[i:i+3] != codon:
    i += 1
    
# Show the result
print('The codon starts at index', i)
```

+++

The reason this runs forever is that the conditional expression in the `while` statement never returns `False`. If we slice a string beyond the length of the string we get an empty string result.

```{code-cell} ipython3
seq[100:103]
```

This does not equal the codon we're interested in, so the **`while`** loop keeps going. Forever. This is called an **infinite loop**, and you definitely to not want these in your code! We can fix it by making a conditional that will evaluate to `False` if we reach the end of the string.

```{code-cell} ipython3
# Define codon of interest
codon = 'GCC'

# Initialize sequence index
i = 0

# Scan sequence until we hit the start codon or the end of the sequence
while seq[i:i+3] != codon and i < len(seq):
    i += 1
    
# Show the result
if i == len(seq):
    print('Codon not found in sequence.')
else:
    print('The codon starts at index', i)
```

### **for** vs **while**

Most anything that requires a loop can be done with either a `for` loop or a `while` loop, but there's a general rule of thumb for which type of loop to use. If you know how many times you have to do something (or if your program knows), use a `for` loop. If you don't know how many times the loop needs to run until you run it, use a `while` loop. For example, when we want to do something with each character in a string or each entry in a list, the program knows how long the sequence is and a `for` loop is more appropriate. In the previous examples, we don't know how long it will be before we hit the start codon; it depends on the sequence you put into the program. That makes it more suited to a `while` loop.

+++

## The **break** and **else** keywords

Iteration stops in a `for` loop when the iterator is exhausted. It stops in a `while` loop when the conditional evaluates to `False`. These is another way to stop iteration: the `break` keyword. Whenever `break` is encountered in a `for` or `while` loop, the iteration halts and execution continues outside the loop. As an example, we'll do the calculation above with a `for` loop with a `break` instead of a `while` loop.

```{code-cell} ipython3
# Define start codon
start_codon = 'AUG'

# Scan sequence until we hit the start codon
for i in range(len(seq)):
    if seq[i:i+3] == start_codon:
        print('The start codon starts at index', i)
        break
else:
    print('Codon not found in sequence.')
```

Notice that we have an `else` block after the `for` loop. In Python, `for` and `while` loops can have an `else` statement after the code block to be evaluated in the loop. The contents of the `else` block are evaluated if the loop completes *without* encountering a `break`.

+++

### A note about use of the word "codon"

The astute biologists among you will note that we have not really been using the word "codon" properly here. We are taking it to mean any three consecutive bases, but the more precise definition of a codon means that it is three consecutive bases that code for an amino acid. That means that for a three-base sequence to be a codon, it must be in-register with the start codon. You can read about how this distinction could lead to problems when we discuss **test-driven development** in auxiliary lessons.

+++

## Computing environment

```{code-cell} ipython3
:tags: [hide-input]

%load_ext watermark
%watermark -v -p jupyterlab
```
