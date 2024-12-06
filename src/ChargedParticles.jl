module ChargedParticles

using Unitful
using Mendeleev
using Match
using Unitful: me, mp

const elements = chem_elements

include("./types.jl")
include("./particle.jl")
include("./properties.jl")
include("./aliases.jl")
include("./utils.jl")
include("./typed_particles.jl")
include("./custom_particles.jl")
include("./special_particles.jl")
include("./display.jl")

export AbstractParticle, Particle, SParticle, CustomParticle
export Electron, Muon, Neutron
export mass, charge, charge_number, atomic_number, mass_number, element, mass_energy, particle_symbol
export is_ion, is_chemical_element, is_default_isotope
export particle, electron, proton
end