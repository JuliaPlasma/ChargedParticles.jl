module ChargedParticles

using Unitful
using UnitfulAtomic
using Mendeleev
using Mendeleev: elements # for PeriodicTable compatibility
using Match
using Unitful: me, mp

export Particle
export mass, charge, atomic_number, mass_number
export is_ion
export electron, proton

# Common particle aliases
const PARTICLE_ALIASES = Dict(
    "electron" => ("e", -1, 0),
    "e-" => ("e", -1, 0),
    "e+" => ("e", 1, 0),
    "positron" => ("e", 1, 0),
    "proton" => ("H", 1, 1),
    "p+" => ("H", 1, 1),
    "p" => ("H", 1, 1),
    "neutron" => ("n", 0, 1),
    "n" => ("n", 0, 1),
    "alpha" => ("He", 2, 4),
    "deuteron" => ("H", 1, 2),
    "D+" => ("H", 1, 2),
    "tritium" => ("H", 0, 3),
    "T" => ("H", 0, 3),
    "triton" => ("H", 1, 3),
    "T+" => ("H", 1, 3),
    "mu-" => ("μ", -1, 0),
    "muon" => ("μ", -1, 0),
    "antimuon" => ("μ", 1, 0),
    "mu+" => ("μ", 1, 0),
)

"""
Abstract type representing any particle in plasma physics
"""
abstract type AbstractParticle end

"""
    ChargedParticleImpl

Internal implementation of a charged particle with properties like mass, charge, and atomic properties.

# Fields

- symbol::Symbol : Chemical symbol of the particle
- charge_number::Int : Number of elementary charges (can be negative)
- mass_number::Int : Total number of nucleons (protons + neutrons) (for elements, the most abundant isotope)

# Notes
- Charge number : electrical charge in units of the elementary charge, usually denoted as z. # https://en.wikipedia.org/wiki/Charge_number
"""
@kwdef struct ChargedParticleImpl <: AbstractParticle
    symbol::Symbol
    charge_number::Int
    # atomic_number::Int
    mass_number::Int
    mass::Unitful.Mass
end

"""
    Particle(particle_string::AbstractString)

Create a particle from a string representation.
Supports various formats:
- Element symbols with optional mass number and charge (e.g., "Fe-56", "H+", "He2+")
- Common particle names (e.g., "electron", "proton", "alpha")
- Special particles (e.g., "e-", "mu+", "D+")

Examples:
```julia
electron = Particle("e-")
alpha = Particle("alpha")
deuteron = Particle("D+")
iron56 = Particle("Fe-56")
```
"""
function Particle(str::AbstractString)
    # Check aliases first
    if haskey(PARTICLE_ALIASES, str)
        symbol, charge, mass_number = PARTICLE_ALIASES[str]
        # Get mass based on particle type
        mass = @match symbol begin
            "e" => me
            "μ" => 206.7682827me
            "n" => Unitful.mn
            _ => elements[Symbol(symbol)].atomic_mass
        end
        return ChargedParticleImpl(Symbol(symbol), charge, mass_number, mass)
    end
    # Try to parse as element with optional mass number and charge
    m = match(r"^([A-Za-z]+)(?:-([\d]+))?(?:\s*(\d+)?([+-]))?$", str)
    if !isnothing(m)
        element_str, mass_str, charge_magnitude, charge_sign = m.captures
        # Parse 
        symbol = Symbol(element_str)
        mass_number = isnothing(mass_str) ? elements[symbol].mass_number : parse(Int, mass_str)
        # Get charge
        charge = if isnothing(charge_sign)
            0
        else
            magnitude = isnothing(charge_magnitude) ? 1 : parse(Int, charge_magnitude)
            charge_sign == "+" ? magnitude : -magnitude
        end
        mass = elements[symbol].atomic_mass
        return ChargedParticleImpl(symbol, charge, mass_number, mass)
    end
    throw(ArgumentError("Invalid particle string format: $str"))
end

"""
    Particle(atomic_number::Int; mass_numb::Union{Int,Nothing}=nothing, Z::Int=0)

Create a particle from its atomic number, with optional mass number and charge state.

Examples:
```julia
proton = Particle(1, mass_numb=1, Z=1)
helium = Particle(2, mass_numb=4, Z=2)
```
"""
function Particle(atomic_number::Int; mass_numb=nothing, Z=0)
    element = elements[atomic_number]
    mass_number = isnothing(mass_numb) ? element.mass_number : mass_numb
    ChargedParticleImpl(element.symbol, Z, mass_number, element.atomic_mass)
end

# Convenience constructors for common particles
electron() = ChargedParticleImpl(:e, -1, 0, me)
proton() = ChargedParticleImpl(:H, 1, 1, mp)

# Basic properties
"""Return the mass of the particle in atomic mass units"""
mass(p::AbstractParticle) = p.mass

"""Return the charge of the particle in elementary charge units"""
charge(p::AbstractParticle) = p.charge_number * Unitful.q

"""Return the atomic number (number of protons)"""
function atomic_number(p::AbstractParticle)
    if p.symbol in [:e, :μ, :n]
        return 0
    else
        return elements[p.symbol].atomic_number
    end
end

"""Return the mass number (total number of nucleons)"""
function mass_number(p::AbstractParticle)
    if p.symbol in [:e, :μ, :n]
        return 0
    else
        return p.mass_number
    end
end

# Type checking functions
is_ion(p::AbstractParticle) = !(p.symbol in [:e, :μ]) && p.charge_number != 0
is_electron(p) = p.symbol == :e && p.charge_number == -1 && p.mass == me
is_proton(p) = p.symbol == :H && p.charge_number == 1 && p.mass_number == 1

# String representation
function Base.show(io::IO, p::AbstractParticle)
    if is_electron(p)
        print(io, "e⁻")
    elseif is_proton(p)
        print(io, "p⁺")
    else
        charge_str = if p.charge_number > 0
            "$(p.charge_number)+"
        elseif p.charge_number < 0
            "$(abs(p.charge_number))-"
        else
            ""
        end
        print(io, "$(p.symbol)$(p.mass_number)$(charge_str)")
    end
end

end