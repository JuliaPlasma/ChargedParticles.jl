# ChargedParticles.jl

A Julia package for representing and manipulating charged particles in plasma physics.

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
println("Iron charge: ", charge(fe3))
println("Iron-56 mass number: ", mass_number(fe56))
```

## Manual Outline

```@contents
Pages = [
    "manual/getting-started.md",
    "manual/particle-types.md",
    "manual/construction.md"
]
Depth = 2
```
