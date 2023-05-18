
const Nx = 512
const Nz = 512
const Lx = 1
const Lz = 1
x = (0:Nx-1)*(Lx/Nx)
z = (0:Nz-1)*(Lz/Nz)
meshgrid(y,x) = (ndgrid(x,y)[[2,1]]...,) # create mesh


X, Z = meshgrid(x,z)

const x₁, z₁ = Lx/3, Lz/2
const x₂, z₂ = 2*Lx/3, Lz/2
const b₀ = abs(x₂ - x₁)     # initial vortex radius
const a₀ = 0.177*b₀

t = 0
tend = 15.0
iter = 0
δt = 1e-3

Reₜ = 1000
ν = 1e-05;        # m²/s
Τ₀ =  Reₜ*ν;      # initial vortex circulation
const Ω₀ = Τ₀/(π*(a₀^2))

# initialise vorticity
IC(x, z) = Ω₀*exp(-((x - x₁)^2 + (z - z₁)^2)/a₀^2) + Ω₀*exp(-((x - x₂)^2 + (z - z₂)^2)/a₀^2)

ω = @. IC(X, Z)

# heatmap((0:512-1)*(1/512), (0:512-1)*(1/512), ω, size = (500,600), color=:turbo, lw=4)
# annotate!(xtickfontsize=12,ytickfontsize=12, xguidefontsize=18,
#         yguidefontsize=18, legendfontsize=12,title = "ω(x,z,t = $(0))")
# xlabel!("x")
# ylabel!("z")
# savefig("./w_surf_$(0).pdf")
