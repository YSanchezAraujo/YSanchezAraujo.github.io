```python

```

```julia
using Distributions

function hmm(nt::Int64)::NamedTuple
    latent_vars = Array{Float64}(undef, NT)
    obs_vars = Array{Float64}(undef, NT)
    latent_vars[1] = rand(Normal(0, 1))
    
    for t in 1:nt
        if t == 1
            latent_vars[t] = rand(Normal(0, 1))
            obs_vars[t] = rand(Normal(latent_vars[t], 1))
        else
            latent_vars[t] = latent_vars[t-1] + rand(Normal(0, 1))
            obs_vars[t] = rand(Normal(latent_vars[t], 1))
        end 
    end
    
    (means=latent_vars, data=obs_vars)
end
```
