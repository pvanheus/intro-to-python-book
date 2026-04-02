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

# Lesson 9: Dictionaries

<hr>

+++

## Mapping objects and dictionaries

A **mapping object** allows an arbitrary collection of objects to be indexed by an arbitrary collection of values. That's a mouthful. It is easier to understand instead by comparing to a sequence.

Let's take a sequence of two strings, say a tuple containing a first and last name.

    name = ('jeffrey', 'lebowski')

We are restricted on how we reference the sequence. I.e., the first name is `name[0]`, and the last name is `name[1]`. A mapping object could instead be indexed like `name['first name']` and `name['last name']`. You can imagine this would be very useful! A classic example in biology might be looking up amino acids that are coded for by given codons. E.g., you might want

    aa['CTT']

to give you `'Leucine'`.

Python's build-in mapping type is a **dictionary**. You might imagine that the Oxford English Dictionary might conveniently be stored as a dictionary (obviously). I.e., you would not want to store definitions that have to be referenced like

    oed[103829]
    
Rather, you would like to get definitions like this:

    oed['computer']

Importantly, note that in Python 3.5 and older **dictionaries have no sense of order**. In Python 3.6, dictionaries were stored in insertion order as an implementation improvement. In Python 3.7 and beyond, dictionaries are guaranteed to be ordered in the order in which their entries were created. It is therefore advisable be cautious when relying on ordering in dictionaries. For safety's sake, you may be better off assuming there is no sense of order.

+++

## Dictionary syntax

The syntax for creating a dictionary, as usual, is best seen through example.

```{code-cell} ipython3
my_dict = {'a': 6, 'b': 7, 'c': 27.6}
my_dict
```

A dictionary is created using curly braces (`{}`). Each entry has a **key**, followed by a colon, and then the value associated with the key. In the example above, the keys are all strings, which is the most common use case. Note that the items can be of any type; in the above example, they are `int`s and a `float`.

We could also create the dictionary using the built-in `dict()` function, which can take a tuple of 2-tuples, each one containing a key-value pair.

```{code-cell} ipython3
dict((('a', 6), ('b', 7), ('c', 27.6)))
```

Finally, we can make a dictionary with keyword arguments to the `dict()` function.

```{code-cell} ipython3
dict(a='yes', b='no', c='maybe')
```

We do not need to have strings as the keys.  In fact, any *immutable* object can be a key.

```{code-cell} ipython3
my_dict = {
    0: 'zero',
    1.7: [1, 2, 3],
    (5, 6, 'dummy string'): 3.14,
    'strings are immutable': 42
}

my_dict
```

However, mutable objects cannot be used as keys.

```{code-cell} ipython3
:tags: [raises-exception]
my_dict = {
    "immutable is ok": 1, 
    ["mutable", "not", "ok"]: 5
}
```

## Indexing dictionaries

As mentioned at the beginning of the lesson, we index dictionaries by key.

```{code-cell} ipython3
# Make a dictionary
my_dict = dict(a='yes', b='no', c='maybe')

# Pull out an entry
my_dict['b']
```

Because the indexing of dictionaries is by key and not by sequential integers, they cannot be sliced; they must be accessed element-by-element. (*Actually there are ways to slice keys of dictionaries using* `itertools`, *but we will not cover that.*)

+++

## Useful dictionaries in bioinformatics

It might be useful to quickly look up 3-letter amino acid codes. Dictionaries are particularly useful for this.

```{code-cell} ipython3
aa_dict = {
    "A": "Ala",
    "R": "Arg",
    "N": "Asn",
    "D": "Asp",
    "C": "Cys",
    "Q": "Gln",
    "E": "Glu",
    "G": "Gly",
    "H": "His",
    "I": "Ile",
    "L": "Leu",
    "K": "Lys",
    "M": "Met",
    "F": "Phe",
    "P": "Pro",
    "S": "Ser",
    "T": "Thr",
    "W": "Trp",
    "Y": "Tyr",
    "V": "Val",
}
```

Another useful dictionary would contain the set of codons and the amino acids they code for. This is built in the code below using the `zip()` function we learned before. To see the logic on how this is constructed, see the codon table [here](https://en.wikipedia.org/wiki/DNA_codon_table).

```{code-cell} ipython3
# The set of DNA bases
bases = ['T', 'C', 'A', 'G']

# Build list of codons
codon_list = []
for first_base in bases:
    for second_base in bases:
        for third_base in bases:
            codon_list += [first_base + second_base + third_base]

# The amino acids that are coded for (* = STOP codon)
amino_acids = 'FFLLSSSSYY**CC*WLLLLPPPPHHQQRRRRIIIMTTTTNNKKSSRRVVVVAAAADDEEGGGG'

# Build dictionary from tuple of 2-tuples (technically an iterator, but it works)
codons = dict(zip(codon_list, amino_acids))

# Show that we did it
print(codons)
```

+++

## A dictionary is an implementation of a hash table

It is useful to stop and think about how a dictionary works. Let's create a dictionary and look at where the values are stored in memory.

```{code-cell} ipython3
# Create dictionary
my_dict = {'a': 6, 'b': 7, 'c':12.6}

# Find where they are stored
print(id(my_dict))
print(id(my_dict['a']))
print(id(my_dict['b']))
print(id(my_dict['c']))
```

So, each entry in the dictionary is stored at a different location in memory. The dictionary itself also has its own address. So, when I index a dictionary with a key, how does the dictionary know which address in memory to use to fetch the value I am interested in?

Dictionaries use a **hash function** to do this. A hash function converts its input to an integer. For example, we can use Python's built-in hash function to convert the keys to integers.

```{code-cell} ipython3
hash('a'), hash('b'), hash('c')
```

Under the hood, Python then converts these integers to integers that could correspond to locations in memory. A collection of elements that can be indexed this way is called a **hash table**. This is a very common data structure in computing.  Wikipedia has a [pretty good discussion on them](https://en.wikipedia.org/wiki/Hash_table).

Given what you know about how dictionaries work, why do you think mutable objects are not acceptable as keys?

+++

## Dictionaries are mutable

Dictionaries are mutable. This means that they can be changed in place. For example, if we want to add an element to a dictionary, we use simple syntax.

```{code-cell} ipython3
# Remind ourselves what the dictionary is
print(my_dict)

# Add an entry
my_dict['d'] = 'Bootcamp is so much fun!'

# Look at dictionary again
print(my_dict)

# Change an entry
my_dict['a'] = 'I was not satisfied with entry a.'

# Look at it again
print(my_dict)
```

## Membership operators with dictionaries

The `in` and `not in` operators work with dictionaries, but both only query keys and _not_ values. We see this again by example.

```{code-cell} ipython3
# Make a fresh my_dict
my_dict = {'a': 1, 'b': 2, 'c': 3}

# in works with keys
'b' in my_dict, 'd' in my_dict, 'e' not in my_dict
```

```{code-cell} ipython3
# Try it with values
2 in my_dict
```

Yup!  We get `False`. Why? Because `2` is not a *key* in `my_dict`. We can also iterate over the keys in a dictionary.

```{code-cell} ipython3
for key in my_dict:
    print(key, ':', my_dict[key])
```

The best, and preferred, method, is to iterate over `key`,`value` pairs in a dictionary using the `items()` method of a dictionary.

```{code-cell} ipython3
for key, value in my_dict.items():
    print(key, ':', value)
```

Note, however, that like lists, the `item`s that come out of the `my_dict.items()` iterator are *not* items in the dictionary, but copies of them. If you make changes within the `for` loop, you will not change entries in the dictionary.

```{code-cell} ipython3
for key, value in my_dict.items():
    value = 'this string will not be in dictionary.'
    
my_dict
```

You will, though, if you use the keys.

```{code-cell} ipython3
for key, _ in my_dict.items():
    my_dict[key] = 'this will be in the dictionary.'
    
my_dict
```

## Built-in functions for dictionaries

The built-in `len()` function and `del` operation work on dictionaries.  

* `len(d)` gives the number of entries in dictionary `d`
* `del d[k]` deletes entry with key `k` from dictionary `d`

This is the first time we've encountered the `del` keyword. This keyword is used to delete variables and their values from memory. The `del` keyword can also be to delete items from lists. Let's see things in practice.

```{code-cell} ipython3
# Create my_list and my_dict for reference
my_dict = dict(a=1, b=2, c=3, d=4)
my_list = [1, 2, 3, 4]

# Print them
print('my_dict:', my_dict)
print('my_list:', my_list)

# Get lengths
print('length of my_dict:', len(my_dict))
print('length of my_list:', len(my_list))

# Delete a key from my_dict
del my_dict['b']

# Delete entry from my_list
del my_list[1]

# Show post-deleted objects
print('post-deleted my_dict:', my_dict)
print('post-deleted my_list:', my_list)
```

Note, though, that you cannot delete an item from a tuple, since it's immutable.

```{code-cell} ipython3
:tags: [raises-exception]
my_tuple = (1, 2, 3, 4)
del my_tuple[1]
```

## Dictionary methods
Dictionaries have several built-in methods in addition to the `items()` you have already seen.  Following are a few of them, assuming the dictionary is `d`.

| method | effect |
|:-------|:-------|
|`d.keys()`|return keys|
|`d.pop(key)` | return value associated with `key` and delete `key` from `d`|
|`d.values()` | return the values in `d`|
|`d.get(key, None)` | Fetch a value in `d` by key giving a default value (the second argument) if `key` is missing|

Let's try these out.

```{code-cell} ipython3
my_dict = dict(a=1, b=2, c=3, d=4)

my_dict.keys()
```

Note that this is a `dict_keys` object. We cannot index it. If, say, we wanted to sort the keys and have them index-able, we would have to convert them to a list.

```{code-cell} ipython3
sorted(list(my_dict.keys()))
```

This is not a usual use case, though, and be warned that doing then when this is not explicitly what you want can lead to bugs. Now let's try popping an entry out of the dictionary.

```{code-cell} ipython3
my_dict.pop('c')
```

```{code-cell} ipython3
my_dict
```

...and, as we expect, key `'c'` is now deleted, and its value was returned in the call to `my_dict.pop('c')`. Now, let's look at the values.

```{code-cell} ipython3
my_dict.values()
```

We get a `dict_values` object, similar to the `dict_keys` object we got with the `my_dict.keys()` method. Finally, let's consider `get()`.

```{code-cell} ipython3
my_dict.get('d')
```

This is the same as `my_dict['d']`, except that if the key `'d'` is not there, it will return a default value. Let's try using `my_dict.get()` with the deleted entry `'c'`.

```{code-cell} ipython3
my_dict.get('c')
```

Note that there was no error (there would be if we did `my_dict['c']`), and we got `None`. We could specify a default value.

```{code-cell} ipython3
my_dict.get('c', 3)
```

You should think about what behavior you want when you attempt to get a value out of a dictionary by key. Do you want an error when the key is missing? Then use indexing. Do you want to have a (possibly `None`) default if the key is missing and no error? Then use `my_dict.get()`.

You can get more information about build-in methods from the [Python documentation](https://docs.python.org/3/library/stdtypes.html#mapping-types-dict).

+++

## List methods
As you may guess, the dictionary method `pop()` has an analog that works for lists. (Why don't the dictionary `key()` and `values()` methods work for lists?) We take this opportunity to introduce a few more useful list methods. Imagine the list is called `s`.

| method | effect |
|:-------|:-------|
|`s.pop(i)` | return value at index `i` and delete it from the list|
|`s.append(x)` | Put `x` at the end of the list|
|`s.insert(i, x)`| Insert `x` at index `i` in the list|
|`s.remove(x)`| Remove the first occurrence of `x` from the list|
|`s.reverse()` | Reverse the order of items in the list|

+++

## Using dictionaries as kwargs

A nifty feature of dictionaries is that they can be passed into functions as keyword arguments. We covered named keyword arguments in the [Intro to functions lesson](/lessons/l07_functions). In addition to the named keyword arguments, a function can take in arbitrary keyword arguments (**not** arbitrary non-keyword arguments). This is specified in the function definition by including a last argument with a double-asterisk, `**`. The kwargs with the double-asterisk get passed in as a dictionary.

```{code-cell} ipython3
def concatenate_sequences(a, b, **kwargs):
    """Concatenate (combine) 2 or more sequences."""
    seq = a + b

    for key in kwargs:
        seq += kwargs[key]
        
    return seq
```

Let's try it!

```{code-cell} ipython3
concatenate_sequences('TGACAC', 'CAGGGA', c='GGGGGGGGG', d='AAAATTTTT')
```

Now, imagine we have a dictionary that contains our values.

```{code-cell} ipython3
my_dict = {"a": "TGACAC", "b": "CAGGGA", "c": "GGGGGGGGG", "d": "AAAATTTTT"}
```

We can now pass this directly into the function by preceding it with a double asterisk.

```{code-cell} ipython3
concatenate_sequences(**my_dict)
```

Beautiful! This example is kind of trivial, but you can imagine that it can come in handy, e.g. with large sets of sequence fragments that you read in from a file. We will use `**kwargs` later in the bootcamp.

*Question*: What is the risk in using a dictionary in this way to concatenate sequences?

+++

## Merging dictionaries

Saw I have two dictionaries that have no like keys and I want to merge them together. This might be like considering two volumes of an encyclopedia; they do not have and like keys, and we might like to consider them as a single volume. How can we accomplish this?

The `dict()` function, combined with the `**` operator in function calls allows for this. We simple call `dict()` with `**` before each dictionary argument.

```{code-cell} ipython3
restriction_dict = {"KpnI": "GGTACC", "HindII": "AAGCTT", "ecoRI": "GAATTC"}

dict(**my_dict, **restriction_dict, another_seq="AGTGTAGTG")
```

## Computing environment

```{code-cell} ipython3
:tags: [hide-input]

%load_ext watermark
%watermark -v -p jupyterlab
```
