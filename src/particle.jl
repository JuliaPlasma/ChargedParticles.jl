"""
    particle(str::AbstractString; mass_numb=nothing, z=nothing, typed=false)

Create a particle from a string representation.

# Arguments
- `str::AbstractString`: String representation of the particle
- `mass_numb`: Optional mass number override
- `z`: Optional charge number override
- `typed`: If true, creates a type-parameterized SParticle instead of a regular Particle

# String Format Support
- Element symbols: `"Fe"`, `"He"`
- Isotopes: `"Fe-56"`, `"D"`
- Ions: `"Fe2+"`, `"H-"`
- Common aliases: `"electron"`, `"proton"`, `"alpha"`, `"mu-"`

# Examples
```jldoctest; output = false
# Elementary particles
electron = particle("e-")
muon = particle("mu-")
positron = particle("e+")

# Ions and isotopes
proton = particle("H+")
alpha = particle("He2+")
deuteron = particle("D+")
iron56 = particle("Fe-56")
# output
Fe
```
"""
function particle(str::AbstractString; mass_numb=nothing, z=nothing, typed=false)
    # Check aliases first
    if haskey(PARTICLE_ALIASES, str)
        result = PARTICLE_ALIASES[str]
        if result isa Tuple
            symbol, charge, mass_number = result
            symbol = Symbol(symbol)
            return typed ? SParticle(charge, elements[symbol].number, mass_number) : Particle(symbol, charge, mass_number)
        else
            return eval(result)()
        end
    end

    # Try to parse as element with optional mass number and charge
    result = parse_particle_string(str)
    if !isnothing(result)
        (symbol, parsed_charge, parsed_mass_numb) = result
        element = elements[symbol]
        charge = determine(parsed_charge, z; default=0)
        mass_number = determine(parsed_mass_numb, mass_numb; default=element.mass_number)
        return typed ? SParticle(charge, element.number, mass_number) : Particle(symbol, charge, mass_number)
    end
    throw(ArgumentError("Invalid particle string format: $str"))
end

"""
    particle(sym::Symbol)

Create a particle from its symbol representation.

# Examples
```jldoctest; output = false
# Elementary particles
electron = particle(:e)
muon = particle(:muon)
proton = particle(:p)
# output
H⁺
```
"""
particle(sym::Symbol; kwargs...) = particle(string(sym); kwargs...)

particle(s::Symbol, charge_number::Int, mass_number::Int; typed::Bool=false) =
    typed ? SParticle(charge_number, elements[s].number, mass_number) :
    Particle(s, charge_number, mass_number)


"""
    particle(atomic_number::Int; mass_numb=nothing, z=0, typed=false)

Create a particle from its atomic number with optional mass number and charge state.

# Arguments
- `atomic_number::Int`: The atomic number (number of protons)
- `mass_numb=nothing`: Optional mass number (total number of nucleons)
- `z=0`: Optional charge number (in elementary charge units)
- `typed=false`: If true, creates a type-parameterized SParticle instead of a regular Particle

# Examples
```jldoctest; output = false
# Basic construction
iron = particle(26)        # Iron
u = particle(92)          # Uranium

# With mass number and charge
fe56_3plus = particle(26, mass_numb=56, z=3)  # Fe-56³⁺
he4_2plus = particle(2, mass_numb=4, z=2)     # ⁴He²⁺ (alpha particle)
# output
He²⁺
```

See also: [`particle(::AbstractString)`](@ref)
"""
function particle(atomic_number::Int; mass_numb=nothing, z=0, typed=false)
    element = elements[atomic_number]
    mass_number = something(mass_numb, element.mass_number)
    return typed ? SParticle(z, atomic_number, mass_number) : Particle(symbol(element), z, mass_number)
end

Particle(atomic_number::Int; mass_numb=nothing, z=0) = particle(atomic_number; mass_numb, z, typed=false)
Particle(str::AbstractString; mass_numb=nothing, z=nothing) = particle(str; mass_numb, z, typed=false)
Particle(sym::Symbol; kwargs...) = particle(string(sym); kwargs...)