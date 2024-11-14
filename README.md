# ChargedParticles.jl

[![Build Status](https://github.com/Beforerr/ChargedParticles.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Beforerr/ChargedParticles.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://beforerr.github.io/ChargedParticles.jl/dev/) 

A Julia package for working with charged particles in plasma physics, inspired by [PlasmaPy](https://github.com/PlasmaPy/PlasmaPy)'s particles subpackage .

## Features

- Support for common particles (electrons, protons)
- Custom ion creation with arbitrary charge states
- Basic particle properties (mass, charge, atomic number)
- Type checking functions (is_electron, is_proton, is_ion)
- Pretty printing of particle representations

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/Beforerr/ChargedParticles.jl")
```

## Dependencies

- Unitful.jl: For handling physical units
- [Mendeleev.jl](https://github.com/Eben60/Mendeleev.jl): For periodic table data

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
