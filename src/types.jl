"""
    AbstractParticle

Abstract type representing any particle in plasma physics.

See also: [`ChargedParticleImpl`](@ref)
"""
abstract type AbstractParticle end

# Type for particle-like inputs
const ParticleLike = Union{AbstractParticle,Symbol,AbstractString}

"""
    ChargedParticleImpl <: AbstractParticle

Implementation type for charged particles.

# Fields
- `symbol::Symbol`: Chemical symbol or particle identifier (e.g., :Fe, :e, :μ)
- `charge_number::Int`: Number of elementary charges (can be negative)
- `mass_number::Int`: Total number of nucleons (protons + neutrons)
- `mass::Unitful.Mass`: Mass of the particle in appropriate units

# Notes
- Mass number : For elementary particles like electrons and muons, `mass_number` is 0
- Charge number : electrical charge in units of the elementary charge, usually denoted as z. https://en.wikipedia.org/wiki/Charge_number
"""
@kwdef struct ChargedParticleImpl <: AbstractParticle
    symbol::Symbol
    charge_number::Int
    mass_number::Int
    mass::Unitful.Mass
end

"""
    Particle(str::AbstractString; mass_numb=nothing, Z=nothing)

Create a particle from a string representation.

# Arguments
- `str::AbstractString`: String representation of the particle

# String Format Support
- Element symbols: `"Fe"`, `"He"`
- Isotopes: `"Fe-56"`, `"D"`
- Ions: `"Fe2+"`, `"H-"`
- Common aliases: `"electron"`, `"proton"`, `"alpha"`, `"mu-"`

# Examples
```jldoctest; output = false
# Elementary particles
electron = Particle("e-")
muon = Particle("mu-")
positron = Particle("e+")

# Ions and isotopes
proton = Particle("H+")
alpha = Particle("He2+")
deuteron = Particle("D+")
iron56 = Particle("Fe-56")
# output
Fe
```
"""
function Particle(str::AbstractString; mass_numb=nothing, Z=nothing)
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
    result = parse_particle_string(str)
    if !isnothing(result)
        (symbol, parsed_charge, parsed_mass_numb) = result
        element = elements[symbol]
        charge = determine(parsed_charge, Z; default=0)
        mass_number = determine(parsed_mass_numb, mass_numb; default=element.mass_number)
        mass = ChargedParticles.mass(element, mass_number)
        return ChargedParticleImpl(symbol, charge, mass_number, mass)
    end
    throw(ArgumentError("Invalid particle string format: $str"))
end

"""
    Particle(sym::Symbol)

Create a particle from its symbol representation.

# Examples
```jldoctest; output = false
# Elementary particles
electron = Particle(:e)
muon = Particle(:muon)
proton = Particle(:p)
# output
H⁺
```
"""
Particle(sym::Symbol; kwargs...) = Particle(string(sym); kwargs...)

"""
    Particle(atomic_number::Int; mass_numb=nothing, Z=0)

Create a particle from its atomic number with optional mass number and charge state.

# Arguments
- `atomic_number::Int`: The atomic number (number of protons)
- `mass_numb=nothing`: Optional mass number (total number of nucleons)
- `Z=0`: Optional charge number (in elementary charge units)

# Examples
```jldoctest; output = false
# Basic construction
iron = Particle(26)        # Iron
u = Particle(92)          # Uranium

# With mass number and charge
fe56_3plus = Particle(26, mass_numb=56, Z=3)  # Fe-56³⁺
he4_2plus = Particle(2, mass_numb=4, Z=2)     # ⁴He²⁺ (alpha particle)
# output
He²⁺
```

See also: [`Particle(::AbstractString)`](@ref)
"""
function Particle(atomic_number::Int; mass_numb=nothing, Z=0)
    element = elements[atomic_number]
    mass_number = isnothing(mass_numb) ? element.mass_number : mass_numb
    mass = ChargedParticles.mass(element, mass_number)
    ChargedParticleImpl(element.symbol, Z, mass_number, mass)
end

# Convenience constructors for common particles
"""Create an electron"""
electron() = ChargedParticleImpl(:e, -1, 0, me)
"""Create a proton"""
proton() = ChargedParticleImpl(:p, 1, 1, mp)