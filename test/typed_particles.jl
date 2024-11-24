using Test, ChargedParticles, Unitful

@testset "SParticle" begin
    # Test basic construction with type parameters
    p = SParticle(1, 2, 3)
    @test p isa AbstractParticle
    @test p isa SParticle{1,2,3}
    @test p isa SParticle{1}

    # Test basic properties
    @test charge_number(p) == 1
    @test atomic_number(p) == 2
    @test mass_number(p) == 3
end

@testset "SParticle and Particle" begin
    p1 = Particle(:He, 1, 3)
    p2 = SParticle(1, 2, 3)
    p3 = SParticle(p1)
    p4 = Particle(p2)
    @test p3 == p2 != p1 == p4
    @test string(p1) == string(p2)
end
