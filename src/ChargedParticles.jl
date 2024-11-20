module ChargedParticles

using Unitful
using Mendeleev
using Mendeleev: elements # for PeriodicTable compatibility
using Match
using Unitful: me, mp

include("./types.jl")
include("./particle.jl")
include("./properties.jl")
include("./aliases.jl")
include("./utils.jl")
include("./display.jl")
include("./custom_particles.jl")
include("./special_particles.jl")

export AbstractParticle, Particle, CustomParticle
export Electron, Muon, Neutron
export mass, charge, charge_number, atomic_number, mass_number, element, mass_energy
export is_ion, is_chemical_element, is_default_isotope
export particle, electron, proton
end