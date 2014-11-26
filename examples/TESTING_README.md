# Why I heart unit testing

http://en.wikipedia.org/wiki/Unit_testing

Unit tests are a way to say "given these inputs/stimuli, I expect my code to give me this outputs/behaviours".

For example, in R, consider that I have a function called `add(x, y)` that returns the sum of `x` and `y`. If you called it as `add(1, 4)`, you would expect it to return `5`. So then you write a test for it, which is basically:

```
    result = add(1, 4)
    if(result != 5 ) { abort(paste("I expected 5 but got ", result) }
```

...except we are using RUnit, which lets us condense that to a friendlier:

```
    result = add(1, 4)
    checkTrue(result == 5)
```

If `add(1, 4)` doesn't return `5`, it means the function is broken, and you should go back to fix it.

## Move fast and break stuff

It doesn't seem like a big deal with a function like this, but consider that you had a more complicated function. If you are changing something in that function, one small mistake could cascade through other parts of your program. In fact, it could affect anything that calls your function, or any function that depends on output of anything that calls your function, or any function that depends on the output of functions that depend on... anyway, just write good tests and it'll be fine.

## Executable documentation

The other use of unit tests is as "executable documentation". This means you can run tests that return results, and if you look at the test, it tells you exactly how the function/module/method/whatever should behave.

## Additional reading

[Test Driven Development](http://en.wikipedia.org/wiki/Test-driven_development) is a design pattern where you write the test first and then write the code to make the test pass. It's a great pattern for a shoot-first-ask-questions-later person like me, because it makes me plan ahead.

[RUnit](http://cran.r-project.org/web/packages/RUnit/), the R unit testing framework I use. It's no [RSpec](http://rspec.info/), but it's not bad.