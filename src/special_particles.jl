const leptons = ("e-", "mu-", "tau-", "nu_e", "nu_mu", "nu_tau")
const antileptons = ("e+", "mu+", "tau+", "anti_nu_e", "anti_nu_mu", "anti_nu_tau")
const baryons = ("p+", "n")
const antibaryons = ("p-", "antineutron")

struct Electron <: AbstractLepton end
struct Positron <: AbstractLepton end
struct Muon <: AbstractLepton end
struct Neutron <: AbstractFermion end

# Properties
atomic_number(::AbstractFermion) = 0
mass_number(::AbstractFermion) = 0

## Electron and Positron
charge_number(::Electron) = -1
mass(::Electron) = me
symbol(::Electron) = :e

charge_number(::Positron) = 1
mass(::Positron) = me
symbol(::Positron) = :e

## Muon
charge_number(::Muon) = -1
mass(::Muon) = 206.7682827me
symbol(::Muon) = :μ

## Neutron
charge_number(::Neutron) = 0
mass(::Neutron) = Unitful.mn
symbol(::Neutron) = :n
mass_number(::Neutron) = 1


# Convenience constructors for common particles
"""Create an electron"""
electron() = Electron()