using Test, ChargedParticles, Unitful
using Unitful: q

@testset "CustomParticle" begin
    # Test basic construction
    p1 = CustomParticle(1.67e-27u"kg", 1)
    @test mass(p1) == 1.67e-27u"kg"
    @test p1.charge_number == 1
    @test p1.symbol == :custom

    # Test with custom symbol
    p2 = CustomParticle(2.0u"GeV", -1, :my_particle)
    @test mass_energy(p2) == 2.0u"GeV"
    @test charge(p2) == -Unitful.q
end