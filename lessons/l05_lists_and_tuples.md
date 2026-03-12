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

# Lesson 5: Lists and tuples

<hr />

+++

In this tutorial, we will explore two important data types in Python, **lists** and **tuples**. They are both **sequences** of objects. Just like a string is a sequence (that is, an ordered collection) of characters, lists and tuples are sequences of arbitrary objects, called **items** or **elements**. They are a way to make a single object that contains many other objects. We will start our discussion with lists.

+++

## Lists

As usual, it is easiest to explore new topics by example. We'll start by creating a list.

+++

### List creation

We create lists by putting Python values or expressions inside square brackets, separated by commas. For example:

```{code-cell} ipython3
:tags: [raises-exception]
my_list_1 = [1, 2, 3, 4]
type(my_list_1)
```

We observe here that although the elements of the list are `int`s, the type of the list is `list`. Actually, any Python expression can be inside a list (including another list!):

```{code-cell} ipython3
my_list_2 = [1, 2.4, 'a string', ['a string in another list', 5]]
my_list_2
```

```{code-cell} ipython3
my_list_3 = [2+3, 5*3, 4**2]
my_list_3
```

`my_list_2` contains `int`s, a `float`, a `string` and another `list`. And our third list contains expressions that get evaluated when the list as a whole gets created.

We can also create a list by type conversion. For example, we can convert a string into a list of characters.

```{code-cell} ipython3
my_str = 'A string.'
list(my_str)
```

### List operators

Operators on lists behave much like operators on strings. The `+` operator on lists means list concatenation.

```{code-cell} ipython3
[1, 2, 3] + [4, 5, 6]
```

The `*` operator on lists means list replication and concatenation.

```{code-cell} ipython3
[1, 2, 3] * 3
```

#### Membership operators

Membership operators are used to determine if an item is in a list. The two membership operators are:

|English|operator|
|:-------|:----------:|
|is a member of | `in`|
|is not a member of | `not in`|

<br />

The result of the operator is `True` or `False`. Let's look at `my_list_2` again: 

```{code-cell} ipython3
my_list_2 = [1, 2.4, 'a string', ['a string in another list', 5]]
1 in my_list_2
```

```{code-cell} ipython3
['a string in another list', 5] in my_list_2
```

```{code-cell} ipython3
'a string in another list' in my_list_2
```

```{code-cell} ipython3
7 not in my_list_2
```

Importantly, we see that the string `'a string in another list'` is not in `my_list_2`. This is because that string itself is not one of the four items of `my_list_2`. The string `'a string in another list'` is in a *list* that is an item in `my_list_2`.

Now, these membership operators offer a great convenience for conditionals. Remember our example about stop codons?

```{code-cell} ipython3
codon = 'UGG'

if codon == 'AUG':
    print('This codon is the start codon.')
elif codon == 'UAA' or codon == 'UAG' or codon == 'UGA':
    print('This codon is a stop codon.')
else:
    print('This codon is neither a start nor stop codon.')
```

We can rewrite this much more cleanly, and with a lower chance of bugs, using a list and the `in` operator.

```{code-cell} ipython3
# Make a list of stop codons
stop_codons = ['UAA', 'UAG', 'UGA']

# Specify codon
codon = 'UGG'

# Check to see if it is a start or stop codon
if codon == 'AUG':
    print('This codon is the start codon.')
elif codon in stop_codons:
    print('This codon is a stop codon.')
else:
    print('This codon is neither a start nor stop codon.')
```

The simple expression

```python
codon in stop_codons
```
    
replaced the more verbose

```python
codon == 'UAA' or codon == 'UAG' or codon == 'UGA'
```

Much nicer!

+++

### List indexing

Imagine that we would like to access an item in a list. Because a list is ordered, we can ask for the first item, the second item, the *n*th item, the last item, etc. This is done using a bracket notation. We first write the name of our list and then enclosed in square brackets we write the location (index) of the desired element:

```{code-cell} ipython3
my_list = [1, 2.4, 'a string', ['a string in another list', 5]]

my_list[1]
```

Wait a minute! Shouldn't `my_list[1]` give the first item in the list? It seems to give the second. This is because **indexing in Python starts at zero**. This is very important[^zero-indexing]. 

[^zero-indexing]: Historical note: [Why Python uses 0-based indexing](http://python-history.blogspot.com/2013/10/why-python-uses-0-based-indexing.html) It is also worth reading [Edsgar Dijkstra](https://en.wikipedia.org/wiki/Edsger_W._Dijkstra)'s [thoughts on the matter](https://www.cs.utexas.edu/~EWD/ewd08xx/EWD831.PDF).

<div style="color: dodgerblue; text-align: center; font-weight: bold;">

Indexing in Python starts at zero.
    
</div>

Now that we know that, let's look at the items in the list.

```{code-cell} ipython3
print(my_list[0])
print(my_list[1])
print(my_list[2])
print(my_list[3])
```

We can also index the list that is within `my_list` by adding another set of brackets.

```{code-cell} ipython3
my_list[3][0]
```

So, now we have the basics of list indexing. There are more ways to specify items in a list. We'll look at some of these now, but in order to do it, it helps to have a simpler list. We'll therefore create a list that goes from zero to ten.

```{code-cell} ipython3
my_list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

my_list[4]
```

We already knew that would be the result. We can use negative indexing as well! This just means we start indexing from the last entry, starting at `-1`.

```{code-cell} ipython3
my_list[-1]
```

```{code-cell} ipython3
my_list[-3]
```

This is very convenient for indexing in reverse. Now make it more clear, here are the forward and backward indices for the list:

|Values|0|1|2|3|4|5|6|7|8|9|10|
|------|-:|-:|-:|-:|-:|-:|-:|-:|-:|-:|-:|
|Forward indices|0|1|2|3|4|5|6|7|8|9|10|
|Reverse indices|-11|-10|-9|-8|-7|-6|-5|-4|-3|-2|-1|

+++

### List slicing

Now, what if we want to pull out multiple items in a list, called **slicing**?  We can use colons (`:`) for that.

```{code-cell} ipython3
my_list[0:5]
```

We got elements `0` through `4`. When using the colon indexing, `my_list[i:j]`, we get items `i` through `j-1`.  I.e., the range is **inclusive of the first index and exclusive of the last**. If the slice's final index is larger than the length of the sequence, the slice ends at the last element.

```{code-cell} ipython3
my_list[3:1000]
```

Now, we can also use negative indices with colons.

```{code-cell} ipython3
my_list[0:-3]
```

Again, note that we only went to index `-4`. 

We can also specify a **stride**. The stride comes after a second colon. For example, if we only wanted the even numbers, we could do the following.

```{code-cell} ipython3
my_list[0::2]
```

Notice that we did not enter anything for the `end` value of the slice. If the end is left blank, the default is to include the entire string. Similarly, we can leave out the start index, as its default is zero.

```{code-cell} ipython3
my_list[::2]
```

So, in general, the indexing scheme is:

        my_list[start:end:stride]

* If there are no colons, a single element is returned.
* If there are any colons, we are slicing the list, and a list is returned.
* If there is one colon, `stride` is assumed to be 1.
* If `start` is not specified, it is assumed to be zero.
* If `end` is not specified, the interpreted assumed you want the entire list.
* If `stride` is not specified, it is assumed to be 1.

With this in hand, we do lots of crazy slicing. We can even use a negative stride, which results in reversing the list.

```{code-cell} ipython3
my_list[::-1]
```

Note that the meaning of the "start" and "end" index is a bit ambiguous when you have a negative stride. When the stride is negative, we still slice from start to end, but then reverse the order. 

Now, let's look at a few examples (inspired by [Brett Slatkin](http://www.onebigfluke.com)).

```{code-cell} ipython3
print(my_list[2::2])
print(my_list[2:-1:2])
print(my_list[-2::-2])
print(my_list[-2:2:-2])
print(my_list[2:2:-2])
```

You can see that it takes a lot of thought to understand what the slices actually are. So, here is some good advice: Do not use `start`, `end`, and `slice` all at the same time (even though you can). Do the stride first and then the slice, on separate lines. For example, if we wanted just the even numbers, but not the first and last (this was the `my_list[2:-1:2]` example we just did), we would do

```{code-cell} ipython3
# Extract evens
evens = my_list[::2]

# Cut off end values
evens_without_end_values = evens[1:-1]

evens_without_end_values
```

This is more verbose, but much easier to read and understand.

+++

## Mutability

Lists are **mutable**. That means that you can change their values without creating a new list. (You cannot change the data type or identity.) Let's see this by example.

```{code-cell} ipython3
my_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
my_list[3] = 'four'

my_list
```

The other data types we have encountered so far, `int`s, `float`s, and `str`s, are **immutable**. You cannot change their values without reassigning them. To see this, we'll use the `id()` function, which tells us where in memory that the variable is stored. (Note: this identity is unique to the Python interpreter, and should not be considered an actual physical address in memory.)

```{code-cell} ipython3
a = 689
print(id(a))

a = 690
print(id(a))
```

So, we see that the identity of `a`, an integer, changed when we tried to change its value.  So, we didn't actually change its value; we made a new variable.  With lists, though, this is not the case.

```{code-cell} ipython3
print(id(my_list))

my_list[0] = 'zero'
print(id(my_list))
```

It is still the same list! This is _very_ important to consider when we do assignments.  

+++

## Pitfall: Aliasing

**Aliasing** is a subtle issue which can come up when assigning lists to variables. Let's look at an example. We will make a list, then assign a new variable to the list (which we will momentarily erroneously think of as making a copy of the list) and then change a value of an entry in the "copied" list.

```{code-cell} ipython3
my_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
my_list_2 = my_list     # copy of my_list?
my_list_2[0] = 'a'

my_list_2
```

Now, let's look at our original list to see what it looks like.

```{code-cell} ipython3
my_list
```

So we see that assigning a list to a variable does not copy the list! Instead, you just get a new reference to the same value. This has the real potential to introduce a nasty bug that will bite you!  

There is a way we can avoid this problem by using list slices. If both the slice's starting index and the slice's ending index of a list are left out, the slice is a copy of the entire list in a new hunk of memory.

```{code-cell} ipython3
my_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
my_list_2 = my_list[:]
my_list_2[0] = 'a'

my_list_2
```

```{code-cell} ipython3
my_list
```

Another option is to use a data type that is very much like a list, except it is immutable.

+++

## Tuples

A **tuple** is just like a list, except it is immutable (basically a read-only list)[^more-about-tuples].  A tuple is created just like a list, except we use parentheses instead of brackets. The only watch-out is that a tuple with a single item needs to include a comma after the item. 

[^more-about-tuples]: Tuples are not *only* a "read-only list", as [this blog post](http://www.asmeurer.com/blog/posts/tuples/) explains, but as a beginner, understanding them as read-only lists is a good start.

```{code-cell} ipython3
my_tuple = (0,)

not_a_tuple = (0) # this is just the number 0 (normal use of parantheses)

type(my_tuple), type(not_a_tuple)
```

We can also create a tuple by doing a type conversion. We can convert our list to a tuple.

```{code-cell} ipython3
my_list = [1, 2.4, 'a string', ['a sting in another list', 5]]

my_tuple = tuple(my_list)

my_tuple
```

Note that the list within `my_list` did not get converted to a tuple. It is still a list, and it is mutable.

```{code-cell} ipython3
my_tuple[3][0] = 'a string in a list in a tuple'

my_tuple
```

However, if we try to change an item in a tuple, we get an error.

```{code-cell} ipython3
:tags: [raises-exception]
my_tuple[1] = 7
```

Even though the list within the tuple is mutable, we still cannot change the identity of that list.

```{code-cell} ipython3
:tags: [raises-exception]
my_tuple[3] = ['a', 'new', 'list']
```

### Slicing of tuples

Slicing of tuples is the same as lists, except a tuple is returned from the slicing operation, not a list.

```{code-cell} ipython3
my_tuple = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

# Reverse
my_tuple[::-1]
```

```{code-cell} ipython3
# Odd numbers
my_tuple[1::2]
```

### The **+** operator with tuples

As with lists we can concatenate tuples with the `+` operator.

```{code-cell} ipython3
my_tuple + (11, 12, 13, 14, 15)
```

### Membership operators with tuples

Membership operators work the same as with lists.

```{code-cell} ipython3
5 in my_tuple
```

```{code-cell} ipython3
'LeBron James' not in my_tuple
```

### Tuple unpacking

It is like a multiple assignment statement that is best seen through example.

```{code-cell} ipython3
my_tuple = (1, 2, 3)
(a, b, c) = my_tuple

a
```

```{code-cell} ipython3
b
```

```{code-cell} ipython3
c
```

This is useful when we want to return more than one value from a function and further using the values as stored in different variables. We will make use of this as the bootcamp goes on; we'll be writing functions in just a couple lessons!

Note that the parentheses are dispensable.

```{code-cell} ipython3
a, b, c = my_tuple

print(a, b, c)
```

## Wisdom on tuples and lists

At face, tuples and lists are very similar, differing essentially only in mutability. The differences are actually more profound, as described in the [aforementioned blog post](http://www.asmeurer.com/blog/posts/tuples/). We will make extensive use of them in our programs.  

"When should I use a tuple and when should I use a list?" you ask.  Here is my advice.

<div style="color: dodgerblue; text-align: center; font-weight: bold;">

Always use tuples instead of lists unless you need mutability.
    
</div>

This keeps you out of trouble. It is very easy to inadvertently change one list, and then another list (that is actually the same, but with a different variable name) gets mangled. That said, mutability is often very useful, so you can use it to make your list and adjust it as you need. However, after you have finalized your list, you should convert it to a tuple so it cannot get mangled. We'll come back to this later in the bootcamp.

So, I ask you, which is better?

```{code-cell} ipython3
# Should it be a list?
stop_codons = ['UAA', 'UAG', 'UGA']

# or a tuple?
stop_codons = ('UAA', 'UAG', 'UGA')
```

## Computing environment

```{code-cell} ipython3
:tags: [hide-input]

%load_ext watermark
%watermark -v -p jupyterlab
```
