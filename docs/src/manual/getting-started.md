# Getting Started

```@setup
using ChargedParticles
```

## Basic Usage

First, import the package:

```@example
using ChargedParticles
```

### Creating Particles

There are several ways to create particles:

```@example
using ChargedParticles
# Using string format
e = Particle("e-")
p = Particle("H+")
alpha = Particle("He2+")

# Using convenience constructors
e = electron()
p = proton()

# Using atomic numbers
iron = Particle(26)  # Fe
helium = Particle(2, mass_numb=4, Z=2)  # He⁴²⁺
``` 

### Accessing Properties

Each particle has several physical properties that can be accessed:

```@example
using ChargedParticles

p = proton()

# Get mass
m = mass(p)

# Get charge
q = charge(p)

# Get atomic and mass numbers
z = atomic_number(p)
a = mass_number(p)

println("Proton properties:")
println("Mass: ", m)
println("Charge: ", q)
println("Atomic number: ", z)
println("Mass number: ", a)
```

### Working with Ions

Creating and working with ions is straightforward:

```@example
using ChargedParticles

# Create some ions
fe3 = Particle("Fe3+")     # Iron(III)
hydride = Particle("H-")   # Hydride ion

# Check if particles are ions
println("Is Fe3+ an ion? ", is_ion(fe3))
println("Is H- an ion? ", is_ion(hydride))
println("Is electron an ion? ", is_ion(electron()))
```

### Working with Isotopes

You can create and work with isotopes using mass numbers:

```@example
using ChargedParticles

# Create isotopes
fe56 = Particle("Fe-56")
deuteron = Particle("D+")
tritium = Particle("T")

println("Fe-56 mass number: ", mass_number(fe56))
println("Deuteron mass number: ", mass_number(deuteron))
println("Tritium mass number: ", mass_number(tritium))
```
