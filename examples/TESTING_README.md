# Why I heart unit testing

http://en.wikipedia.org/wiki/Unit_testing

Unit tests are a way to say "given these inputs/stimuli, I expect my code to give me this outputs/behaviours".

For example, in R, consider that I have a function called `add(x, y)` that returns the sum of `x` and `y`. If you called it as `add(1, 4)`, you would expect it to return `5`. So then you write a test for it, which is basically:

```
    result = add(1, 4)
    if(result != 5 ) { abort(paste("I expected 5 but got ", result) }
```

...except we are using RUnit, which lets us condense that to an uglier
but more useful:

```
    result = add(1, 4)
    checkTrue(result == 5)
```

If `add(1, 4)` doesn't return `5`, it means the function is broken, and
you should go back to fix it.

It doesn't seem like a big deal with a function like this, but consider
that you had a more complicated function. If you are changing something
in that function, one small mistake could cascade through other parts
of your program. Unit tests help you identify a problem and fix it before
you roll your code out for people to use and grants to fund.
