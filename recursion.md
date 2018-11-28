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

$$\mu_t = {1\over{t}} \sum_{k=1}^t x_k \tag 1$$

the "correctness" of this first manipulation below comes from the principle of induction, if we have a mean over $$t$$ things: $${1\over{t}}\sum_{k=1}^t x_k$$ and we now want to compute a new mean at interval $$t+1$$, we can take the previous sum over
those $$t$$ intervals (sum only, not the mean), then add our new item that we got at $$t+1$$ and divide by $$t+1$$

$$ {1\over t+1} \left( x_{t+1} + \sum_{k=1}^{t}x_k \right)$$

take note that here I'm using the bounds $$t+1$$ and $$t$$, but this would take on the same meaning if I instead used $$t$$ and
$$t-1$$. The rest of the derivation will make use of the latter bounds. Given what we've just declared above, we can
use $$(1)$$, and take one element out of the sum:

$$ {1\over t} \left( x_{t} + \sum_{k=1}^{t-1}x_k \right) \tag 2$$

just to be clear, right now we have: 

$$\mu_t = {1\over{t}} \sum_{k=1}^t x_k = {1\over t} \left( x_{t} + \sum_{k=1}^{t-1}x_k \right) $$

the next step is to use $$(1)$$ and manipulate the index:

$$\mu_{t-1} = {1\over (t-1)}\sum_{k=1}^{t-1}x_k \tag 3$$

using this we can write the that $$(2)$$ is equal to: 

$$  = {1\over t} \left(x_t + (t-1)\mu_{t-1} \right) \tag 4$$

then we distribute, rearrange, and factor out a $$t^{-1}$$ to get that $$(4)$$ is equal to:

$$= \mu_{t-1} + {1\over t} \left(x_t - \mu_{t-1} \right) \tag 5$$

and so we have that we can recursively compute the mean through discrete intervals by: 

$$\mu_t = {1\over{t}} \sum_{k=1}^t x_k = \mu_{t-1} + {1\over{t}} \left(x_t - \mu_{t-1} \right)$$

given that I started with a Julia function, let's see how we can write $$(5)$$ as a function. For this we'll also have to 
be explicit about thinking of the data.

```julia
X = [2, 3, 1, 5]

function recursive_mean(t, mu, data)
    if t-1 == length(data)
        return mu
     else
         mu_k = mu + 1/t * (data[t] - mu)
         return recursive_mean(t+1, mu_k, data)
     end
end

# test it
function regular_mean(data)
    sum(data)/length(data)
end

# because of how arithmetic works in computers we have to use
# the isapprox function to check for equality

isapprox(regular_mean(X), recursive_mean(1, 0, X))

# and to make sure I'm not doing some trickery with my definition of X

X_random = rand(1000);

isapprox(regular_mean(X_random), recursive_mean(1, 0, X_random))
```

**ASIDE** although I do think Julia is the suprior language for this type of work, given the larger user bases of other
languages here's a Python implementation

```python
import numpy as np

X = [2, 3, 1, 5]

def recursive_mean(t, mu, data):
    if t-1 == len(data):
        return mu
    else:
        mu_k = mu + 1/t * (data[t-1] - mu)
        return recursive_mean(t+1, mu_k, data)

np.isclose(np.mean(X), recursive_mean(1, 0, X))

X_random = np.random.random(1000)

np.isclose(np.mean(X_random), recursive_mean(1, 0, X_random))

```

Alright so, now we add the tools of probability. By no means is this meant to be a self-contained refresher on probability but
here are the two main facts we'll need (there are some assumptions here that I'm not stating ... I think so it's best to
refer to a proper text book for clarity):

**Chain rule of probability**

$$P(A | B, C) = P(A|B, C) \times P(B|C) \times P(C)$$

**Bayes rule**

$$P(A | B, C) = {   {P(B | A, C) \times P(A | C)} \over{P(B | C)} }$$

To be clear, these are specific forms of the formulas which we get through algebraic manipulations. For example, 
the inversion of $$P(A|B, C)$$ can be written so that you have $$P(C|A)$$ instead of $$P(A|C)$$ in the numerator. The next
idea we'll make use of is called the Markov property. This property can be useful when thinking of "sequences of things"
and for our purposes invoking the Markov property means that a "state" is "complete". To further expand on what this actually
means imagine you're maze of rooms and each time you enter a room you go into a new state. We'll say that each room is one
state. Now imagine that the rooms are on a linear track `R1 -> R2 -> R3 ... -> RN`
