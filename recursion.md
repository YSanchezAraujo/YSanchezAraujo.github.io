<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/latest.js?config=TeX-MML-AM_CHTML">
</script>

<h1>Recursive definition of a sample mean</h1>
A lot of the work I'm currently doing involves making use of recursive conditional probability formulas to compute beliefs
about some posterior distribution. Here I'll try to clearly lay out how this works, first starting with a recursive
program in Julia. It's a simple function that adds its two inputs by recursively removing one unit from its first argument
and giving that unit to its second argument, until a stop condition is met (first argument is equal to zero).

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

# and to make sure I'm not doing some sort of trickery with my definition of X

X_random = rand(1000);

isapprox(regular_mean(X_random), recursive_mean(1, 0, X_random))
```

**ASIDE** although I do think Julia is the suprior language **for this type of work**, given the larger user bases of other
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
<h1>Using probablistic concepts with recursion</h1>
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
means imagine you're in maze of rooms and each time you enter a room you go into a new state. We'll say that each room is one
state. Now imagine that the rooms are on a linear track `R1 -> R2 -> R3 ... -> RN` and so you know that if you're in room 3
then you could have only gotten there room 2 and when you were in room 2 you could have only gotten there from room 1. In
which case, knowing that we are in room 3, or 4, or 10 give us all information for how we go there. This is what the idea
of the Markov property says. If you Google it, or read a text book on it the authors may define it as: "the future is 
independent of the past, given the present". The idea of the Markov property is what I mean when I say a state is complete.

To give an example of how this might look like in within our probability notation, say we have the expression: 
$$P(x_t | x_{t-1}, x_{t-2})$$, if each of the $$x$$ states refer to a room in the example above, then by the Markov property:

$$P(R_3 | R_2, R_1) = P(R_3 | R_2)$$

With that in mind, we'll start to get into thinking recusively and probablistically about states. Our goal is to figure out,
or have a best estimate of what state we are in, which means that this knowledge won't be given, we'll have to infer it
based on all the other peices of information we have. First we have to further define some notation, all $$x$$ are states and 
when refering to a sequence of them we'll write $$x_{j:k}$$. $$y$$ denotes observations and like states we can refer to 
sequences of them: $$y_{j:k}$$. $$a$$ will denote an action that is taken and again we can have a sequence of them:
$$a_{j:k}$$

Now at time $$t$$ we would like to know $$P(x_t)$$, and the information that we know is true up until this point consists of
$$y_{1:t}$$ and $$a_{1:t}$$, there for we can write:

$$P(x_t | y_{1:t}, a_{1:t})$$

now we can use Bayes rule to reason about seeing $$y_{t}$$, if the state was $$x_t$$ and our history: 

$$P(x_t | y_{1:t}, a_{1:t}) \propto { P(y_t | x_t, y_{1:t-1}, a_{1:t}) \times P(x_t | y_{1:t-1}, a_{1:t}) } \tag 6$$

the the symbol $$\propto$$ says it's proportional instead of equal to. This is because there's a term in the denominator, 
the normalizing constant $$P(y_t | y_{1:t-1}, a_{1:t})$$ that I've ommitted. To move forward we need to introduce two
new identities:

$$P(x_t | x_{0:t-1}, y_{1:t-1}, a_{1:t}) = P(x_t | x_{t-1}, a_t) \tag 7$$

$$P(y_t | x_{0:t}, y_{1:t-1}, a_{1:t}) = P(y_t | x_t) \tag 8$$

using $$(8)$$ we can see that the first term in $$(6)$$ is reduced to $$P(y_t|x_t)$$. Now we take a look at the second term
in $$(6)$$. We now need to bring in the idea of recursion and reason about what the current state $$x_t$$ might be in terms 
of our past beliefs. We can rewrite the second term in $$(6)$$ as:

$$\int P(x_t | x_{t-1}, y_{1:t-1}, a_{1:t}) \times P(x_{t-1}|, y_{1:t-1}, a_{1:t-1})dx_{t-1} \tag 9$$

there are two things to notice here, the second term of $$(9)$$ is the $$t-1$$ version of expression
$$(6)$$, and our intergral and $$dx_{t-1}$$ notation is telling us we've done this recursively, all the way from the start at
$$t=1$$. Again we can see from one of the identities introduced, $$(7)$$, that the first term of $$(9)$$ is reduced to
$$P(x_t | x_{t-1}, a_t)$$. Putting these facts together $$(9)$$ becomes:

$$\hat P(x_t) = \int P(x_t | x_{t-1}, a_t) \times P(x_{t-1}) dx_{t-1} \tag{10}$$

this now allows us to change $$(6)$$ to become: 

$$P(x_t) \propto P(y_t|x_t) \times \hat P(x_t) \tag{11}$$

<h3>General Bayesian filter</h3>

The last two equations $$(10), (11)$$ provide the required definitions to define a wide range of filtering methods, and they
respectively correspond to the two major "steps" in a Bayesian filter algorithm, the prediction and update steps. Looking
at the equations you can see that $$(10)$$ is a prediction because it doesn't take into account the most recent observation.
Then $$(11)$$ is an update because it revises the prediction by taking into account the most recent observation. Additionally, 
the term $$P(x_t | x_{t-1}, a_t)$$ is typically refered to as a transition function and $$P(y_t|x_t)$$ is typically known as
a likelihood function. Algorithms such as the Kalman filter and the Bootstrap filter both make use of $$(10)$$ and $$(11)$$.

As a final example, I'll write down the most generic particle filter algorithm in python:

```python
import numpy as np
import scipy.stats

def particle_filter(data, np, tf, lik):
    """data::array : of data points,
    np::int : number of particles,
    tf::function : transition function (for the prediction step)
    lik::function: likelihood function (for the update step)
    """
    n_time_steps = len(data)
    # intialized value placeholders below
    weights_time_t = np.random.random(np)
    particles_time_t = np.random.random(np)
    particle_means = np.zeros(n_time_steps) # for storage 

    for time in range(n_time_steps):
        # predict new particles based on the initial values
        particles_time_t = tf(particles_time_t)
        # calculate the likelihoods
        weights_time_t = lik(particles_time_t, observations[time])
        # normalize weights
        weights_time_t /= sum(weights_time_t)
        # multinomial resample accoring to the weights
        particles_time_t = np.random.choice(particles_time_t, np, p=weights_time_t)
        particle_means[time] = particles_time_t.mean()
    
    return particle_means
```

and here are examples of what an arbitrary transition and likelihood function might look like:

```python
def transition_function(x_time_minus_1):
    return [np.random.normal(i, 1) for i in x_time_minus_1]

def likelihood_function(x_predicted, y):
    return [scipy.stats.norm.pdf(x=i, loc=y, scale=1) for i in x_predicted]
```
