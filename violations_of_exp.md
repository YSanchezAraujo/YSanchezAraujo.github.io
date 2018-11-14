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
    if food:
        return hot(container, food)
    end
        return container
end
```
