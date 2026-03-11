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

# Lesson 2: Variables, operators, and types

<hr/>

+++

Whether you are programming in Python or pretty much any other language, you will be working with **variables**.  While the precise definition of a variable will vary from language to language, we'll focus on Python variables here. Like many of the concepts in this bootcamp, though, the knowledge you gain about Python variables will translate to other languages.

We will talk more about **objects** later, but a variable, like everything in Python, is an object. For now, you can think of it this way. The following can be properties of a variable:

1. The **type** of variable. E.g., is it an integer, like `2`, or a string, like `'Hello, world.'`?
2. The **value** of the variable.

Depending on the type of the variable, you can do different things to it and other variables of similar type.  This, as with most things, is best explored by example. We'll go through some of the properties of variables and things you can do to them in this tutorial.

We will work through this and the rest of the tutorials for the first day of the bootcamp using Jupyter notebooks. Henceforth in the bootcamp, we will use Jupyter notebooks except where explicitly noted. So, launch and notebook, and we'll get rolling!

+++

## Determining the type
First, we will use Python's built-in `type()` function to determine the type of some variables.

```{code-cell} ipython3
type(2)
```

```{code-cell} ipython3
type(2.3)
```

```{code-cell} ipython3
type('Hello, world.')
```

The `type` function told us that `2` is an `int` (short for integer), `2.3` is a `float` (short for floating point number, basically a real number that is not an integer), and `'Hello, world.'` is a `str` (short for string). Note that the single quotes around the characters indicate that it is a string. So, `'1'` is a string, but `1` is an integer.

Note that we can also express `float`s using scientific notation; $4.5\times 10^{-7}$ is expressed as `4.5e-7`.

```{code-cell} ipython3
type(4.5e-7)
```

### A note on strings

We just saw that strings can be enclosed in single quotes. In Python, we can equivalently enclose them in double quotes. E.g.,

    'my string'

and

    "my string"

are the same thing. We can also denote a string with triple quotes. So,

    """my string"""
    '''my string'''
    "my string"
    'my string'
    
are all the same thing. The difference with triple quotes is that it allows a string to extend over multiple lines.

```{code-cell} ipython3
# A multi-line string
my_str = """It was the best of times,
it was the worst of times..."""

print(my_str)
```

Note, though, we cannot do this with single quotes.

```{code-cell} ipython3
:tags: [raises-exception]
# This is a SyntaxError
my_str = 'It was the best of times,
it was the worst of times...'
```

## Operators

**Operators** allow you to do things with variables, like add them. They are represented by special symbols, like `+` and `*`. For now, we will focus on **arithmetic** operators. Python's arithmetic operators are

|action|operator|
|:-------|:----------:|
|addition | `+`|
|subtraction | `-`|
|multiplication | `*`|
|division | `/`|
|raise to power | `**`|
|modulo | `%`|
|floor division | `//`|

**Warning**: Do not use the `^` operator to raise to a number to a power. That is actually the operator for bitwise XOR, something we'll not cover in our lessons.[^bitwise_xor] 

[^bitwise_xor]: `^` is an example of a bitwise operation, i.e. it works on the binary digits (bits) that make up a number. E.g. 
    ```{code-cell} ipython3
    10^200
    ```

    Instead of raising 10 to the 200th power, Python performed a bitwise XOR as illustrated below:

    | <font color="white">a</font>     |Binary|Decimal |
    |:------|:-------|:------- |
    |Input 1| `00001010` | `10` |
    |Input 2| `11001000` | `200` |
    |Output| `11000010` | `194` |

    *Note*: if you want to see how a decimal number is represented in binary, you can use the following:

    ```{code-cell} ipython3
    '{0:b}'.format(194)
    ```

### Operations on integers

Let's see how these operators work on integers.

```{code-cell} ipython3
2 + 3
```

```{code-cell} ipython3
2 - 3
```

```{code-cell} ipython3
2 * 3
```

```{code-cell} ipython3
2 / 3
```

```{code-cell} ipython3
2 ** 3
```

```{code-cell} ipython3
2 % 3
```

```{code-cell} ipython3
2 // 3
```

This is what we would expect. An import note, though. If you are using Python 2, division of integers defaults to floor division (like the // operator in Python 3)[^python2].

[^python2]: Python 2 is a previous version of the Python language and while Python 2 support ended on New Years Day 2020, you might still find some old (legacy) code written in Python 2.
+++

### Operations on floats
Let's try floats.

```{code-cell} ipython3
2.1 + 3.2
```

Wait a minute!  We know `2.1 + 3.2 = 5.3`, but Python gives `5.300000000000001`. This is due to the fact that floating point numbers are stored with a finite number of binary bits. There will always be some rounding errors. This means that as far as the computer is concerned, it cannot tell you that `2.1 + 3.2` and `5.3` are equal. This is important to remember when dealing with floats, as we will see in the next lesson.

```{code-cell} ipython3
2.1 - 3.2
```

```{code-cell} ipython3
# Very very close to zero because of finite precision
5.3 - (2.1 + 3.2)
```

```{code-cell} ipython3
2.1 * 3.2
```

```{code-cell} ipython3
2.1 / 3.2
```

```{code-cell} ipython3
2.1 ** 3.2
```

```{code-cell} ipython3
2.1 % 3.2
```

```{code-cell} ipython3
2.1 // 3.2
```

Aside from the floating point precision issue I already pointed out, everything is like we would expect. Note, though, that we cannot divide by zero.

```{code-cell} ipython3
:tags: [raises-exception]
2.1 / 0.0
```

We can't do it with `int`s, either.

```{code-cell} ipython3
:tags: [raises-exception]
2 / 0
```

### Operations on integers and floats

This proceeds as we think it should.

```{code-cell} ipython3
2.1 + 3
```

```{code-cell} ipython3
2.1 - 3
```

```{code-cell} ipython3
2.1 * 3
```

```{code-cell} ipython3
2.1 / 3
```

```{code-cell} ipython3
2.1 ** 3
```

```{code-cell} ipython3
2.1 % 3
```

```{code-cell} ipython3
2.1 ** 3
```

And again we have the rounding errors, but everything is otherwise intuitive.

+++

### Operations on strings

Now let's try some of these operations on strings.  This idea of applying mathematical operations to strings seems strange, but let's just mess around and see what we get.

```{code-cell} ipython3
'Hello, ' + 'world.'
```

Ah!  Adding strings together concatenates them! This is also intuitive. How about subtracting strings?

```{code-cell} ipython3
:tags: [raises-exception]
'Hello, ' - 'world'
```

That stands to reason. Subtracting strings does not make sense. The Python interpreter was kind enough to give us a nice error message saying that we can't have a `str` and a `str` operand type for the subtraction operation. It also makes sense that we can't do multiplication, raising of power, etc., with two strings. How about multiplying a string by an integer?

```{code-cell} ipython3
'Hello, world.' * 3
```

Yes, this makes sense! Multiplication by an integer is the same thing as just adding multiple times, so the Python interpreter concatenates the string several times.

As a final note on operators with strings, watch out for this:

```{code-cell} ipython3
'4' + '2'
```

The result is *not* `6`, but it is a string containing the characters `'4'` and `'2'`.

+++

### Order of operations

The order of operations is also as we would expect. Exponentiation comes first, followed by multiplication and division, floor division, and modulo. Next comes addition and subtraction. In order of precedence, our arithmetic operator table is

|precedence|operators|
|:-------:|:----------:|
|1 | `**`|
|2 | `*`, `/`, `//`, `%`|
|3 | `+`, `-`|

You can also group operations with parentheses. Operations within parentheses is are always evaluated first. As a watchout, *do not* use excessive parentheses. So often, I see students not trusting the order of operations and polluting their code with lots of parentheses, making it unreadable. This has been the source of countless bugs I've encountered in student code through the years.

Let's practice.

```{code-cell} ipython3
1 + 4**2
```

```{code-cell} ipython3
1 + 4/2
```

```{code-cell} ipython3
1**3 + 2**3 + 3**3 + 4**3
```

```{code-cell} ipython3
(1 + 2 + 3 + 4)**2
```

Interestingly, we also demonstrated that the sum of the first $n$ cubes is equal to the sum of the first $n$ integers **squared**. Fun!

+++

## Variables and assignment operators

So far, we have essentially just used Python as an oversized desktop calculator. We would really like to be able to think about our computational problems symbolically. We mentioned **variables** at the beginning of the tutorial, but in practice we were just using numbers and strings directly. We would like to say that a variable, `a`, represents an integer and another variable `b` represents another integer. Then, we could do things like add `a` and `b`. So, we see immediately that the variables have to have a type associated with them so the Python interpreter knows what to do when we use operators with them. A variable should also have a **value** associated with it, so the interpreter knows, e.g., what to add.

In order to create, or **instantiate**, a variable, we can use an **assignment operator**. This operator is the equals sign. So, let's make variables `a` and `b` and add them.

```{code-cell} ipython3
a = 2
b = 3
a + b
```

Great!  We get what we expect! And we still have `a` and `b`.

```{code-cell} ipython3
a, b
```

Now, we might be tempted to say, "`a` is two." No. `a` is not two. `a` is a variable that *has a value of 2*. A variable in Python is not just its value. A variable also carries with it a type. It also has more associated with it under the hood of the interpreter that we will not get into. So, you can think about a variable as a map to an address in RAM (called a **pointer** in computer-speak) that stores information, including a type and a value.

+++

### Assignment/increment operators

Now, let's say we wanted to update the value of `a` by adding `4.1` to it. Python will do some magic for us.

```{code-cell} ipython3
print(type(a), a)

a = a + 4.1

print(type(a), a)
```

We see that `a` was initially an integer with a value of 2. But we added `4.1` to it, so the Python interpreter knew to change its type to a `float` and update its value.

This operation of updating a value can also be accomplished with an **increment operator**.

```{code-cell} ipython3
a = 2
a += 4.1
a
```

The `+=` operator told the interpreter to take the value of `a` and add `4.1` to it, changing the type of `a` in the intuitive way if need be. The other six arithmetic operators have similar constructions, `-=`, `*=`, `/=`, `//=`, `%=`, and `**=`.

```{code-cell} ipython3
a = 2
a **= 3
a
```

## Type conversion

Suppose you have a variable of one type, and you want to convert it to another. For example, say you have a string, `'42'`, and you want to convert it to an integer. This would happen if you were reading information from a text file, which by definition is full of strings, and you wanted to convert some string to a number. This is done as follows.

```{code-cell} ipython3
my_str = '42'
my_int = int(my_str)
print(my_int, type(my_int))
```

Conversely, we can convert an `int` back to a `str`.

```{code-cell} ipython3
str(my_int)
```

When converting a `float` to an `int`, the interpreter does not round the result, but gives the floor.

```{code-cell} ipython3
int(2.9)
```

Also consider our string concatenation warning/example from above:

```{code-cell} ipython3
print('4' + '2')
print(int('4') + int('2'))
```

## Computing environment

```{code-cell} ipython3
:tags: [hide-input]

%load_ext watermark
%watermark -v -p jupyterlab
```
