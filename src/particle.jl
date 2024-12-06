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

Particle(str::AbstractString; mass_numb=nothing, z=nothing, typed=false) = particle(str; mass_numb, z, typed)
Particle(sym::Symbol; kwargs...) = particle(string(sym); kwargs...)