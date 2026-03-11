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

# Lesson 3: More operators and conditionals

<hr/>

+++

In this lesson, we will examine more operators beyond the arithmetic and assignment operators we have already encountered. We will look at **relational operators**, **identity operators**, and **logical operators**. We'll use these operators in **conditional statements**, which help a program decide what to do in certain situations.

+++

## Relational operators

Suppose we want to compare the values of two numbers.  We may want to know if they are equal for example. The operator used to test for equality is `==`, an example of a **relational operator** (also called a **comparison operator**).

+++

### The equality relational operator

Let's test out the `==` to see how it works.

```{code-cell} ipython3
5 == 5
```

```{code-cell} ipython3
5 == 4
```

Notice that using the operator gives either `True` or `False`. These are important keywords in Python that indicate truth. `True` and `False` have a special type, called `bool`, short for **Boolean**[^boolean].

[^boolean]: The term Boolean comes from [Boolean algebra](https://en.wikipedia.org/wiki/Boolean_algebra), a formal way of describing logical operations.

```{code-cell} ipython3
type(True)
```

```{code-cell} ipython3
type(False)
```

The equality operator, like all relational operators in Python, also works with variables, testing for equality of their *values*. Equality of the variables themselves uses **identity operators**, described [below](#identity-operators).

```{code-cell} ipython3
a = 4
b = 5
c = 4

a == b
```

```{code-cell} ipython3
a == c
```

Now, let's try it out with some floats.

```{code-cell} ipython3
5.3 == 5.3
```

```{code-cell} ipython3
2.1 + 3.2 == 5.3
```

Yikes! Python is telling us that `2.1 + 3.2` is not `5.3`. This is floating point arithmetic haunting us. Note that floating point numbers that can be exactly represented with binary numbers do not have this problem.

```{code-cell} ipython3
2.2 + 3.2 == 5.4
```

This behavior is unpredictable, so here is a rule.

<div style="color: tomato; text-align: center; font-weight: bold;">

Never use the <font font-family="monospace">==</font> operator with floats.
    
</div>

+++

### Other relational operators

As you might expect, there are other relational operators.  The relational operators are

|English|Python|
|:-------|:----------:|
|is equal to | `==`|
|is not equal to | `!=`|
|is greater than | `>`|
|is less than | `<`|
|is greater than or equal to | `>=`|
|is less than or equal to | `<=`|

We can try some of them out!

```{code-cell} ipython3
4 < 5
```

```{code-cell} ipython3
5.7 <= 3
```

```{code-cell} ipython3
'michael jordan' > 'lebron james'
```

Whoa. What happened on that last one?  The Python interpreter has weighed in on the debate about the greatest basketball player of all time. It clearly thinks Michael Jordan is better than LeBron James, but that seems kind of subjective. To understand what the interpreter is doing, we need to understand how it compares strings.

+++

### A brief aside on Unicode

In Python, characters are encoded with [Unicode](https://en.wikipedia.org/wiki/Unicode). This is a standardized library of characters from many languages around the world that contains over 100,000 characters. Each character has a unique number associated with it. We can access what number is assigned to a character using Python's built-in `ord()` function.

```{code-cell} ipython3
ord('a')
```

```{code-cell} ipython3
ord('λ')
```

The relational operators on characters compare the values that the `ord` function returns. So, using a relational operator on `'a'` and `'b'` means you are comparing `ord('a')` and `ord('b')`. When comparing strings, the interpreter first compares the first character of each string. If they are equal, it compares the second character, and so on. So, the reason that `'michael jordan' > 'lebron james'` gives a value of `True` is because `ord('m') > ord('l')`.

Note that a result of this scheme is that testing for equality of strings means that **all** characters must be equal. This is the most common use case for relational operators with strings.

```{code-cell} ipython3
'lebron' == 'lebron james'
```

```{code-cell} ipython3
'lebron' == 'LeBron'
```

```{code-cell} ipython3
'LeBron James' == 'LeBron James'
```

```{code-cell} ipython3
'AGTCACAGTA' == 'AGTCACAGCA'
```

### Chaining relational operators

Python allow chaining of relational operators.

```{code-cell} ipython3
4 < 6 < 6.1 < 9.3
```

```{code-cell} ipython3
4 < 6.1 < 6 < 9.3
```

This is convenient do to. However, it is important not to do the following, even though it is legal.

```{code-cell} ipython3
4 < 6.1 > 5
```

In other words, do not mix the direction of the relational operators. You could run into trouble because, in this case, `5` and `4` are never compared. An expression with different relations among all three numbers also returns `True`.

```{code-cell} ipython3
4 < 6.1 > 3
```

So, I issue a warning.

<div style="color: tomato; text-align: center; font-weight: bold;">

Do not mix the directions of chained relational operators.
    
</div>

+++

(identity-operators)=
## Identity operators

Identity operators check to see if two variables occupy the same space in memory; i.e., they are the same object (we'll learn more about objects as we go along in the bootcamp). This is different that the equality relational operator, `==`, which checks to see if two variables have the same **value**. The two identity operators are in the table below.

|English|Python|
|:-------|:----------:|
|is the same object | `is` |
|is not the same object | `is not` |

That's right. The operators are pretty much the same as English! Let's see these operators in action and get at the difference between `==` and `is`. Let's use the **`is`** operator to investigate how Python stored variables in memory, starting with `float`s.

```{code-cell} ipython3
a = 5.6
b = 5.6

a == b, a is b
```

Even though `a` and `b` have the same value, they are stored in different places in memory. They can occupy the same place in memory if we do a `b = a` assignment.

```{code-cell} ipython3
a = 5.6
b = a

a == b, a is b
```

Because we assigned `b = a`, they necessarily have the same (immutable) value. So, the two variables occupy the same place in memory for efficiency.

```{code-cell} ipython3
a = 5.6
b = a
a = 6.1

a == b, a is b
```

In the last two examples, we see that assigning `b = a`, where `a` is a `float` in this case, means that `a` and `b` occupy the same memory. However, reassigning the value of `a` resulted in the interpreter placing `a` in a new space in memory. We can double check the values.

Integers sometimes do not behave the same way, however.

```{code-cell} ipython3
a = 5
b = 5

a == b, a is b
```

Even though we assigned `a` and `b` separately, they occupy the same place in memory. This is because Python employs **integer caching** for all integers between `-5` and `256`. This caching does not happen for more negative or larger integers.

```{code-cell} ipython3
a = 350
b = 350

a is b
```

Now, let's look at strings.

```{code-cell} ipython3
a = 'Hello, world.'
b = 'Hello, world.'

a == b, a is b
```

So, even though `a` and `b` have the same *value*, they do not occupy the same place in memory. If we do a `b = a` assignment, we get similar results as with `float`s.

```{code-cell} ipython3
a = 'Hello, world.'
b = a

a == b, a is b
```

Let's try string assignment again with a different string.

```{code-cell} ipython3
a = 'python'
b = 'python'

a == b, a is b
```

Wait a minute! If we choose a string `'python'`, it occupies the same place in memory as another variable with the same value, but that was not the case for `'Hello, world.'`. This is a result of Python also doing [**string interning**](https://en.wikipedia.org/wiki/String_interning) which allows for (sometimes very) efficient string processing. Whether two strings occupy the same place in memory depends on what the strings are.

The caching and interning might be a problem, but you generally do not need to worry about it for **immutable** variables. Being immutable means that once the variables are created, their values cannot be changed. If we do change the value the variable gets a new place in memory. All variables we've encountered so far, `int`s, `float`s, and `str`s, are immutable. We will see encounter mutable data types in future lesson, in which case it really *does* matter practically to you as a programmer whether or not two variables are in the same location in memory.

+++

## Logical operators

**Logical operators** can be used to connect relational and identity operators. Python has three logical operators.

|Logic|Python|
|:-------|:----------:|
|AND | `and`|
|OR | `or`|
|NOT | `not`|

The `and` operator means that if both operands are `True`, return `True`. The `or` operator gives `True` if *either* of the operands are `True`. Finally, the `not` operator negates the logical result.

That might be as clear as mud to you. It is easier to learn this, as usual, by example.

```{code-cell} ipython3
True and True
```

```{code-cell} ipython3
True and False
```

```{code-cell} ipython3
True or False
```

```{code-cell} ipython3
True or True
```

```{code-cell} ipython3
not False and True
```

```{code-cell} ipython3
not(False and True)
```

```{code-cell} ipython3
not False or True
```

```{code-cell} ipython3
not (False or True)
```

```{code-cell} ipython3
7 == 7 or 7.6 == 9.1
```

```{code-cell} ipython3
7 == 7 and 7.6 == 9.1
```

I think these examples will help you get the hang of it. Note that it is important to specify the ordering of your operations, particularly when using the `not` operator.

Note also that

    a < b < c
    
is equivalent to

    (a < b) and (b < c)

With these new types of operators in hand, we can construct a more complete table of operator precedence.

|precedence|operators|
|:-------|:----------:|
|1 | `**`|
|2 | `*`, `/`, `//`, `%`|
|3 | `+`, `-`|
|4 | `<`, `>`, `<=`, `>=`|
|5 | `==`, `!=`|
|6 | `=`, `+=`, `-=`, `*=`, `/=`, `**=`, `%=`, `//=`|
|7 | `is`, `is not`|
|8 | `and`, `or`, `not`|

+++

## Operators we left out

We have left out a few operators in Python. Two that we left out are the **membership operators**, `in` and `not in`, which we will visit in a forthcoming lesson. The others we left out are **bitwise operators** and operators on **sets**, which we will not be covering in the bootcamp.

+++

## The numerical values of True and False

As we move to conditionals, it is important to take a moment to evaluate the numerical values of the keywords `True` and `False`.  They have numerical values of `1` and `0`, respectively.

```{code-cell} ipython3
True == 1
```

```{code-cell} ipython3
False == 0
```

You can do arithmetic on `True` and `False`, but you will get implicit type conversion.

```{code-cell} ipython3
True + False
```

```{code-cell} ipython3
type(True + False)
```

## Conditionals

**Conditionals** are used to tell your computer to do a set of instructions depending on whether or not a Boolean is `True`. In other words, we are telling the computer:

    if something is true:
        do task a
    otherwise:
        do task b

In fact, the syntax in Python is almost exactly the same. As an example, let's ask whether or not a codon is the canonical start codon (`AUG`).

```{code-cell} ipython3
codon = 'AUG'

if codon == 'AUG':
    print('This codon is the start codon.')
```

The syntax of the `if` statement is apparent in the above example. The Boolean expression, `codon == 'AUG'`, is called the **condition**. If it is `True`, the indented statement below it is executed. This brings up a very important aspect of Python syntax.

<div style="color: dodgerblue; text-align: center; font-weight: bold;">

Indentation matters.
    
</div>

Any lines with the same level of indentation will be evaluated together.

```{code-cell} ipython3
codon = 'AUG'

if codon == 'AUG':
    print('This codon is the start codon.')
    print('Same level of intentation, so still printed!')
```

What happens if our codon is not the start codon?

```{code-cell} ipython3
codon = 'AGG'

if codon == 'AUG':
    print('This codon is the start codon.')
```

Nothing is printed. This is because we did not tell Python what to do if the Boolean expression `codon == 'AUG'` evaluated `False`. We can add that with an `else` **clause** in the conditional.

```{code-cell} ipython3
codon = 'AGG'

if codon == 'AUG':
    print('This codon is the start codon.')
else:
    print('This codon is not the start codon.')
```

Great! Now, we have a construction that can choose which action to take depending on a value. So, if we're zooming along an RNA sequence, we could pick out the start codon and infer where translation would start. Now, what if we want to know if we hit a canonical stop codon (`UAA`, `UAG`, or `UGA`)?  We can nest the conditionals!

```{code-cell} ipython3
codon = 'UAG'

if codon == 'AUG':
    print('This codon is the start codon.')
else:
    if codon == 'UAA' or codon == 'UAG' or codon == 'UGA':
        print('This codon is a stop codon.')
    else:
        print('This codon is neither a start nor stop codon.')
```

Notice that the indentation defines which clause the statement belongs to. E.g., the second `if` statement is executed as part of the first `else` clause.

While this nesting is very nice, we can be more concise by using an `elif` clause.

```{code-cell} ipython3
codon = 'UGG'

if codon == 'AUG':
    print('This codon is the start codon.')
elif codon == 'UAA' or codon == 'UAG' or codon == 'UGA':
    print('This codon is a stop codon.')
else:
    print('This codon is neither a start nor stop codon.')
```

## Computing environment

```{code-cell} ipython3
:tags: [hide-input]

%load_ext watermark
%watermark -v -p jupyterlab
```
