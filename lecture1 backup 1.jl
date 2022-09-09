### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 930935f8-832a-45b4-8e5e-b194afa917c6
using PlutoUI, CairoMakie, Printf

# ╔═╡ 9f012035-21a9-4259-8d38-201f34a32bc7
# ╠═╡ show_logs = false
begin
    import Pkg
    Pkg.activate("../EBModel.jl/")
	using EBModel
	function parameters_input(params::Vector)
	
	return PlutoUI.combine() do Child
		
		inputs = [
			
			md""" latitude: $(
				Child(params[1], PlutoUI.Slider(-90:90))
			)""", 
			
			md""" day: $(
				Child(params[2], PlutoUI.Slider(1:365))
			)"""
		]
		
		md"""
		#### Forcing Parameters
		$(inputs)
		"""
	end
end
end

# ╔═╡ 4cb13d08-2eb3-11ed-01ec-b91fde7e11d0
md"""
# Global heat transport 

This lecture will...
"""

# ╔═╡ cfb8f979-37ca-40ab-8d3c-0053911717e7
md"""
## Latitudinal dependency of insolation

you have seen...\
but\
	
Let's construct a simple model for insolation

$(Resource("https://sacs.aeronomie.be/info/img/vza-sza.gif", :height => 300))

"""


# ╔═╡ 26f92186-21c0-42ce-864f-998ee5fbac86
md"""
#### Instantaneous Solar Flux

```math
Q = S_0 \left( \frac{\overline{d}}{d}\right)^2 cos(\theta_z)
```

``S_0`` is ...

explain ``d``, ``\overline{d}``, ``\theta_z``
"""

# ╔═╡ 75cacd05-c9f8-44ba-a0ce-8cde93fc8b85
md"""
### Calculating the zenith angle

depends on latitude, season, and time of day\
(for the time being, we assume that the insolation is constant throughout the day)

So we have an angle for latitude ``\phi``, an angle for the season (or declination angle) ``\delta`` and an angle for the hour of the day ``h``\

``\phi`` goes from... to...\
``\delta`` goes from... to...\

It is 0 at spring equinox (21 March)

$(Resource("https://cdn-ceele.nitrocdn.com/hlYTJaNDVwYkdtkDEjTIbpVANhqcsjrd/assets/static/optimized/rev-4ce9a06/wp-content/uploads/2021/04/declination-angle-earth-sun.png", :height => 300))
"""


# ╔═╡ 716088f3-9db6-4fe7-be96-0a0902f5d831
md"""
The formula for the zenith angle is 
```math
cos(\theta_z) = sin(\phi)sin(\delta) + cos(\phi)cos(\delta)cos(h)
```

Insolation occurs only for ``cos(\theta_z) > 0``, negative values indicate nighttime when ``Q=0``

Sunrise and sunset occur when ``cos(\theta_z) = 0``
```math
cos(h_0) = - tan(\phi)tan(\delta)
```

We want to have the daily averaged insolation.

Since we express the day in ``2\pi`` angles\
and ``Q`` if ``|h| > h_0``

```math
\langle Q \rangle_{day}  = \frac{S_0}{2\pi} \left(\frac{\overline{d}}{d}\right)^2 \int_{-h_0}^{h_0} sin(\phi)sin(\delta) + cos(\phi)cos(\delta)cos(h) dh
```

which is easily integrated to 


```math
\langle Q \rangle_{day}  = \frac{S_0}{\pi} \left(\frac{\overline{d}}{d}\right)^2 \left( sin(\phi)sin(\delta)h_0 + cos(\phi)cos(\delta)sin(h_0) \right)
```

##### The daily average zenith angle
It turns out that, due to the optical properties of the Earth’s surface (particularly bodies of water), the surface albedo depends on the solar zenith angle. It is therefore useful to consider the average solar zenith angle during daylight hours as a function of latitude and season.

The appropriate daily average here is weighted with respect to the insolation, rather than weighted by time. The formula is

```math
\langle cos(\theta_z) \rangle_{day}  = \frac{\int_{-h_0}^{h_0} Q cos(\theta_z) dh }{\int_{-h_0}^{h_0} Q dh } = 
```

The average zenith angle is much higher at the poles than in the tropics [Hartmann, 1994]. This contributes to the very high surface albedos observed at high latitudes."""

# ╔═╡ eae88c46-a8b6-4d3f-a9cb-07ce7c0e9ceb
md"""
Exercise: write a function to calculate the daily insolation
"""

# ╔═╡ 62290a48-92dc-450d-95ec-a6f03b8d64e3
begin 
	const days_per_year = 365.2422
	const ε             = 0.017236 # eccentricity
	const λ_per         = deg2rad(281.37) # longitude of perihelion (precession angle)
	const march_first   = 80.0

	function solar_longitude(day)

	    Δλ    = (day - march_first) * 2π/days_per_year
	    β = sqrt(1 - ε^2)
	
	    # Taking into account the eccentricity
	    # If ε = 0 (circular orbit), then λ = λₘ = Δλ
	
	    λₘ = -2*((ε/2 + (ε^3)/8 ) * (1+β) * sin(-λ_per) -
	        (ε^2)/4 * (1/2 + β) * sin(-2*λ_per) + (ε^3)/8 *
	        (1/3 + β) * sin(-3*λ_per)) + Δλ
	
	    λ = ( λₘ + (2*ε - (ε^3)/4)*sin(λₘ - λ_per) +
	        (5/4)*(ε^2) * sin(2*(λₘ - λ_per)) + (13/12)*(ε^3)
	        * sin(3*(λₘ - λ_per)) )
	
	    return λ
	end
	
	function daily_insolation(lat; day = 80, S₀ = 1365.2)
	
	    ϕ  = deg2rad(lat)
	    λ₀ = 23.5 # obliquity (earth's axial tilt)
	
	    λ = solar_longitude(day)
	    δ = asin(sin(deg2rad(λ₀)) * sin(λ))
	
	    h₀ = abs(δ)+abs(ϕ) < π/2 ? # there is a sunset / sunrise
	         acos(-tan(ϕ) * tan(δ)) :
	         ϕ*δ > 0 ? π : 0.0 # all day or all night
	
		# Zenith angle corresponding to the average daily insolation
		cosθₛ = h₀*sin(ϕ)*sin(δ) + cos(ϕ)*cos(δ)*sin(h₀)
	
	    Q = S₀/π * cosθₛ 
	
	    # correction due to eccentricity of earth's orbit
	    Q *= (1 + ε*cos(λ -  λ_per))^2 / (1 - ε^2)^2
	
	    return Q
	end
end

# ╔═╡ 87fdc7c2-536e-4aa1-9f68-8aec4bc7069d
@bind day_in_year PlutoUI.Slider(1:365)

# ╔═╡ 8d4d8b93-ebfe-41ff-8b9e-f8931a9e83c2
begin
	latitude = range(-90, 90, length = 180)
	Q = daily_insolation.(latitude; day = day_in_year)
	fig = Figure(resolution = (700, 300))
	ax = Axis(fig[1, 1], title = "Day: $(day_in_year)", xlabel = "latitude ᴼN", ylabel ="insolation Wm⁻²")
	lines!(ax, latitude, Q)
	ax.xticks = [-90, -90+23, -25, -50, 0, 25, 50, 90-23, 90]
	ylims!(ax, -10, 600)
	current_figure()
end

# ╔═╡ 555536a0-7829-4028-9d4c-bf64b4e15b59
md"""
### Surface temperature with latitude variable forcing

\

Let's use this formula to calculate the equilibrium temperature at different latitudes on March 1st


"""

# ╔═╡ 3f4f29e5-6388-4c7a-bc90-0cfb1d3f689e
@bind params parameters_input(["latitude", "day"])

# ╔═╡ d66ed888-357f-417a-8b2a-bceaee354bec
# ╠═╡ show_logs = false
begin
	sun_forcing = daily_insolation(params.latitude; day = params.day)

	grid  = Grid(2, max_height = 30km)
	model = Model(grid, ε = 0.5, forcing = sun_forcing)

	#initialize with the "correct temperature layers"
	model.temperature .= [288, 275, 230]

	# Define simulation parameters
	stop_time = 10years
	Δt = 1day

	nsteps = Int(floor(stop_time / Δt))
	# T = []
	# @inbounds for step in 1:nsteps
	# 	time_step!(model, Δt)
	# 	push!(T, model.temperature[1]
	# end

	# title_str = @sprintf("T_surface: %.2f ᵒC at latitude %d ᵒN and day %d", model.temperature[1] - 273.15, params.latitude, params.day)
	# f = Figure(resolution = (800, 500))
	# a = Axis(f[1, 1], title = title_str, xlabel = "Temperature [ᵒC]", ylabel = "height [km]")
	# lines!(a, 1:nsteps .* Δt, T)
	# current_figure()
end

# ╔═╡ 8f963bc5-1900-426d-ba1f-078ed45b48d3
md"""
# Heat Transport
"""

# ╔═╡ 0d8fffdc-a9f5-4d82-84ec-0f27acc04c21


# ╔═╡ Cell order:
# ╟─4cb13d08-2eb3-11ed-01ec-b91fde7e11d0
# ╠═cfb8f979-37ca-40ab-8d3c-0053911717e7
# ╟─26f92186-21c0-42ce-864f-998ee5fbac86
# ╟─75cacd05-c9f8-44ba-a0ce-8cde93fc8b85
# ╟─716088f3-9db6-4fe7-be96-0a0902f5d831
# ╟─eae88c46-a8b6-4d3f-a9cb-07ce7c0e9ceb
# ╟─62290a48-92dc-450d-95ec-a6f03b8d64e3
# ╟─87fdc7c2-536e-4aa1-9f68-8aec4bc7069d
# ╠═8d4d8b93-ebfe-41ff-8b9e-f8931a9e83c2
# ╟─555536a0-7829-4028-9d4c-bf64b4e15b59
# ╟─9f012035-21a9-4259-8d38-201f34a32bc7
# ╠═3f4f29e5-6388-4c7a-bc90-0cfb1d3f689e
# ╠═d66ed888-357f-417a-8b2a-bceaee354bec
# ╟─8f963bc5-1900-426d-ba1f-078ed45b48d3
# ╠═0d8fffdc-a9f5-4d82-84ec-0f27acc04c21
