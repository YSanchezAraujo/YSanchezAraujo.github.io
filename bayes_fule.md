<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/latest.js?config=TeX-MML-AM_CHTML">
</script>

I want to just quickly note down some simple mental models, concerning Bayes rule and probabilility axioms.
These have been helpful in more involved work. Before going into Bayes rule, we first need to consider how we interpret symbols
like: $P(K=k)$, and $P(K=k|V=v)$. But before we do even that, let's get the algebra out of the way. 

$$P(A,B,C,D) = P(A|B,C,D)P(B,C,D) = P(C,A|B,D)P(B|D)P(D) = P(D|A,B,D)P(A|B,D)P(B,D)$$

if this is clear and obvious to you great, but if you're rusty or just starting to get to know these manipulations and the
above don't make complete sense, my only advice is to practice working with them. Google the chain rule of probability and play
with different examples, it's a relatively easy hump to get over(if a hump at all)! So why am I talking about the chain rule
when the post is clearly named Bayes rule? Consider the below:

$$P(A,B) = P(B|A)P(A) = P(A|B)P(B)$$

$$P(B|A)P(A) = P(A|B)P(B)$$

$$P(B|A) = \frac{P(A|B)P(B)}{P(A)}$$

$$P(A|B) = \frac{P(B|A)P(A)}{P(B)}$$

and for any of the above:

$$P(B) = \int P(B|A)P(A) \mathop{da}$$

the same holds the other way around to get the marginal $P(A)$. 
