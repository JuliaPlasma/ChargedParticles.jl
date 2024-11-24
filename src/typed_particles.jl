"""
    SParticle{z, Z, A} <: AbstractParticle

A type-parameterized implementation of a particle.

# Type Parameters
- `z::Integer`: The charge number (number of elementary charges)
- `Z::Integer`: The atomic number (number of protons)
- `A::Integer`: The mass number (total number of nucleons)

# Constructors
- `SParticle{z,Z,A}() / SParticle{z,Z,A}`: Construct a particle
- `SParticle(p::AbstractParticle)`: Convert any AbstractParticle to an SParticle

All parameters must be integers. The type ensures this at construction time.

# Examples
```julia
# Create a proton (H+)
proton = SParticle(1, 1, 1)

# Create an alpha particle (He2+)
alpha = SParticle{2,2,4}()
```
"""
struct SParticle{z,Z,A} <: AbstractParticle
    function SParticle{z,Z,A}() where {z,Z,A}
        @assert all(x -> x isa Integer, (z, Z, A)) "All parameters must be integers"
        new{z,Z,A}()
    end
end

SParticle(z, Z, A) = SParticle{z,Z,A}()
SParticle(p::AbstractParticle) = SParticle(charge_number(p), atomic_number(p), mass_number(p))

# Basic properties - use single type parameter where possible
charge_number(::SParticle{z}) where {z} = z
atomic_number(::SParticle{z,Z}) where {z,Z} = Z
mass_number(::SParticle{z,Z,A}) where {z,Z,A} = A

element(::SParticle{z,Z}) where {z,Z} = elements[Z]
symbol(p::SParticle) = element(p).symbol