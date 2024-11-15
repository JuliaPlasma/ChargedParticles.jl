using Test, ChargedParticles, Unitful
using Unitful: q
using Mendeleev: elements

p = Particle("Fe 2+")
@test p.z == 2
@test p.charge_number == 2
@test p.charge == 2q
@test p.mass_number == 56
@test p.Z == 26
@test p.atomic_number == 26
@test p.mass ≈ 55.934936u"u"
@test p.element == elements[:Fe]

e = electron()
@test e.mass_energy ≈ 0.510998949u"MeV"