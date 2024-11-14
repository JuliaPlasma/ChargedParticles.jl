# ChargedParticles.jl

[![Build Status](https://github.com/Beforerr/ChargedParticles.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Beforerr/ChargedParticles.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://beforerr.github.io/ChargedParticles.jl/dev/) 


A Julia package for representing charged particles inspired by [PlasmaPy](https://github.com/PlasmaPy/PlasmaPy)'s particles subpackage.

## Overview

ChargedParticles.jl provides a flexible type system for working with various particles including elementary particles, ions, and isotopes. It supports multiple string formats and construction methods, making it easy to work with common particles in plasma physics.

## Features

- Support for elementary particles, ions, and isotopes
- Flexible string-based particle construction
- Physical properties (mass, charge, etc.)
- Common particle aliases
- Unit support via Unitful.jl

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/Beforerr/ChargedParticles.jl")
```

## Quick Example

```@example
using ChargedParticles

# Create common particles
e = electron()       # electron
p = proton()         # proton
α = Particle("alpha") # alpha particle

# Create ions and isotopes
fe3 = Particle("Fe3+")     # Iron(III) ion
fe56 = Particle("Fe-56")   # Iron-56
d = Particle("D+")         # Deuteron

# Access properties
println("Electron mass: ", mass(e))
println("Alpha particle charge: ", charge(α))
println("Iron charge: ", charge(fe3))
println("Iron-56 mass number: ", mass_number(fe56))
println("Deuteron mass: ", mass(d))
```

## Related Packages

- [PlasmaPy](https://github.com/PlasmaPy/PlasmaPy): A Python package for plasma physics.
- [Mendeleev.jl](https://github.com/Eben60/Mendeleev.jl): A Julia package for accessing periodic table data.
- [Corpuscles.jl](https://github.com/Beforerr/Corpuscles.jl): A Julia package for for particle physics.

## Manual Outline

```@contents
Pages = [
    "manual/getting-started.md",
    "manual/particle-types.md",
    "manual/construction.md"
]
Depth = 2
```
