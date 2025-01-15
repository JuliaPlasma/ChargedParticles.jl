# Particle Construction

ChargedParticles.jl provides multiple ways to construct particles, offering flexibility for different use cases.

## String Format

The most common way to create particles is using string format:

```@example
using ChargedParticles

# Basic elements
fe = particle("Fe")     # Iron
he = particle("He")     # Helium

# Ions with charge
fe3 = particle("Fe3+")  # Iron(III)
fe2 = particle("Fe2-")  # Iron(-II)

# Isotopes
fe56 = particle("Fe-56")  # Iron-56
u235 = particle("U-235")  # Uranium-235

println("Iron: z = $(atomic_number(fe))")
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
e = particle("electron")  # or "e-"
p = particle("proton")    # or "p+"
n = particle("neutron")   # or "n"

# Special particles
α = particle("alpha")     # He²⁺
d = particle("deuteron")  # D⁺
t = particle("triton")    # T⁺

println("Electron charge: $(charge(e))")
println("Alpha particle: z = $(atomic_number(α)), A = $(mass_number(α))")
println("Deuteron mass number: $(mass_number(d))")
```

## Atomic Number Constructor

You can also create particles using their atomic numbers:

```@example
using ChargedParticles

# Basic construction
fe = particle(26)        # Iron
u = particle(92)         # Uranium

# With mass number and charge
fe56_3plus = particle(26, mass_numb=56, z=3)  # Fe-56³⁺
u235_2plus = particle(92, mass_numb=235, z=2)  # U-235²⁺

println("Iron: z = $(atomic_number(fe))")
println("U-235²⁺: z = $(atomic_number(u235_2plus)), A = $(mass_number(u235_2plus))")
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
    invalid = particle("XX")  # Invalid element symbol
catch e
    println("Error: ", e)
end

try
    invalid = particle(-1)    # Invalid atomic number
catch e
    println("Error: ", e)
end
```
