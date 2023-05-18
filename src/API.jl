
# ∇²ψ = -ω, in fourier space, ℱ(Ψ) = -ℱ(ω)/-(k² + l²) = ℱ(ω)/(k² + l²)
function ∇²ψ(𝛚::Matrix{ComplexF64}, k::Matrix{Float64}, l::Matrix{Float64}) 
    𝚿::Matrix{eltype(𝛚)} = 𝛚./((k.^2.0 + l.^2.0))
    return 𝚿
end

function 𝐍(𝚿::Matrix{ComplexF64}, 𝛚::Matrix{ComplexF64}, kk::LazyGrids.GridAV{Float64}, ll::LazyGrids.GridAV{Float64})

    u::Matrix{Float64} = real(ℱ⁻¹*(im*ll .* 𝚿))    # x-component velocity in real-space
    v::Matrix{Float64} = -real(ℱ⁻¹*(im*kk .* 𝚿))   # z-component velocity in real-space

    ωx::Matrix{Float64} = real(ℱ⁻¹*(im*kk .* 𝛚))    # ∂ω/∂x in real-space
    ωz::Matrix{Float64} = real(ℱ⁻¹*(im*ll .* 𝛚))    # ∂ω/∂z in real-space

    𝗡::Matrix{eltype(𝛚)} = ℱ*(u.*ωx + v.*ωz)   # ℱ(u.∇ω)


   # De-alias by 2/3 orszag rule..by keeping only frequency
   # components corresponding to wavenumbers less than 2/3 of the Nyqvist wavenumber
    @views 𝗡[ceil(Int,Nx/3)+1: Nx-ceil(Int,Nx/3)+1, ceil(Int, Nz/3)+1: Nz-ceil(Int,Nz/3)+1] .= 0

    return 𝗡
end


function solve(𝚿ₙ::Matrix{ComplexF64}, 𝛚ₙ::Matrix{ComplexF64}, kk::LazyGrids.GridAV{Float64}, ll::LazyGrids.GridAV{Float64}, k::Matrix{Float64}, l::Matrix{Float64})
    𝛚ₙ₊₁::Matrix{eltype(𝛚ₙ)} = zeros(ComplexF64, size(𝛚ₙ))
    𝛚ₙ₊₂::Matrix{eltype(𝛚ₙ)} = zeros(ComplexF64, size(𝛚ₙ))

    𝚿ₙ₊₁::Matrix{eltype(𝛚ₙ)} = zeros(ComplexF64, size(𝚿ₙ))
    𝚿ₙ₊₂::Matrix{eltype(𝛚ₙ)} = zeros(ComplexF64, size(𝚿ₙ))

    for (iter, t) in enumerate(0:δt:tend)
        if t == 0   # 1st time-step, implicit linear + explicit euler for nonlinear
            𝛚ₙ₊₁ = 𝛚ₙ .* Λᵢ - 𝐍(𝚿ₙ, 𝛚ₙ ,kk, ll) .* Λₑ
            𝚿ₙ₊₁ = ∇²ψ(𝛚ₙ₊₁, k ,l)
    
        else  # else, do Implicit for linear term + Explicit adam-bashforth stepping for Non-linear
            𝛚ₙ₊₂ = 𝛚ₙ₊₁ .* Λᵢ - (1.5*𝐍(𝚿ₙ₊₁, 𝛚ₙ₊₁ ,kk, ll) - 0.5*𝐍(𝚿ₙ, 𝛚ₙ ,kk, ll)) .* Λₑ
            𝚿ₙ₊₂ = ∇²ψ(𝛚ₙ₊₂, k ,l)
    
            𝛚ₙ = copy(𝛚ₙ₊₁)
            𝚿ₙ = copy(𝚿ₙ₊₁)
    
            𝛚ₙ₊₁ = copy(𝛚ₙ₊₂)
            𝚿ₙ₊₁ = copy(𝚿ₙ₊₂)
    
        end
    
        #  updated voriticity in real-space .. for exporting at iters
        if mod(iter-1, ceil(Int, 1/δt)) == 0                                                                                                                                                                                                                                                                                                                                
            ω::Matrix{Float64} = real(ℱ⁻¹*𝛚ₙ₊₂)
            # u = real(ℱ⁻¹*(im*L .* 𝚿))    # x-component velocity in real-space
            # v = -real(ℱ⁻¹*(im*K .* 𝚿))    # z-component velocity in real-space
            writedlm("./src/vorticity/w_$(trunc(t, digits=2)).csv", ω, ',')
            println("Vorticity written at t = $(trunc(t, digits=2)) seconds")
        end
    end
end
