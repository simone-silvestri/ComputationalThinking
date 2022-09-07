### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 930935f8-832a-45b4-8e5e-b194afa917c6
using PlutoUI

# ╔═╡ 4cb13d08-2eb3-11ed-01ec-b91fde7e11d0
md"""
# Global heat transport 

This lecture will...
"""

# ╔═╡ 8f963bc5-1900-426d-ba1f-078ed45b48d3


# ╔═╡ cfb8f979-37ca-40ab-8d3c-0053911717e7
md"""
## Latitudinal dependency of insolation

you have seen...\
but\
	
Let's construct a simple model for insolation
 
$(Resource("https://sacs.aeronomie.be/info/img/vza-sza.gif", :height => 500))

"""

# ╔═╡ 26f92186-21c0-42ce-864f-998ee5fbac86
md"""
#### Instantaneous Solar Flux

$Q = S_0$
"""

# ╔═╡ 3410c90b-c104-496a-aeae-abb4269702e8


# ╔═╡ 2104e307-9937-47ce-8006-a76451d3b724


# ╔═╡ 29fd491f-1814-4ecd-8725-3ca5f0c8246c


# ╔═╡ 19690fe5-e4b8-4907-9b13-25187196c253


# ╔═╡ 8dd4390f-f939-4b40-bc6b-77c0c0ba22c1


# ╔═╡ 2186388f-d53d-443f-9b5f-0eea37bc225f


# ╔═╡ cfaabc65-ec71-4aa4-9517-d159e8ad204a


# ╔═╡ 8ac1778e-fea1-4f99-b7e5-527557c4df6c


# ╔═╡ 86aa72cf-8c2c-40a3-af9e-05a0b5fd6869


# ╔═╡ 75f3f95f-528a-4e48-ac8c-480712189f82


# ╔═╡ d448f833-ac95-4522-b8fe-9b7a793f1576


# ╔═╡ 7e2ff1a6-af8d-4a92-9efc-b089242629b3


# ╔═╡ 8a0331d8-9a18-42dd-9dc3-d15f4410b686


# ╔═╡ 4ae71c84-957f-41b2-8675-797a03aa91ed


# ╔═╡ bb30825b-54b8-41ce-81f7-d876d40e80df


# ╔═╡ e9585ce8-8f29-4b14-b025-2c669b14cd96


# ╔═╡ 20211451-b473-4a4f-a6f6-4cb57e73782c


# ╔═╡ f9945486-5b14-41bb-a2a9-29d02722bfd3
md"""

"""

# ╔═╡ b6954b03-d3b4-4148-9f78-c32fb4118328


# ╔═╡ 05ac44dd-1a5c-4337-8373-004dc36d930c


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.40"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.3"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "a602d7b0babfca89005da04d89223b867b55319f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.40"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═4cb13d08-2eb3-11ed-01ec-b91fde7e11d0
# ╠═930935f8-832a-45b4-8e5e-b194afa917c6
# ╠═8f963bc5-1900-426d-ba1f-078ed45b48d3
# ╠═cfb8f979-37ca-40ab-8d3c-0053911717e7
# ╠═26f92186-21c0-42ce-864f-998ee5fbac86
# ╠═3410c90b-c104-496a-aeae-abb4269702e8
# ╠═2104e307-9937-47ce-8006-a76451d3b724
# ╠═29fd491f-1814-4ecd-8725-3ca5f0c8246c
# ╠═19690fe5-e4b8-4907-9b13-25187196c253
# ╠═8dd4390f-f939-4b40-bc6b-77c0c0ba22c1
# ╠═2186388f-d53d-443f-9b5f-0eea37bc225f
# ╠═cfaabc65-ec71-4aa4-9517-d159e8ad204a
# ╠═8ac1778e-fea1-4f99-b7e5-527557c4df6c
# ╠═86aa72cf-8c2c-40a3-af9e-05a0b5fd6869
# ╠═75f3f95f-528a-4e48-ac8c-480712189f82
# ╠═d448f833-ac95-4522-b8fe-9b7a793f1576
# ╠═7e2ff1a6-af8d-4a92-9efc-b089242629b3
# ╠═8a0331d8-9a18-42dd-9dc3-d15f4410b686
# ╠═4ae71c84-957f-41b2-8675-797a03aa91ed
# ╠═bb30825b-54b8-41ce-81f7-d876d40e80df
# ╠═e9585ce8-8f29-4b14-b025-2c669b14cd96
# ╠═20211451-b473-4a4f-a6f6-4cb57e73782c
# ╠═f9945486-5b14-41bb-a2a9-29d02722bfd3
# ╠═b6954b03-d3b4-4148-9f78-c32fb4118328
# ╠═05ac44dd-1a5c-4337-8373-004dc36d930c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
