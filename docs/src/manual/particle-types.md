# Particle Types

ChargedParticles.jl provides a flexible type system for representing various types of particles commonly encountered in plasma physics.

## Type Hierarchy

```@raw html

The package uses a exhaustive type hierarchy:

<pre>
AbstractParticle
├── AbstractChargeParticle
│   ├── Particle
│   └── SParticle
├── AbstractFermion
│   ├── AbstractLepton
│   │   ├── Electron
│   │   └── Muon
│   └── AbstractQuark
│   └── Neutron
│   └── ...
└── CustomParticle
</pre>
```

- `AbstractParticle`: Base abstract type for all particles
- `AbstractChargeParticle`: Particles that could carry an electric charge.
- `Particle`: Physically meaningful particle type (for ions where symbol encodes the actual type of the particle)
- `SParticle`: Type-parameterized particle type for memory-efficient representation
- `CustomParticle`: Custom particle type for user-defined particles (where symbol is just a label)

### SParticle: Type-Parameterized Implementation

`SParticle` is a memory-efficient, type-parameterized implementation of a particle. Unlike `Particle` which stores particle properties as runtime values, `SParticle` encodes these properties in its type parameters:

```julia
# Type parameters encode charge number (z), atomic number (Z), and mass number (A)
SParticle{z,Z,A}
```

#### Memory Efficiency

`SParticle` is a zero-size type, meaning it requires no runtime memory allocation. This makes it particularly efficient for large-scale simulations where memory usage is critical:

```@example share
# Compare memory usage
using ChargedParticles # hide
sizeof(SParticle{1,2,3}()), sizeof(Particle(:He, 1, 3))
```

However, it's less flexible than `Particle` when properties are dynamic or numerous or are determined at runtime.

## Particle Properties

Each particle (`Particle`) has the following properties:

- **Symbol** (`symbol::Symbol`): Chemical symbol or particle identifier
   - Regular elements: `:Fe`, `:He`, etc.
   - Elementary particles: `:e` (electron), `:μ` (muon)
   - Special particles: `:n` (neutron)

- **Charge Number** (`charge_number::Int`): Number of elementary charges
   - Positive for cations: `+1`, `+2`, etc.
   - Negative for anions: `-1`, `-2`, etc.
   - Zero for neutral atoms/particles

- **Mass Number** (`mass_number::Int`): Total number of nucleons
   - For isotopes: sum of protons and neutrons
   - For elementary particles: `0`
   - For regular elements: most abundant isotope

Other properties derived from the above:

-  **Mass** (`mass::Unitful.Mass`): Particle mass
   - Calculated from the particle's symbol and mass number
   - Elementary particles: predefined constants (me, mμ, etc.)
   - Atoms and ions: looked up from isotope data

- **Charge (q)** (`charge\q::Unitful.Charge`): Particle charge

- **Atomic Number (Z)** (`atomic_number\Z::Int`): Number of protons in the particle

- **Element** (`element::Element`): Element associated with the particle

Accessing particle properties could be done using functions `{property_name}(particle)` or dot notation `particle.{property_name}`. Functions are preferred for performance.

```@example share
e = electron()
e.mass, mass(e)
```

More properties (fields) about the element could be found in the [Mendeleev.jl](https://eben60.github.io/Mendeleev.jl/elements_data_fields/). These fields could be accessed by `particle.element.{field_name}` or `element(particle).{field_name}`.

```@example share
p = particle("Fe")
@show propertynames(p.element);
```

```@example share
p.element
```

## Supported Particle Categories

### Elementary Particles

```@example share
# Electron
e = electron()
println("Electron: charge = $(charge(e)), mass = $(mass(e))")

# Muon
μ = particle("mu-")
println("Muon: charge = $(charge(μ)), mass = $(mass(μ))")
```

### Atoms and Ions

```@example share
# Neutral atom
fe = particle("Fe")
println("Iron: Z = $(atomic_number(fe)), A = $(mass_number(fe))")

# Positive ion
fe3 = particle("Fe3+")
println("Iron(III): charge = $(charge(fe3))")

# Negative ion
h_minus = particle("H-")
println("Hydride: charge = $(charge(h_minus))")
```

### Isotopes

```@example share
# Neutral isotope
fe56 = particle("Fe-56")
println("Fe-56: A = $(mass_number(fe56))")

# Charged isotope
he4_2plus = particle("He2+", mass_numb=4)
println("He-4(2+): Z = $(atomic_number(he4_2plus)), A = $(mass_number(he4_2plus))")
```

### Special Particles

```@example share
# Alpha particle
α = particle("alpha")
println("Alpha: Z = $(atomic_number(α)), A = $(mass_number(α))")

# Deuteron
d = particle("D+")
println("Deuteron: A = $(mass_number(d))")

# Triton
t = particle("T+")
println("Triton: A = $(mass_number(t))")
```
