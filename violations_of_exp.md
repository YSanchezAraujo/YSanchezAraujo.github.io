# Thoughts on learning

Imagine that you put a bowl with some cold rice in the microwave. After some mintues have gone by and you go to take your food out of the microwave you notice two things. 

  * The rice is now heated up and 
  * The bowl is also heated up. 
  
My intuition is that upon experiencing this you form a causal map, a function like object that goes something like: 

```julia
function microwave(stuff) 
    return hot(stuff)
end
```

but then say on some other day you forget to put any food in the microwave and you just have the bowl in there. Again, after some mintues, say the same exact mintues as before you go to remove the bowl and to your surprise the bowl is not hot! Your definition of the microwave function might change, maybe you've now created a new function:

```julia
function microwave(container, food)
    if food
        return hot(container, food)
    end
    return container
end
```

So, what can this say about how we might reason in this situation? Well, consider the first function definition above, notice that `stuff` is the representation of everything that goes into the microwave, we treat it as a unit, and we treat the microwave essentially as a universal warmer of things. From this first encounter we have some expectation of what the output looks like given inputs to the microwave. Then when we forget to put anything with water molecules to vibrate, and hence to heat up into the microwave, the outcome violates the causal relationship we've built up. What might we do then? Well, second function definition hints at that we start to deconstruct what we've previously chunked together as a single unit. OK, so let's take this one step further, imagine successive episodes of expectation -> surpise -> expectation -> surprise ..... and so on. How might we represent this as a function? 

```julia
function learn_things(chunk, prior_expectation)
    if holds_within_error(chunk, prior_expectation)
        return transformation_to_input(chunk)
    else
        return learn_things(deconstruct(chunk), adjust(prior_expectation))
    end
end
```