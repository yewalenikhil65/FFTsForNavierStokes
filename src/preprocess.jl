using LinearAlgebra, FFTW
using LazyGrids, DelimitedFiles


include("input_params.jl")

include("plan_dfts.jl")

include("wavenumbers.jl")

include("API.jl")

# initial conditions
𝛚ₙ = ℱ*ω
𝚿ₙ = ∇²ψ(𝛚ₙ, k ,l)



