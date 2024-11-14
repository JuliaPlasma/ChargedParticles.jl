module ChargedParticles

using Unitful
using Mendeleev
using Mendeleev: elements # for PeriodicTable compatibility
using Match
using Unitful: me, mp

const ELEMENTARY_PARTICLES = (:e, :μ, :n)

include("./types.jl")
include("./properties.jl")
include("./aliases.jl")
include("./utils.jl")
include("./display.jl")

export AbstractParticle, Particle, ChargedParticleImpl
export mass, charge, atomic_number, mass_number
export is_ion, is_chemical_element, is_default_isotope
export electron, proton
end