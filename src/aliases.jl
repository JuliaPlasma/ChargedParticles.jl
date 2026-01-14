# Common particle aliases

const ELECTRON_ALIASES = ("electron", "e-", "e")
const PROTON_ALIASES = ("proton", "p+", "p", "H+")
const POSITRON_ALIASES = ("positron", "e+")
const NEUTRON_ALIASES = ("neutron", "n")
const MUON_ALIASES = ("muon", "μ", "μ-", "mu-", "mu")
const ANTIMUON_ALIASES = ("antimuon", "μ+", "mu+")

# Dictionary of common particle aliases and their corresponding (symbol, charge, mass_number) tuples.
const PARTICLE_ALIASES = Dict(
    (PROTON_ALIASES .=> Ref(("H", 1, 1)))...,
    (ELECTRON_ALIASES .=> Electron)...,
    (NEUTRON_ALIASES .=> Neutron)...,
    (POSITRON_ALIASES .=> Positron)...,
    (MUON_ALIASES .=> Muon)...,
    (ANTIMUON_ALIASES .=> AntiMuon)...,
    "alpha" => ("He", 2, 4),
    "deuteron" => ("H", 1, 2),
    "D+" => ("H", 1, 2),
    "tritium" => ("H", 0, 3),
    "T" => ("H", 0, 3),
    "triton" => ("H", 1, 3),
    "T+" => ("H", 1, 3),
)

# Dictionary of common particle aliases (as Symbols) for quicker lookup.
const PARTICLE_ALIASES_SYMBOL = Dict(Symbol(k) => v for (k, v) in PARTICLE_ALIASES)