"""
    CustomParticle <: AbstractParticle

A particle with user-defined mass and charge.

# Fields
- `mass`: The mass of the particle (can be any numeric type or Unitful quantity)
- `charge_number`: Integer representing the charge state
- `symbol`: Optional symbol identifier (defaults to nothing)

# Examples
```julia
CustomParticle(1.67e-27u"kg", 1)  # A particle with proton-like mass and +1 charge
CustomParticle(2.0u"GeV", -1, :custom)  # A custom particle with specified symbol
```
"""
@kwdef struct CustomParticle <: AbstractParticle
    mass::Unitful.Mass
    charge_number::Int
    symbol::Symbol
    function CustomParticle(mass, charge_number, symbol=:custom)
        new(mass, charge_number, symbol)
    end
end

function CustomParticle(mass_energy::Unitful.Energy, charge_number, symbol=:custom)
    mass = uconvert(u"kg", mass_energy / Unitful.c^2)
    CustomParticle(mass, charge_number, symbol)
end

# Override mass method for CustomParticle
mass(p::CustomParticle) = p.mass
# CustomParticle doesn't have a mass number
mass_number(::CustomParticle) = nothing
# CustomParticle doesn't have an element
element(::CustomParticle) = nothing