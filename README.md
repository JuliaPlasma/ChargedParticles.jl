# ChargedParticles.jl

[![Build Status](https://github.com/JuliaPlasma/ChargedParticles.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaPlasma/ChargedParticles.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://JuliaPlasma.github.io/ChargedParticles.jl/dev/) 

A Julia package for representing charged particles inspired by [PlasmaPy](https://github.com/PlasmaPy/PlasmaPy)'s particles subpackage.

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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
