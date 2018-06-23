<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/latest.js?config=TeX-MML-AM_CHTML">
</script>

<h2>Introduction to Bayesian Statistics</h2> 

What is Baye's Rule one might ask, well to be honest I'm not exactly sure. Though I do understand how to mechanically apply it given two or $$N$$ random variables, to answer the question of what exactly it is, is an entirely different thing and albiet, at least for me a far more difficult challenge. I suppose if I wanted to give what I feel to be a cop-out answer I'd say something like "it's a clever way to invert a probability statement to get at an otherwise difficult or unavailable result". So for example, perhaps we don't know the probability of rain given a car crash but we do know the probability of a car crash given rain, using bayes rule we can get at what the probability of rain given a car crash is. 

$$P(A|B) = {P(B|A)P(A) \over{P(B)}} \tag 1$$


what you see above is an inversion of the conditional probability statement for the two random variables $$A$$ and $$B$$. This isn't limited to just two random variables, let's take a look at what it would be for 3 of them at a time


$$P(A|B,C) = { P(B|A,C)P(A|C)P(C) \over{P(B|C)P(C)} }$$


$$= {P(B|A,C)P(A|C) \over{P(B|C)}}$$

it's important to understand that this is just one possible inversion, as you can condition any of the random variables on all the others, or any pair on the other and you'd apply the rules of conditional and total probability accordingly to get a different definition/statement. 


If that doesn't make much sense to you then I suppose I got ahead of myself. To understand Bayes rule it's required to understand the concepts of joint probability, conditional probility, and total probability. So let's first take a look at joint probability: 

$$ P(A,B) = P(A|B)P(B) = P(B|A)P(A) \tag 2$$

now let's take just one of the statements on the right hand side: 

$$P(B|A)P(A)$$

and let's do some algebra after equating it to the left hand side $$P(A,B)$$


$$P(A,B) = P(B|A)P(A)$$


$$={ P(B|A) = {P(A,B)\over{P(A)}} }\tag 3$$


alright so now hopefully we can see how to use the result above with equation 2, if you look at equation 2 you can see that it's possible to move around the probabilities of the random varaibles on the right side to get either one alone. Lets do that now: 


$$P(B|A) = {P(A|B)P(B) \over {P(A)}} \tag 4$$


equation 4 above is exactly the same as equation 3 with: 


$$P(A|B)P(B) = P(A,B)$$

a result which we've already defined in equation 2! At this point I'm sure it all just seems like algebraic mumbo-jumbo, but remember the algebra holds and when you relate these probabilty statements such as $$P(A|B)$$ to real world events such as the probabilty of a car crash given rain, you start to see how this is a rather general way to compute probabilities of things. 
