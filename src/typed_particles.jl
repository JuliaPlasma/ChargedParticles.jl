"""
    SParticle{z, Z, A} <: AbstractParticle

Type-parameterized particle implementation. 

`z` for charge, `Z` for atomic number, and `A` for mass number.
"""
struct SParticle{z,Z,A} <: AbstractParticle
    function SParticle{z,Z,A}() where {z,Z,A}
        @assert all(x -> x isa Integer, (z, Z, A)) "All parameters must be integers"
        new{z,Z,A}()
    end
end

SParticle(z, Z, A) = SParticle{z,Z,A}()

# Basic properties - use single type parameter where possible
charge_number(::SParticle{z}) where {z} = z
atomic_number(::SParticle{z,Z}) where {z,Z} = Z
mass_number(::SParticle{z,Z,A}) where {z,Z,A} = A

element(::SParticle{z,Z}) where {z,Z} = elements[Z]
symbol(p::SParticle) = element(p).symbol