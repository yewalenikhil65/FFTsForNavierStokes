## lets decide the wavenumbers for first derivative..useful for calculating nonlinear quantity
kx = (2π/Lx)*[0:(Nx/2) - 1 ;0; -(Nx/2) + 1:-1]
lz = (2π/Lz)*[0:(Nz/2) - 1 ;0; -(Nz/2) + 1:-1]
kk, ll = meshgrid(kx, lz)  # meshgrid of wavenumbers for first derivatives


## lets decide the wavenumbers for second order derivative
kxx = (2π/Lx)*[0:(Nx/2); -(Nx/2) + 1:-1]
lzz = (2π/Lz)*[0:(Nz/2); -(Nz/2) + 1:-1]

K, L = meshgrid(kxx, lzz)  # meshgrid of wavenumbers for second derivatives

Λᵢ = @. (1 - ν*(δt/2)*(K^2 + L^2))/(1 + ν*(δt/2)*(K^2 + L^2))
Λₑ = @. δt/(1 + ν*(δt/2)*(K^2 + L^2))

# tweaks for wavenumber matrices for poisson equation
@views k = copy(K);
@views l = copy(L);
k[1, 1] = Inf;
l[1, 1] = Inf;

