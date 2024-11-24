using Chairmarks
using ChargedParticles

p = Particle("Fe 2+")
sp = SParticle(2, 26, 56)

@b mass(p)
@b mass(sp)

@b charge(p)
@b charge(sp)

@b mass_number(p)
@b mass_number(sp)

@b charge_number(p)
@b charge_number(sp)

@b element(p)
@b element(sp)