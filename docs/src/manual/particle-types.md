# Particle Types

ChargedParticles.jl provides a flexible type system for representing various types of particles commonly encountered in plasma physics.

## Type Hierarchy

```@raw html
<pre>
AbstractParticle
└── ChargedParticleImpl
</pre>
```

The package uses a simple two-level type hierarchy:
- `AbstractParticle`: Base abstract type for all particles
- `ChargedParticleImpl`: Concrete implementation storing particle properties

## Particle Properties

Each particle has four fundamental properties:

1. **Symbol** (`symbol::Symbol`): Chemical symbol or particle identifier
   - Regular elements: `:Fe`, `:He`, etc.
   - Elementary particles: `:e` (electron), `:μ` (muon)
   - Special particles: `:n` (neutron)

2. **Charge Number** (`charge_number::Int`): Number of elementary charges
   - Positive for cations: `+1`, `+2`, etc.
   - Negative for anions: `-1`, `-2`, etc.
   - Zero for neutral atoms/particles

3. **Mass Number** (`mass_number::Int`): Total number of nucleons
   - For isotopes: sum of protons and neutrons
   - For elementary particles: `0`
   - For regular elements: most abundant isotope

4. **Mass** (`mass::Unitful.Mass`): Particle mass
   - Uses appropriate units from Unitful.jl
   - Elementary particles: electron mass units (me)
   - Atoms and ions: atomic mass units (u)

## Supported Particle Categories

### Elementary Particles

```@example
using ChargedParticles

# Electron
e = electron()
println("Electron: charge = $(charge(e)), mass = $(mass(e))")

# Muon
μ = Particle("mu-")
println("Muon: charge = $(charge(μ)), mass = $(mass(μ))")
```

### Atoms and Ions

```@example
using ChargedParticles

# Neutral atom
fe = Particle("Fe")
println("Iron: Z = $(atomic_number(fe)), A = $(mass_number(fe))")

# Positive ion
fe3 = Particle("Fe3+")
println("Iron(III): charge = $(charge(fe3))")

# Negative ion
h_minus = Particle("H-")
println("Hydride: charge = $(charge(h_minus))")
```

### Isotopes

```@example
using ChargedParticles

# Neutral isotope
fe56 = Particle("Fe-56")
println("Fe-56: A = $(mass_number(fe56))")

# Charged isotope
he4_2plus = Particle("He2+", mass_numb=4)
println("He-4(2+): Z = $(atomic_number(he4_2plus)), A = $(mass_number(he4_2plus))")
```

### Special Particles

```@example
using ChargedParticles

# Alpha particle
α = Particle("alpha")
println("Alpha: Z = $(atomic_number(α)), A = $(mass_number(α))")

# Deuteron
d = Particle("D+")
println("Deuteron: A = $(mass_number(d))")

# Triton
t = Particle("T+")
println("Triton: A = $(mass_number(t))")
```
