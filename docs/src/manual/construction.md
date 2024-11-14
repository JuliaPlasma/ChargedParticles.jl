# Particle Construction

ChargedParticles.jl provides multiple ways to construct particles, offering flexibility for different use cases.

## String Format

The most common way to create particles is using string format:

```@example
using ChargedParticles

# Basic elements
fe = Particle("Fe")     # Iron
he = Particle("He")     # Helium

# Ions with charge
fe3 = Particle("Fe3+")  # Iron(III)
fe2 = Particle("Fe2-")  # Iron(-II)

# Isotopes
fe56 = Particle("Fe-56")  # Iron-56
u235 = Particle("U-235")  # Uranium-235

println("Iron: Z = $(atomic_number(fe))")
println("Iron(III): charge = $(charge(fe3))")
println("Iron-56: A = $(mass_number(fe56))")
```

### String Format Rules

1. **Basic Elements**
   - Just the symbol: `"Fe"`, `"He"`, `"U"`
   - Case sensitive: `"Fe"` works, `"FE"` doesn't

2. **Ions**
   - Append charge: `"Fe3+"`, `"Fe2-"`
   - Format: `SYMBOL` + `NUMBER` + `+/-`
   - Examples: `"Fe3+"`, `"Cl-"`, `"Ca2+"`

3. **Isotopes**
   - Format: `SYMBOL` + `-` + `MASS_NUMBER`
   - Examples: `"Fe-56"`, `"U-235"`, `"C-14"`

4. **Combined Isotopes and Ions**
   - Format: `SYMBOL` + `-` + `MASS_NUMBER` + `NUMBER` + `+/-`
   - Examples: `"Fe-56_3+"`, `"U-235_2+"`

## Common Particle Aliases

Many common particles have predefined aliases:

```@example
using ChargedParticles

# Elementary particles
e = Particle("electron")  # or "e-"
p = Particle("proton")    # or "p+"
n = Particle("neutron")   # or "n"

# Special particles
α = Particle("alpha")     # He²⁺
d = Particle("deuteron")  # D⁺
t = Particle("triton")    # T⁺

println("Electron charge: $(charge(e))")
println("Alpha particle: Z = $(atomic_number(α)), A = $(mass_number(α))")
println("Deuteron mass number: $(mass_number(d))")
```

## Atomic Number Constructor

You can also create particles using their atomic numbers:

```@example
using ChargedParticles

# Basic construction
fe = Particle(26)        # Iron
u = Particle(92)         # Uranium

# With mass number and charge
fe56_3plus = Particle(26, mass_numb=56, Z=3)  # Fe-56³⁺
u235_2plus = Particle(92, mass_numb=235, Z=2)  # U-235²⁺

println("Iron: Z = $(atomic_number(fe))")
println("U-235²⁺: Z = $(atomic_number(u235_2plus)), A = $(mass_number(u235_2plus))")
```

## Convenience Constructors

The most common particles have dedicated constructors:

```@example
using ChargedParticles

# Using convenience constructors
e = electron()
p = proton()

println("Electron mass: $(mass(e))")
println("Proton charge: $(charge(p))")
```

## Error Handling

The constructors include error checking:

```@example
using ChargedParticles

# These will throw errors
try
    invalid = Particle("XX")  # Invalid element symbol
catch e
    println("Error: ", e)
end

try
    invalid = Particle(-1)    # Invalid atomic number
catch e
    println("Error: ", e)
end
```
