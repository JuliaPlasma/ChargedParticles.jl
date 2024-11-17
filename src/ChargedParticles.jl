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
include("./custom_particles.jl")
include("./_special_particles.jl")

export AbstractParticle, Particle, CustomParticle
export mass, charge, charge_number, atomic_number, mass_number, element, mass_energy
export is_ion, is_chemical_element, is_default_isotope
export electron, proton
end