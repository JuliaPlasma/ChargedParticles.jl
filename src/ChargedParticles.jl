module ChargedParticles

using Unitful
using UnitfulAtomic
using Mendeleev
using Mendeleev: elements # for PeriodicTable compatibility
using Match
using Unitful: me, mp

export AbstractParticle, Particle, ChargedParticleImpl
export mass, charge, atomic_number, mass_number
export is_ion
export electron, proton

# Common particle aliases
"""
    PARTICLE_ALIASES

Dictionary of common particle aliases and their corresponding (symbol, charge, mass_number) tuples.

Each entry maps a string alias to a tuple of (symbol, charge, mass_number)
"""
PARTICLE_ALIASES = Dict(
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
    AbstractParticle

Abstract type representing any particle in plasma physics.

See also: [`ChargedParticleImpl`](@ref)
"""
abstract type AbstractParticle end

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
    Particle(str::AbstractString)

Create a particle from a string representation.

# Arguments
- `str::AbstractString`: String representation of the particle

# String Format Support
- Element symbols: `"Fe"`, `"He"`
- Isotopes: `"Fe-56"`, `"D"`
- Ions: `"Fe2+"`, `"H-"`
- Common aliases: `"electron"`, `"proton"`, `"alpha"`, `"mu-"`

# Examples
```julia
# Elementary particles
electron = Particle("e-")     # electron
muon = Particle("mu-")        # muon
positron = Particle("e+")     # positron

# Ions and isotopes
proton = Particle("H+")       # proton
alpha = Particle("He2+")      # alpha particle
deuteron = Particle("D+")     # deuterium ion
iron56 = Particle("Fe-56")    # iron-56 isotope
```
"""
function Particle(str::AbstractString; mass_numb=nothing)
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
        parsed_mass_numb = isnothing(mass_str) ? nothing : parse(Int, mass_str)
        # Get charge
        charge = if isnothing(charge_sign)
            0
        else
            magnitude = isnothing(charge_magnitude) ? 1 : parse(Int, charge_magnitude)
            charge_sign == "+" ? magnitude : -magnitude
        end
        mass = elements[symbol].atomic_mass

        if isnothing(mass_numb) && isnothing(parsed_mass_numb)
            mass_numb = elements[symbol].mass_number
        elseif isnothing(mass_numb) && !isnothing(parsed_mass_numb)
            mass_numb = parsed_mass_numb
        elseif !isnothing(mass_numb) && !isnothing(parsed_mass_numb)
            @assert mass_numb == parsed_mass_numb
        end

        return ChargedParticleImpl(symbol, charge, mass_numb, mass)
    end
    throw(ArgumentError("Invalid particle string format: $str"))
end

"""
    Particle(atomic_number::Int; mass_numb=nothing, Z=0)

Create a particle from its atomic number with optional mass number and charge state.

# Arguments
- `atomic_number::Int`: The atomic number (number of protons)
- `mass_numb=nothing`: Optional mass number (total number of nucleons)
- `Z=0`: Optional charge number (in elementary charge units)

# Examples
```julia
# Basic construction
iron = Particle(26)        # Iron
u = Particle(92)          # Uranium

# With mass number and charge
fe56_3plus = Particle(26, mass_numb=56, Z=3)  # Fe-56³⁺
he4_2plus = Particle(2, mass_numb=4, Z=2)     # He⁴²⁺ (alpha particle)
```

See also: [`Particle(::AbstractString)`](@ref)
"""
function Particle(atomic_number::Int; mass_numb=nothing, Z=0)
    element = elements[atomic_number]
    mass_number = isnothing(mass_numb) ? element.mass_number : mass_numb
    ChargedParticleImpl(element.symbol, Z, mass_number, element.atomic_mass)
end

# Convenience constructors for common particles
"""Create an electron"""
electron() = ChargedParticleImpl(:e, -1, 0, me)
"""Create a proton"""
proton() = ChargedParticleImpl(:H, 1, 1, mp)

# Basic properties
"""Return the mass of the particle in atomic mass units"""
mass(p::AbstractParticle) = p.mass

"""Return the electric charge of the particle in elementary charge units"""
charge(p::AbstractParticle) = p.charge_number * Unitful.q

"""
    atomic_number(p::AbstractParticle)

Return the atomic number (number of protons) of the particle.

# Examples
```julia
fe = Particle("Fe")
println(atomic_number(fe))  # 26

e = electron()
println(atomic_number(e))  # 0
```
"""
function atomic_number(p::AbstractParticle)
    if p.symbol in [:e, :μ, :n]
        return 0
    else
        return elements[p.symbol].atomic_number
    end
end

"""
    mass_number(p::AbstractParticle)

Return the mass number (total number of nucleons) of the particle.

# Examples
```julia
fe56 = Particle("Fe-56")
println(mass_number(fe56))  # 56

e = electron()
println(mass_number(e))  # 0
```
"""
mass_number(p::AbstractParticle) = p.mass_number

"""
    is_ion(p::AbstractParticle)

Check if the particle is an ion (has non-zero charge and is not an elementary particle).

# Examples
```julia
fe3 = Particle("Fe3+")
println(is_ion(fe3))  # true

e = electron()
println(is_ion(e))  # false
```
"""
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