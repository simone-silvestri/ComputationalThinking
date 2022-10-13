using SparseArrays

const σ = 5.67e-8

function daily_insolation(lat; day = 81, S₀ = 1365.2)

	march_first = 81.0
	ϕ = deg2rad(lat)
	δ = deg2rad(23.45) * sind(360*(day - march_first) / 365.25)

	h₀ = abs(δ) + abs(ϕ) < π/2 ? # there is a sunset/sunrise
		 acos(-tan(ϕ) * tan(δ)) :
		 ϕ * δ > 0 ? π : 0.0 # all day or all night
		
	# Zenith angle corresponding to the average daily insolation
	cosθₛ = h₀*sin(ϕ)*sin(δ) + cos(ϕ)*cos(δ)*sin(h₀)
	
	Q = S₀/π * cosθₛ 

	return Q
end

function annual_average_insolation(ϕ; S₀ = 1356.2)
    Q = 0.0
    for day in 1:365
        Q += daily_insolation(ϕ; day, S₀) ./ 365
    end
    return Q
end

mutable struct DiffusiveModel{S, T, K, E1, E2, A, B, F, C, ΦF, ΦC}
    stepper :: S
    Tₒ :: T # surface temperature
    Tₐ :: T # troposhere temperature
    Tₛ :: T # stratosphere temperature
    κ  :: K # diffusivity
    εₐ :: E1 # troposphere emissivity
    εₛ  :: E2 # stratosphere emissivity
    α  :: A # surface albedo
    β  :: B # stratosphere absorptivity of shortwave radiation
    Q  :: F # forcing
    Cₒ :: C # surface heat capacity
    Cₐ :: C # trophosphere heat capacity
    Cₛ :: C # stratosphere heat capacity
    ϕᶠ :: ΦF # the latitudinal grid at interface points
    ϕᶜ :: ΦC # the latitudinal grid at center points
end

struct ExplicitTimeStep end
struct ImplicitTimeStep end

ExplicitDiffusiveModel   = DiffusiveModel{<:ExplicitTimeStep}
ImplicitDiffusiveModel   = DiffusiveModel{<:ImplicitTimeStep}

timestepping(model::ExplicitDiffusiveModel) = "Explicit"
timestepping(model::ImplicitDiffusiveModel) = "Implicit"

# We define a constructor for the DiffusiveModel
function DiffusiveModel(stepper, N; κ = 0.55, εₛ = 0.6, εₐ = 0.1, α = 0.2985, β = 0.05, Q = 341.3)
    Cₒ = 1000.0 * 4182.0 * 100 / (3600 * 24) # ρ * c * H / seconds_per_day
	Cₐ = 0.9 * 1e5 / 10 * 1000 / (3600 * 24) # Δp / g * c / seconds_per_day
    Cₛ = 0.1 * 1e5 / 10 * 1000 / (3600 * 24) 
    ϕᶠ = range(-π/2, π/2, length=N+1)
    ϕᶜ = 0.5 .* (ϕᶠ[2:end] .+ ϕᶠ[1:end-1])
    Tₐ = 288.0 * ones(N)
    Tₒ = 288.0 * ones(N)
    Tₛ = 288.0 * ones(N)
    return DiffusiveModel(stepper, Tₒ, Tₐ, Tₛ, κ, εₐ, εₛ, α, β, Q, Cₒ, Cₐ, Cₛ, ϕᶠ, ϕᶜ)
end

# A pretty show method that displays the model's parameters
function Base.show(io::IO, model::DiffusiveModel)
    print(io, "One-D energy budget model with:", '\n',
    "├── time stepping: $(timestepping(model))", '\n',
    "├── εₐ: $(model.εₐ)", '\n',
    "├── εₛ: $(model.εₛ)", '\n',
    "├── α: $(albedo(model))", '\n',
	"├── β: $(model.β)", '\n',
    "├── κ: $(model.κ)", '\n',
    "└── Q: $(model.Q) Wm⁻²")
end

# We define, again, the emissivities and albedo as function of the model
albedo(model::DiffusiveModel) = model.α

troposphere_emissivity(model::DiffusiveModel) = model.εₐ
troposphere_emissivity(model::DiffusiveModel{<:Any, <:Any, <:Any, <:Function}) = model.εₐ(model)

function construct_matrix(model, Δt)
	# Temperatures at time step n
	Tₒ = model.Tₒ
	Tₐ = model.Tₐ
	Tₛ = model.Tₛ

	εₐ = troposphere_emissivity(model)
	εₛ = model.εₛ

	Cₒ = model.Cₒ
	Cₐ = model.Cₐ
	Cₛ = model.Cₛ

	m = length(Tₛ)
	
	eₒ = @. Δt * σ * Tₒ^3
	eₐ = @. Δt * σ * Tₐ^3 * εₐ
    eₛ = @. Δt * σ * Tₛ^3 * εₛ

	# We build and insert the diagonal entries
	Dₒ = @. Cₒ + eₒ
    Dₐ = @. Cₐ + 2 * eₐ
	Dₛ = @. Cₛ + 2 * eₛ
	
	D  = [Dₒ..., Dₐ..., Dₛ...] 

	# the off-diagonal entries corresponding to the interexchange terms
	dₒₐ = @. - eₐ
    dₐₒ = @. - εₐ * eₒ

    dₐₛ = @. - εₐ * eₛ 
    dₛₐ = @. - εₛ * eₐ 

    dₒₛ = @. - (1 - εₐ) * eₛ
    dₛₒ = @. - (1 - εₐ) * εₛ * eₒ
	
	# spdiagm(idx => vector) constructs a sparse matrix 
	# with vector `vec` at the `idx`th diagonal 
	A = spdiagm(0 => D,
				m => [dₒₐ..., dₐₛ...],
			   -m => [dₐₒ..., dₛₐ...],
               2m => dₒₛ,
              -2m => dₛₒ)
	return A
end

function construct_diffusion_matrix(model, Δt)

	A = construct_matrix(model, Δt)
	
	cosϕᶜ = cos.(model.ϕᶜ)
	Δϕ = model.ϕᶠ[2] - model.ϕᶠ[1]

	a = @. model.κ / Δϕ^2 / cosϕᶜ * cos(model.ϕᶠ[1:end-1])
	c = @. model.κ / Δϕ^2 / cosϕᶜ * cos(model.ϕᶠ[2:end])

	m = length(model.Tₛ)
    for i in 1:m
		# Adding the off-diagonal entries corresponding to Tⱼ₊₁ (exclude the last row)
        if i < m
            A[i  , i+1]     = - Δt * c[i]
            A[i+m, i+1+m]   = - Δt * c[i]
            A[i+2m, i+1+2m] = - Δt * c[i]
		end
		# Adding the off-diagonal entries corresponding to Tⱼ₋₁ (exclude the first row)
        if i > 1 
            A[i,   i-1]     = - Δt * a[i]
            A[i+m, i-1+m]   = - Δt * a[i]
            A[i+2m, i-1+2m] = - Δt * a[i]
        end
		# Adding the diagonal entries
        A[i  , i]     += Δt * (a[i] + c[i])
        A[i+m, i+m]   += Δt * (a[i] + c[i])
        A[i+2m, i+2m] += Δt * (a[i] + c[i])
    end
	
	return A
end

function time_step!(model::ImplicitDiffusiveModel, Δt)
	
	A = construct_diffusion_matrix(model, Δt)
	α = albedo(model)
    β = model.β

	rhsₒ = model.Cₒ .* model.Tₒ .+ Δt .* (1 .- α) .* (1 .- β) .* model.Q
	rhsₐ = model.Cₐ .* model.Tₐ
	rhsₛ = model.Cₛ .* model.Tₛ .+ Δt .* β .* (1 .+ α .* (1 - β)) .* model.Q
	
	rhs = [rhsₒ..., rhsₐ..., rhsₛ...]

	T = A \ rhs

	nₒ = length(model.Tₒ)
	nₐ = length(model.Tₐ)
	nₛ = length(model.Tₛ)

    model.Tₒ .= T[1:nₒ]
	model.Tₐ .= T[nₒ+1:nₒ+nₐ]
	model.Tₛ .= T[nₒ+nₐ+1:nₒ+nₐ+nₛ]
end

function evolve_model!(model; Δt = 60.0, stop_year = 100)
	stop_iteration = Int(stop_year * 365 ÷ Δt)
	@inbounds for iter in 1:stop_iteration
		time_step!(model, Δt)
	end
end

ϕ = range(-89.0, 89.0, length = 90)

ϵₛₜᵣ = 0.1 # Pre Industrial stratospheric emissivity in the longwave range
ϵₜᵣₒ = 0.55 # Pre Industrial tropospheric emissivity in the longwave range
βₛₜᵣ = 0.05 # Pre Industrial  stratospheric emissivity in the shortwave range

a₀ = 0.312
a₁ = 0.15 
varα = @. a₀ + a₁ .* 0.5 * (3 * sind(ϕ)^2 .- 1)

# variable emissivity (function that depends on the model state)
ε₀, ε₁, ε₂ = (ϵₜᵣₒ, 0.02, 0.005)
function varε(model) 
	return @. min(max(ε₀ + ε₁ * log2(440.0/280) + ε₂ * (model.Tₛ - 286.38), 0), 1.0)
end

βₛₜᵣ = 0.05 # Pre Industrial  stratospheric emissivity in the shortwave range

model = DiffusiveModel(ImplicitTimeStep(), 90; κ = 0.5, α = varα, εₐ = varε , εₛ = ϵₛₜᵣ, β = βₛₜᵣ, Q = annual_average_insolation.(ϕ))


