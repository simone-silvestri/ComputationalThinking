using Symbolics

@variables ε₁, ε₂, ε₃, ε₄, ε₅, ε₆, ε₇, ε₈, ε₉, ε₁₀
@variables T₁, T₂, T₃, T₄, T₅, T₆, T₇, T₈, T₉, T₁₀
@variables βₒ, βₛₜ, S₀, σ

ε = [ε₁, ε₂, ε₃, ε₄, ε₅, ε₆, ε₇, ε₈, ε₉, ε₁₀]
T = [T₁, T₂, T₃, T₄, T₅, T₆, T₇, T₈, T₉, T₁₀]

β = [βₒ, 0, 0, 0, 0, 0, 0, 0, 0, βₛₜ]

function longwave_radiation(ε, T, N)

    upward_flux   = Vector(undef, N)
    downward_flux = Vector(undef, N)
    absorption    = Vector(undef, N)
    emission      = Vector(undef, N)
    
    upward_flux[1]   = 0
    downward_flux[N] = 0

    for i in 2:N
        upward_flux[i]   = upward_flux[i-1] * (1 - ε[i-1]) + ε[i-1] * σ * T[i-1]
    end

    for i in N-1:-1:1
        downward_flux[i] = downward_flux[i+1] * (1 - ε[i+1]) + ε[i+1] * σ * T[i+1]
    end

    absorption  = (upward_flux .+ downward_flux) .* ε[1:N]

    emission    = 2σ .* ε[1:N] .* T[1:N]

    emission[1] =  σ .* T[1]

    return absorption .- emission 
end 

function add_shortwave_radiation!(equations, β)

    N          = length(equations)
    solar_flux = Vector(undef, N)

    β[N]       = β[end]

    solar_flux = Vector(undef, N)

    solar_flux[end] = S₀ / 4
    
    for i in N-1:-1:1
        solar_flux[i] = solar_flux[i+1] * (1 - β[i+1])
    end

    equations .+= solar_flux .* β[1:N]
end

function atmospheric_matrix()
    [prod((1-ε[k]) for k in i+1:j-1) for i in 1:N, j in 1:N] 

end




equations = longwave_radiation(ε, T, 3)
add_shortwave_radiation!(equations, β)

equations = simplify.(substitute.(equations, (Dict(ε₂ => 0.55, 
                                                   ε₃ => 0.1, 
                                                   σ  => 5.67e-8, 
                                                   βₒ => 0.7, 
                                                   βₛₜ => 0.01, 
                                                   S₀ => 1365),)
                                  )
                      )

equations = Equation.(equations, 0.0)

N = 4
A = [1; fill(2, N-1)]
M = Symmetric([prod(Tuple(1-ε[1:N][k] for k in i+1:j-1)) for i in 1:N, j in 1:N])
M2 = ε[1:N] .* M .* ε[1:N]' 
M3 = M2 - Diagonal(ε[1:N].^2 .+ A .* ε[1:N])

M4 = M3 .* σ