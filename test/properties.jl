using Test, ChargedParticles, Unitful
using ChargedParticles: charge_symbol
using Unitful: q
using Mendeleev: elements

@testset "Symbol Representation" begin
    @test charge_symbol(0) == ""
    @test charge_symbol(2) == "²⁺"
    @test charge_symbol(1) == "⁺"
    @test charge_symbol(-1) == "⁻"
    @test charge_symbol(1, verbose=true) == "¹⁺"
    @test charge_symbol(-1, verbose=true) == "¹⁻"

    @test particle_symbol(particle("Fe-54 2+"); method=:aze) == "⁵⁴Fe²⁺"
end

p = Particle("Fe 2+")
@test p.z == 2
@test p.charge_number == 2
@test p.charge == 2q
@test p.mass_number == 56
@test p.Z == 26
@test p.atomic_number == 26
@test p.mass ≈ 55.934936u"u" - 2me
@test p.element == elements[:Fe]

e = electron()
@test e.mass_energy ≈ 0.510998949u"MeV"