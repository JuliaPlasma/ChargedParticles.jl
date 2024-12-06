using Test, ChargedParticles, Unitful
using ChargedParticles: is_electron, is_proton
using Unitful: q

@testset "Constructor" begin
    # Test invalid mass numbers
    @test_throws ArgumentError Particle(:He, 2, -1)

    # Default mass number
    @test mass_number(Particle(:He, 2)) == 4
end

@testset "String Constructor" begin
    # Test common aliases
    @test is_electron(Particle("electron"))
    @test is_electron(Particle("e-"))
    @test charge(Particle("e+")) == q
    @test is_proton(Particle("proton"))
    @test is_proton(Particle("p+"))

    # Test isotopes and ions
    deuteron = Particle("D+")
    @test mass_number(deuteron) == 2
    @test charge(deuteron) == q

    alpha = Particle("alpha")
    @test mass_number(alpha) == 4
    @test charge(alpha) == 2q

    triton = Particle("T+")
    @test mass_number(triton) == 3
    @test charge(triton) == 1q

    # Test muons
    muon = Particle("mu-")
    @test charge(muon) == -q
    antimuon = Particle("antimuon")
    @test charge(antimuon) == q

    # Test element notation
    fe56 = Particle("Fe-56")
    @test mass_number(fe56) == 56
    @test charge(fe56) == 0q

    fe3plus = Particle("Fe3+")
    @test charge(fe3plus) == 3q

    he2plus = Particle("He2+")
    @test charge(he2plus) == 2q
end

@testset "String constructor with keywords" begin
    @test Particle("Fe").charge_number == 0
    @test Particle("Fe 2+").charge_number == 2
    @test Particle("Fe"; z=2).charge_number == 2
    @test Particle("Fe 2+"; z=2).charge_number == 2
    @test_throws ArgumentError Particle("Fe 2+"; z=3)

    @test Particle("Fe").mass_number == 56
    @test Particle("Fe-54").mass_number == 54
    @test Particle("Fe"; mass_numb=54).mass_number == 54
    @test Particle("Fe-54", mass_numb=54).mass_number == 54
    @test_throws ArgumentError Particle("Fe-54"; mass_numb=55)

    sp = particle("Fe-54 2+"; typed=true)
    @test typeof(sp) <: SParticle
    @test sp isa SParticle{2,26,54}
end

@testset "Atomic Number Constructor" begin
    # Test basic construction
    iron = Particle(26)
    @test atomic_number(iron) == 26

    # Test with mass number and charge
    he4 = Particle(2; mass_numb=4, z=2)
    @test atomic_number(he4) == 2
    @test mass_number(he4) == 4
    @test charge(he4) == 2q

    # Test error cases
    @test_throws KeyError Particle(0)
    @test_throws KeyError Particle(-1)
end

@testset "Construct from AbstractParticle" begin
    p1 = Particle("Fe"; mass_numb=56, z=2)
    p2 = Particle(p1; mass_numb=54, z=3)
    @test p2.symbol == p1.symbol
    @test p2.charge_number == 3
    @test p2.mass_number == 54
    @test p2.mass != p1.mass
end