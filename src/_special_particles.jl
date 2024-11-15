const leptons = ("e-", "mu-", "tau-", "nu_e", "nu_mu", "nu_tau")
const antileptons = ("e+", "mu+", "tau+", "anti_nu_e", "anti_nu_mu", "anti_nu_tau")
const baryons = ("p+", "n")
const antibaryons = ("p-", "antineutron")

const mass_dicts = Dict(
    :e => me,
    :μ => 206.7682827me,
    :p => mp,
    :n => Unitful.mn,
)