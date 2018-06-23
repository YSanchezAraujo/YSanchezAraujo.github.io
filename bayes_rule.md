<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/latest.js?config=TeX-MML-AM_CHTML">
</script>

<h2>Introduction to Bayesian Statistics</h2> 

What is Baye's Rule one might ask, well to be honest I'm not exactly sure. Though I do understand how to mechanically apply it given two or $$N$$ random variables, to answer the question of what exactly it is, is an entirely different thing and albiet, at least for me a far more difficult challenge. 

$$P(A|B) = {P(B|A)P(A) \over{P(B)}}$$


what you see above is an inversion of the conditional probability statement for the two random variables $$A$$ and $$B$$. This isn't limited to just two random variables, let's take a look at what it would be for 3 of them at a time


$$P(A|B,C) = { P(B|A,C)P(A|C)P(C) \over{P(B|C)P(C)} }$$


$$= {P(B|A,C)P(A|C) \over{P(B|C)}}$$
