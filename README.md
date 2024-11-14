# ChargedParticles.jl

[![Build Status](https://github.com/Beforerr/ChargedParticles.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Beforerr/ChargedParticles.jl/actions/workflows/CI.yml?query=branch%3Amain)

A Julia package for working with charged particles in plasma physics, inspired by PlasmaPy's particles subpackage.

## Features

- Support for common particles (electrons, protons)
- Custom ion creation with arbitrary charge states
- Basic particle properties (mass, charge, atomic number)
- Type checking functions (is_electron, is_proton, is_ion)
- Pretty printing of particle representations

## Installation

```julia
using Pkg
Pkg.add(url="path/to/ChargedParticles.jl")
```

## Usage

```julia
using ChargedParticles

# Create basic particles
e = electron()  # Creates an electron (e⁻)
p = proton()    # Creates a proton (p⁺)

# Create custom ions
he = ChargedParticle(:He, 2, 4)  # Doubly ionized helium-4
li = ChargedParticle(:Li, 1, 7)  # Singly ionized lithium-7

# Access properties
mass(e)            # Returns electron mass in atomic mass units
charge(he)         # Returns helium charge (+2e)
atomic_number(li)  # Returns lithium atomic number (3)
mass_number(he)    # Returns helium mass number (4)

# Check particle types
is_electron(e)  # true
is_proton(p)    # true
is_ion(he)      # true
```

## Dependencies

- Unitful.jl: For handling physical units
- UnitfulAtomic.jl: For atomic units
- PeriodicTable.jl: For element properties

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
