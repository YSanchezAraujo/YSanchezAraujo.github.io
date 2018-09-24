<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.4/latest.js?config=TeX-MML-AM_CHTML">
</script>

<h1>[revert to state $$$x_0$](https://ysanchezaraujo.github.io/)</h1>

<h2>Intuition?</h2> 

There's a lot to say about sequential monte carlo and I'm not qualified to say most of it. Happily though, there are some things I can understand, or trick myself into thinking that I understand. So, here goes: 

Maybe the best place to start is in giving the "why of monte carlo". Typically, after you've defined some experiment with it's sample space, some events in that sample space and observations from the events you then want to compute some "objects" I'll call them that tell you something meaningfull about the observations. For example, we may want to compute an expectation, also known as the mean. We compute this as the sum of weighted values, that is to say the realization of the observation times the probability of that realization: 

$$x \times p(x)$$

where $$x$$ is the observation's value and $$p(x)$$ is a density function returning a number that tells you the relative likelihood of "seeing" the observation. When we have many samples, $$N$$ of them we compute the expectation as: 

$$\sum_{i=1}^N \Bigl[ x_i \times p(x_i) \Bigr]$$
