```python
import numpy as np

def hmm(nt):
    latent_vars = np.zeros(nt)
    obs_vars = np.zeros(nt)
    
    for t in np.arange(nt):
        if t == 1:
            latent_vars[t] = np.random.normal(loc=0, scale=1)
            obs_vars[t] = np.random.normal(loc=latent_vars[t], scale=1)
        else:
            latent_vars[t] = latent_vars[t-1] + np.random.normal(loc=0, scale=1)
            obs_vars[t] = np.random.normal(loc=latent_vars[t], scale=1)
            
    return dict(means=latent_vars, data=obs_vars)
```

```julia
using Distributions

function hmm(nt::Int64)::NamedTuple
    latent_vars = Array{Float64}(undef, NT)
    obs_vars = Array{Float64}(undef, NT)
    
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
