using Test
using ChargedParticles
using Unitful
using Unitful: q

@testset "ChargedParticles.jl" begin
    @testset "Basic Particles" begin
        # Test electron
        e = electron()
        @test is_electron(e)
        @test charge(e) == -q
        @test atomic_number(e) == 0
        @test mass_number(e) == 0

        # Test proton
        p = proton()
        @test is_proton(p)
        @test charge(p) == q
        @test atomic_number(p) == 1
        @test mass_number(p) == 1
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

    @testset "Atomic Number Constructor" begin
        # Test basic construction
        iron = Particle(26)
        @test atomic_number(iron) == 26

        # Test with mass number and charge
        he4 = Particle(2, mass_numb=4, Z=2)
        @test atomic_number(he4) == 2
        @test mass_number(he4) == 4
        @test charge(he4) == 2q

        # Test error cases
        @test_throws ArgumentError Particle(0)
        @test_throws ArgumentError Particle(-1)
    end

    @testset "Error Handling" begin
        # Test invalid particle strings
        @test_throws ArgumentError Particle("invalid")
        @test_throws ArgumentError Particle("Xx")

        # Test invalid mass numbers
        @test_throws ArgumentError Particle(:He, 2, -1)
    end

    @testset "String Representation" begin
        @test string(electron()) == "e⁻"
        @test string(proton()) == "p⁺"
        @test string(Particle("He2+")) == "He4²⁺"
        @test string(Particle("Fe-56")) == "Fe56"
    end
end
