# Common particle aliases

const ELECTRON_ALIASES = ("electron", "e-", "e+")
const PROTON_ALIASES = ("proton", "p+", "p", "H+")
"""
    PARTICLE_ALIASES

Dictionary of common particle aliases and their corresponding (symbol, charge, mass_number) tuples.

Each entry maps a string alias to a tuple of (symbol, charge, mass_number)
"""
PARTICLE_ALIASES = Dict(
    "e+" => ("e", 1, 0),
    "positron" => ("e", 1, 0),
    "neutron" => ("n", 0, 1),
    "n" => ("n", 0, 1),
    "alpha" => ("He", 2, 4),
    "deuteron" => ("H", 1, 2),
    "D+" => ("H", 1, 2),
    "tritium" => ("H", 0, 3),
    "T" => ("H", 0, 3),
    "triton" => ("H", 1, 3),
    "T+" => ("H", 1, 3),
    "mu-" => ("μ", -1, 0),
    "muon" => ("μ", -1, 0),
    "antimuon" => ("μ", 1, 0),
    "mu+" => ("μ", 1, 0),
)

ELECTRON_ALIASES_DICT = Dict(str => ("e", -1, 0) for str in ELECTRON_ALIASES)
PROTON_ALIASES_DICT = Dict(str => ("H", 1, 1) for str in PROTON_ALIASES)
PARTICLE_ALIASES = merge(PARTICLE_ALIASES, ELECTRON_ALIASES_DICT, PROTON_ALIASES_DICT)