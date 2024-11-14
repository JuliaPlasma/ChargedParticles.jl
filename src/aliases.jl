# Common particle aliases
"""
    PARTICLE_ALIASES

Dictionary of common particle aliases and their corresponding (symbol, charge, mass_number) tuples.

Each entry maps a string alias to a tuple of (symbol, charge, mass_number)
"""
PARTICLE_ALIASES = Dict(
    "electron" => ("e", -1, 0),
    "e-" => ("e", -1, 0),
    "e+" => ("e", 1, 0),
    "positron" => ("e", 1, 0),
    "proton" => ("H", 1, 1),
    "p+" => ("H", 1, 1),
    "p" => ("H", 1, 1),
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