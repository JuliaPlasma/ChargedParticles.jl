using Documenter, ChargedParticles

DocMeta.setdocmeta!(ChargedParticles, :DocTestSetup, :(using ChargedParticles); recursive=true)

makedocs(
    sitename="ChargedParticles.jl",
    format=Documenter.HTML(),
    modules=[ChargedParticles],
    pages=[
        "Home" => "index.md",
        "Manual" => [
            "Getting Started" => "manual/getting-started.md",
            "Particle Types" => "manual/particle-types.md",
            "Construction" => "manual/construction.md",
        ],
        "API Reference" => "api.md"
    ],
    checkdocs=:exports,
    doctest=true
)

deploydocs(
    repo="github.com/Beforerr/ChargedParticles.jl",
)
