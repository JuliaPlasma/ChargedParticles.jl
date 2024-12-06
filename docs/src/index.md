# ChargedParticles.jl

[![Build Status](https://github.com/JuliaPlasma/ChargedParticles.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaPlasma/ChargedParticles.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://JuliaPlasma.github.io/ChargedParticles.jl/dev/) 


A Julia package for representing charged particles inspired by [PlasmaPy](https://github.com/PlasmaPy/PlasmaPy)'s particles subpackage.

## Overview

ChargedParticles.jl provides a flexible type system for working with various particles including elementary particles, ions, and isotopes. It supports multiple string formats and construction methods, making it easy to work with common particles in plasma physics.

## Features

- Support for elementary particles, ions, and isotopes
- Flexible string-based particle construction with common particle aliases
- Physical properties (mass, charge, atomic number, charge number, etc.)
- Integration with [Mendeleev.jl](https://github.com/Eben60/Mendeleev.jl) for chemical element data

## Installation

```julia
using Pkg
Pkg.add("ChargedParticles")
```

## Quick Example

```@example
using ChargedParticles

# Create common particles
e = electron()
p = proton()
α = Particle("alpha")

# Create ions and isotopes
fe = Particle("Fe-56 3+")     # Iron(III) ion
fe54 = Particle(:Fe, 3, 54)
d = Particle("D+")         # Deuteron

# Access properties
println("Electron mass: ", mass(e))
println("Alpha particle charge: ", charge(α))
println("Iron(III) ion charge: ", charge(fe))
println("Iron-54 mass number: ", mass_number(fe54))
println("Deuteron mass: ", mass(d))
```

## Related Packages

- [PlasmaPy](https://github.com/PlasmaPy/PlasmaPy): A Python package for plasma physics.
- [Mendeleev.jl](https://github.com/Eben60/Mendeleev.jl): A Julia package for accessing periodic table data.
- [Corpuscles.jl](https://github.com/JuliaPhysics/Corpuscles.jl): A Julia package for for particle physics.

## Manual Outline

```@contents
Pages = [
    "manual/getting-started.md",
    "manual/particle-types.md",
    "manual/construction.md"
]
Depth = 2
```
