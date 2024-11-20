# Common particle aliases

const ELECTRON_ALIASES = ("electron", "e-", "e")
const PROTON_ALIASES = ("proton", "p+", "p", "H+")
const POSITRON_ALIASES = ("positron", "e+")
const NEUTRON_ALIASES = ("neutron", "n")
const MUON_ALIASES = ("muon", "μ", "μ-", "mu-", "mu")

"""
    PARTICLE_ALIASES

Dictionary of common particle aliases and their corresponding (symbol, charge, mass_number) tuples.

Each entry maps a string alias to a tuple of (symbol, charge, mass_number)
"""
PARTICLE_ALIASES = Dict(
    (PROTON_ALIASES .=> Ref(("H", 1, 1)))...,
    (ELECTRON_ALIASES .=> :Electron)...,
    (NEUTRON_ALIASES .=> :Neutron)...,
    (POSITRON_ALIASES .=> :Positron)...,
    (MUON_ALIASES .=> :Muon)...,
    "alpha" => ("He", 2, 4),
    "deuteron" => ("H", 1, 2),
    "D+" => ("H", 1, 2),
    "tritium" => ("H", 0, 3),
    "T" => ("H", 0, 3),
    "triton" => ("H", 1, 3),
    "T+" => ("H", 1, 3),
    "mu-" => :Muon,
    "muon" => :Muon,
    "antimuon" => ("μ", 1, 0),
    "mu+" => ("μ", 1, 0),
)