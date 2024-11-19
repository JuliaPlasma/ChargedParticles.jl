"""
    AbstractParticle

Abstract type representing any particle in plasma physics.
"""
abstract type AbstractParticle end

"""
    AbstractChargeParticle <: AbstractParticle

Abstract type representing any particle that could carry an electric charge.
"""
abstract type AbstractChargeParticle <: AbstractParticle end

"""
    AbstractFermion <: AbstractParticle

Abstract type representing fermions (particles with half-integer spin).
"""
abstract type AbstractFermion <: AbstractParticle end

"""
    AbstractLepton <: AbstractFermion

Abstract type representing leptons (electron, muon, tau and their neutrinos).
"""
abstract type AbstractLepton <: AbstractFermion end

"""
    AbstractQuark <: AbstractFermion

Abstract type representing quarks (up, down, charm, strange, top, bottom).
"""
abstract type AbstractQuark <: AbstractFermion end

# Type for particle-like inputs
const ParticleLike = Union{AbstractParticle,Symbol,AbstractString}

"""
    Particle <: AbstractChargeParticle

Implementation type for charged particles.

# Fields
- `symbol::Symbol`: Chemical symbol or particle identifier (e.g., :Fe, :e, :μ)
- `charge_number::Int`: Number of elementary charges (can be negative)
- `mass_number::Int`: Total number of nucleons (protons + neutrons). If not provided, defaults to the most common isotope mass number

# Notes
- Mass number : For elementary particles like electrons and muons, `mass_number` is 0
- Charge number : electrical charge in units of the elementary charge, usually denoted as z. https://en.wikipedia.org/wiki/Charge_number

# Examples
```jldoctest
Particle(:Fe, 2)  # Creates Fe²⁺ with default mass number
# output
Fe²⁺
```
"""
struct Particle <: AbstractChargeParticle
    symbol::Symbol
    charge_number::Int
    mass_number::Int
    function Particle(symbol, charge_number, mass_number=nothing)
        if isnothing(mass_number)
            mass_number = elements[symbol].mass_number
        else
            mass_number >= 0 || throw(ArgumentError("Mass number must be non-negative, got $mass_number"))
        end
        new(symbol, charge_number, mass_number)
    end
end

"""
    Particle(p::AbstractParticle)

Create a particle from another particle implementation, optionally specifying mass number and charge to override.

# Examples
```jldoctest; output = false
p = Particle("Fe2+")
p2 = Particle(p; mass_numb=54, z=3)  # Creates a new instance with same properties
# output
Fe-54³⁺
```
"""
function Particle(p::AbstractParticle; mass_numb=nothing, z=nothing)
    mass_number = something(mass_numb, p.mass_number)
    charge_number = something(z, p.charge_number)
    Particle(p.symbol, charge_number, mass_number)
end

"""
    Particle(atomic_number::Int; mass_numb=nothing, z=0)

Create a particle from its atomic number with optional mass number and charge state.

# Arguments
- `atomic_number::Int`: The atomic number (number of protons)
- `mass_numb=nothing`: Optional mass number (total number of nucleons)
- `z=0`: Optional charge number (in elementary charge units)

# Examples
```jldoctest; output = false
# Basic construction
iron = Particle(26)        # Iron
u = Particle(92)          # Uranium

# With mass number and charge
fe56_3plus = Particle(26, mass_numb=56, z=3)  # Fe-56³⁺
he4_2plus = Particle(2, mass_numb=4, z=2)     # ⁴He²⁺ (alpha particle)
# output
He²⁺
```

See also: [`Particle(::AbstractString)`](@ref)
"""
function Particle(atomic_number::Int; mass_numb=nothing, z=0)
    element = elements[atomic_number]
    mass_number = something(mass_numb, element.mass_number)
    Particle(element.symbol, z, mass_number)
end

"""Create a proton"""
proton() = Particle(:p, 1, 1)