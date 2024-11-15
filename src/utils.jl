"""
    is_ion(p::AbstractParticle)

Check if the particle is an ion (has non-zero charge and is not an elementary particle).

# Examples

```jldoctest
julia> is_ion(Particle("Fe3+"))
true
julia> is_ion(Particle("Fe"))
false
julia> is_ion(electron())
false
```
"""
is_ion(p::AbstractParticle) = !(p.symbol in ELEMENTARY_PARTICLES) && p.charge_number != 0

"""
    is_chemical_element(p::AbstractParticle)

Check if the particle is a chemical element.

# Examples

```jldoctest
julia> is_chemical_element(Particle("Fe"))
true
julia> is_chemical_element(electron())
false
```
"""
is_chemical_element(p) = haskey(elements, p.symbol) ? true : false

"""
    is_default_isotope(p::AbstractParticle)

Check if the particle is the default isotope of its element.

# Examples

```jldoctest
julia> is_default_isotope(Particle("Fe-56"))
true
julia> is_default_isotope(Particle("Fe-57"))
false
```
"""
is_default_isotope(p) = mass_number(p) == element(p).mass_number

"""
    is_electron(p::AbstractParticle)

Check if the particle is an electron (has symbol 'e', charge -1, and electron mass).

# Examples

```jldoctest
julia> ChargedParticles.is_electron(electron())
true
julia> ChargedParticles.is_electron(proton())
false
```
"""
is_electron(p) = p.symbol == :e && p.charge_number == -1 && p.mass == me

"""
    is_proton(p::AbstractParticle)

Check if the particle is a proton (has symbol 'H', charge +1, and mass number 1).

# Examples

```jldoctest
julia> ChargedParticles.is_proton(proton())
true
julia> ChargedParticles.is_proton(electron())
false
```
"""
is_proton(p) = (p.symbol in [:H, :p]) && p.charge_number == 1 && p.mass_number == 1



# Helper function to determine the value of x or y
function determine(x, y; default=nothing)
    @match (x, y) begin
        ($nothing, $nothing) => default
        (x, $nothing) => x
        ($nothing, y) => y
        (x, y) => x == y ? x : throw(ArgumentError("Inconsistent $x and $y"))
    end
end

function parse_particle_string(str::AbstractString)
    pattern = r"^([A-Za-z]+)(?:-([\d]+))?(?:\s*(\d+)?([+-]))?$"
    m = match(pattern, str)
    if isnothing(m)
        return nothing
    else
        element_str, mass_str, charge_magnitude, charge_sign = m.captures
        symbol = Symbol(element_str)
        mass_number = isnothing(mass_str) ? nothing : parse(Int, mass_str)
        charge = if isnothing(charge_sign)
            nothing
        else
            magnitude = isnothing(charge_magnitude) ? 1 : parse(Int, charge_magnitude)
            charge_sign == "+" ? magnitude : -magnitude
        end
        return (symbol, charge, mass_number)
    end
end

function _format_energy(erg::Unitful.Energy)
    if erg > 1u"MeV"
        return uconvert(u"MeV", erg)
    elseif erg > 1u"keV"
        return uconvert(u"keV", erg)
    else
        return erg
    end
end