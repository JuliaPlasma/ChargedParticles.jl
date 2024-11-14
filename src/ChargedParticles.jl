module ChargedParticles

using Unitful
using UnitfulAtomic
using PeriodicTable

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

Fields:
- symbol::Symbol : Chemical symbol of the particle
- charge_number::Int : Number of elementary charges (can be negative)
- mass_number::Int : Total number of nucleons (protons + neutrons)
"""
struct ChargedParticleImpl <: AbstractParticle
    symbol::Symbol
    charge_number::Int
    mass_number::Int

    function ChargedParticleImpl(symbol::Symbol, charge_number::Int, mass_number::Int)
        # Special cases for non-elements
        if symbol in [:e, :μ, :n]
            return new(symbol, charge_number, mass_number)
        end

        # Validate inputs for elements
        element = elements[symbol]
        if mass_number < 0
            throw(ArgumentError("Mass number must be non-negative"))
        end
        new(symbol, charge_number, mass_number)
    end
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
function Particle(particle_string::AbstractString)
    # Check aliases first
    if haskey(PARTICLE_ALIASES, particle_string)
        symbol, charge, mass = PARTICLE_ALIASES[particle_string]
        return ChargedParticleImpl(Symbol(symbol), charge, mass)
    end

    # Try to parse as element with optional mass number and charge
    # Patterns: "Fe", "Fe-56", "Fe2+", "Fe-56 2+", "Fe 2+"
    m = match(r"^([A-Za-z]+)(?:-?(\d+))?(?:\s*(\d+)?([+-]))?$", particle_string)
    if !isnothing(m)
        element_str, mass_str, charge_magnitude, charge_sign = m.captures

        # Get element symbol (case-sensitive)
        symbol = Symbol(element_str)

        # Get mass number
        mass_number = isnothing(mass_str) ? round(Int, elements[symbol].atomic_mass) : parse(Int, mass_str)

        # Get charge
        charge = if isnothing(charge_sign)
            0
        else
            magnitude = isnothing(charge_magnitude) ? 1 : parse(Int, charge_magnitude)
            charge_sign == "+" ? magnitude : -magnitude
        end

        return ChargedParticleImpl(symbol, charge, mass_number)
    end

    throw(ArgumentError("Invalid particle string format: $particle_string"))
end

"""
    Particle(atomic_number::Int; mass_numb::Union{Int,Nothing}=nothing, Z::Union{Int,Nothing}=nothing)

Create a particle from its atomic number, with optional mass number and charge state.

Examples:
```julia
proton = Particle(1, mass_numb=1, Z=1)
helium = Particle(2, mass_numb=4, Z=2)
```
"""
function Particle(atomic_number::Int; mass_numb::Union{Int,Nothing}=nothing, Z::Union{Int,Nothing}=nothing)
    if atomic_number < 0
        throw(ArgumentError("Atomic number must be non-negative"))
    end

    if atomic_number == 0
        throw(ArgumentError("Atomic number cannot be 0"))
    end

    element = elements[atomic_number]
    mass_number = isnothing(mass_numb) ? round(Int, element.atomic_mass) : mass_numb
    charge = isnothing(Z) ? 0 : Z

    ChargedParticleImpl(Symbol(element.symbol), charge, mass_number)
end

# Convenience constructors for common particles
electron() = ChargedParticleImpl(:e, -1, 0)
proton() = ChargedParticleImpl(:H, 1, 1)

# Basic properties
"""Return the mass of the particle in atomic mass units"""
function mass(p::AbstractParticle)
    if p.symbol == :e
        return 5.485799090e-4u"u"
    elseif p.symbol == :μ
        return 0.1134289257u"u"
    elseif p.symbol == :n
        return 1.008664915823u"u"
    else
        element = elements[p.symbol]
        return element.atomic_mass * u"u"
    end
end

"""Return the charge of the particle in elementary charge units"""
charge(p::AbstractParticle) = p.charge_number * Unitful.q

"""Return the atomic number (number of protons)"""
function atomic_number(p::AbstractParticle)
    if p.symbol in [:e, :μ, :n]
        return 0
    else
        elements[p.symbol].number
    end
end

"""Return the mass number (total number of nucleons)"""
mass_number(p::AbstractParticle) = p.mass_number

# Type checking functions
is_ion(p::AbstractParticle) = !(p.symbol in [:e, :μ]) && p.charge_number != 0

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