<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/latest.js?config=TeX-MML-AM_CHTML">
</script>

A lot of the work I'm currently doing involves making use of recursive conditional probability formulas to compute beliefs
about the posterior of quantity of interest. Here I'll try to clearly lay out how this works, first starting with a recursive
program in Julia. It's a simple function that add's it's two inputs by recursively remvoing one unit from it's first argument
and giving that unit to it's second argument, until a stop condition is met (first argument is equal to zero).

```julia
function add_two_numbers(x, y)
    if x == 0
        return y
    else
        return add_two_numbers(x-1, y+1)
    end
end
```

For the rest of this post this example is a bit out of place since it won't be used again but it's here in hopes that in the
case where recursion is a new concept, seeing it "explicitly" written down in a program might help understand the concept as
a hole. OK, so another example closer to what we'll want to deal with, though still void of any probability formula
manipulations. It's the example of computing a sample mean recursively. First, let's get some notation out of the way, we'll
use the symbol $$t$$ to denote time, or some discrete unit that delinates a "step". We'll use $$k$$ as an index to 
work within the bounds of time, so $$0 \lt k \lt t$$, and $$\sum_{k=1}^t$$ is a symbol stating that it will add everything 
that comes after it from the discrete step of 1 until $$t$$. And formula is:

$$\mu_t = {1\over{t}} \sum_{k=1}^t x_k$$
