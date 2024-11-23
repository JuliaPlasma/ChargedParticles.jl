using Test, ChargedParticles, Unitful

@testset "SParticle" begin
    # Test basic construction with type parameters
    p = SParticle(1, 2, 3)
    @test p isa AbstractParticle
    @test p isa SParticle{1,2,3}

    # Test basic properties
    @test charge_number(p) == 1
    @test atomic_number(p) == 2
    @test mass_number(p) == 3
end