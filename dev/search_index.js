var documenterSearchIndex = {"docs":
[{"location":"api/#API-Reference","page":"API Reference","title":"API Reference","text":"","category":"section"},{"location":"api/#Types","page":"API Reference","title":"Types","text":"","category":"section"},{"location":"api/","page":"API Reference","title":"API Reference","text":"Modules = [ChargedParticles]\nPrivate = false\nOrder = [:type]","category":"page"},{"location":"api/#ChargedParticles.AbstractParticle","page":"API Reference","title":"ChargedParticles.AbstractParticle","text":"AbstractParticle\n\nAbstract type representing any particle in plasma physics.\n\n\n\n\n\n","category":"type"},{"location":"api/#ChargedParticles.CustomParticle","page":"API Reference","title":"ChargedParticles.CustomParticle","text":"CustomParticle <: AbstractParticle\n\nA particle with user-defined mass and charge.\n\nFields\n\nmass: The mass of the particle (can be any numeric type or Unitful quantity)\ncharge_number: Integer representing the charge state\nsymbol: Optional symbol identifier (defaults to nothing)\n\nExamples\n\nCustomParticle(1.67e-27u\"kg\", 1)  # A particle with proton-like mass and +1 charge\nCustomParticle(2.0u\"GeV\", -1, :custom)  # A custom particle with specified symbol\n\n\n\n\n\n","category":"type"},{"location":"api/#ChargedParticles.Particle","page":"API Reference","title":"ChargedParticles.Particle","text":"Particle <: AbstractChargeParticle\n\nImplementation type for charged particles.\n\nFields\n\nsymbol::Symbol: Chemical symbol or particle identifier (e.g., :Fe, :e, :μ)\ncharge_number::Int: Number of elementary charges (can be negative)\nmass_number::Int: Total number of nucleons (protons + neutrons). If not provided, defaults to the most common isotope mass number\n\nNotes\n\nMass number : For elementary particles like electrons and muons, mass_number is 0\nCharge number : electrical charge in units of the elementary charge, usually denoted as z. https://en.wikipedia.org/wiki/Charge_number\n\nExamples\n\nParticle(:Fe, 2)  # Creates Fe²⁺ with default mass number\n# output\nFe²⁺\n\n\n\n\n\n","category":"type"},{"location":"api/#ChargedParticles.Particle-Tuple{AbstractParticle}","page":"API Reference","title":"ChargedParticles.Particle","text":"Particle(p::AbstractParticle)\n\nCreate a particle from another particle implementation, optionally specifying mass number and charge to override.\n\nExamples\n\np = Particle(\"Fe2+\")\np2 = Particle(p; mass_numb=54, z=3)  # Creates a new instance with same properties\n\n\n\n\n\n","category":"method"},{"location":"api/#ChargedParticles.Particle-Tuple{Int64}","page":"API Reference","title":"ChargedParticles.Particle","text":"Particle(atomic_number::Int; mass_numb=nothing, z=0)\n\nCreate a particle from its atomic number with optional mass number and charge state.\n\nArguments\n\natomic_number::Int: The atomic number (number of protons)\nmass_numb=nothing: Optional mass number (total number of nucleons)\nz=0: Optional charge number (in elementary charge units)\n\nExamples\n\n# Basic construction\niron = Particle(26)        # Iron\nu = Particle(92)          # Uranium\n\n# With mass number and charge\nfe56_3plus = Particle(26, mass_numb=56, z=3)  # Fe-56³⁺\nhe4_2plus = Particle(2, mass_numb=4, z=2)     # ⁴He²⁺ (alpha particle)\n\nSee also: Particle(::AbstractString)\n\n\n\n\n\n","category":"method"},{"location":"api/#ChargedParticles.SParticle","page":"API Reference","title":"ChargedParticles.SParticle","text":"SParticle{z, Z, A} <: AbstractParticle\n\nA type-parameterized implementation of a particle.\n\nType Parameters\n\nz::Integer: The charge number (number of elementary charges)\nZ::Integer: The atomic number (number of protons)\nA::Integer: The mass number (total number of nucleons)\n\nConstructors\n\nSParticle{z,Z,A}() / SParticle{z,Z,A}: Construct a particle\nSParticle(p::AbstractParticle): Convert any AbstractParticle to an SParticle\n\nAll parameters must be integers. The type ensures this at construction time.\n\nExamples\n\n# Create a proton (H+)\nproton = SParticle(1, 1, 1)\n\n# Create an alpha particle (He2+)\nalpha = SParticle{2,2,4}()\n\n\n\n\n\n","category":"type"},{"location":"api/#Constructors","page":"API Reference","title":"Constructors","text":"","category":"section"},{"location":"api/","page":"API Reference","title":"API Reference","text":"particle\nproton\nelectron","category":"page"},{"location":"api/#ChargedParticles.particle","page":"API Reference","title":"ChargedParticles.particle","text":"particle(str::AbstractString; mass_numb=nothing, z=nothing)\n\nCreate a particle from a string representation.\n\nArguments\n\nstr::AbstractString: String representation of the particle\n\nString Format Support\n\nElement symbols: \"Fe\", \"He\"\nIsotopes: \"Fe-56\", \"D\"\nIons: \"Fe2+\", \"H-\"\nCommon aliases: \"electron\", \"proton\", \"alpha\", \"mu-\"\n\nExamples\n\n# Elementary particles\nelectron = particle(\"e-\")\nmuon = particle(\"mu-\")\npositron = particle(\"e+\")\n\n# Ions and isotopes\nproton = particle(\"H+\")\nalpha = particle(\"He2+\")\ndeuteron = particle(\"D+\")\niron56 = particle(\"Fe-56\")\n\n\n\n\n\nparticle(sym::Symbol)\n\nCreate a particle from its symbol representation.\n\nExamples\n\n# Elementary particles\nelectron = particle(:e)\nmuon = particle(:muon)\nproton = particle(:p)\n\n\n\n\n\n","category":"function"},{"location":"api/#ChargedParticles.proton","page":"API Reference","title":"ChargedParticles.proton","text":"Create a proton\n\n\n\n\n\n","category":"function"},{"location":"api/#ChargedParticles.electron","page":"API Reference","title":"ChargedParticles.electron","text":"Create an electron\n\n\n\n\n\n","category":"function"},{"location":"api/#Properties","page":"API Reference","title":"Properties","text":"","category":"section"},{"location":"api/","page":"API Reference","title":"API Reference","text":"mass\ncharge\natomic_number\nmass_number","category":"page"},{"location":"api/#ChargedParticles.mass","page":"API Reference","title":"ChargedParticles.mass","text":"Retrieve the mass of an element isotope.\n\n\n\n\n\nReturn the mass of the particle\n\n\n\n\n\n","category":"function"},{"location":"api/#ChargedParticles.charge","page":"API Reference","title":"ChargedParticles.charge","text":"Return the electric charge of the particle in elementary charge units\n\n\n\n\n\n","category":"function"},{"location":"api/#ChargedParticles.atomic_number","page":"API Reference","title":"ChargedParticles.atomic_number","text":"atomic_number(p::AbstractParticle)\n\nReturn the atomic number (number of protons) of the particle.\n\nExamples\n\n```julia fe = Particle(\"Fe\") println(atomic_number(fe))  # 26\n\ne = electron() println(atomic_number(e))  # 0\n\n\n\n\n\n","category":"function"},{"location":"api/#ChargedParticles.mass_number","page":"API Reference","title":"ChargedParticles.mass_number","text":"mass_number(p::AbstractParticle)\n\nReturn the mass number (total number of nucleons) of the particle.\n\nExamples\n\nfe56 = Particle(\"Fe-56\")\nprintln(mass_number(fe56))  # 56\n\ne = electron()\nprintln(mass_number(e))  # 0\n\n\n\n\n\n","category":"function"},{"location":"api/#Type-Checking","page":"API Reference","title":"Type Checking","text":"","category":"section"},{"location":"api/","page":"API Reference","title":"API Reference","text":"is_ion\nis_chemical_element\nis_default_isotope\nChargedParticles.is_proton\nChargedParticles.is_electron","category":"page"},{"location":"api/#ChargedParticles.is_ion","page":"API Reference","title":"ChargedParticles.is_ion","text":"is_ion(p::AbstractParticle)\n\nCheck if the particle is an ion (has non-zero charge and is not an elementary particle).\n\nExamples\n\njulia> is_ion(Particle(\"Fe3+\"))\ntrue\njulia> is_ion(Particle(\"Fe\"))\nfalse\njulia> is_ion(electron())\nfalse\n\n\n\n\n\n","category":"function"},{"location":"api/#ChargedParticles.is_chemical_element","page":"API Reference","title":"ChargedParticles.is_chemical_element","text":"is_chemical_element(p::AbstractParticle)\n\nCheck if the particle is a chemical element.\n\nExamples\n\njulia> is_chemical_element(Particle(\"Fe\"))\ntrue\njulia> is_chemical_element(electron())\nfalse\n\n\n\n\n\n","category":"function"},{"location":"api/#ChargedParticles.is_default_isotope","page":"API Reference","title":"ChargedParticles.is_default_isotope","text":"is_default_isotope(p::AbstractParticle)\n\nCheck if the particle is the default isotope of its element.\n\nExamples\n\njulia> is_default_isotope(Particle(\"Fe-56\"))\ntrue\njulia> is_default_isotope(Particle(\"Fe-57\"))\nfalse\n\n\n\n\n\n","category":"function"},{"location":"api/#ChargedParticles.is_proton","page":"API Reference","title":"ChargedParticles.is_proton","text":"is_proton(p::AbstractParticle)\n\nCheck if the particle is a proton (has symbol 'H', charge +1, and mass number 1).\n\nExamples\n\njulia> ChargedParticles.is_proton(proton())\ntrue\njulia> ChargedParticles.is_proton(electron())\nfalse\n\n\n\n\n\n","category":"function"},{"location":"api/#ChargedParticles.is_electron","page":"API Reference","title":"ChargedParticles.is_electron","text":"is_electron(p::AbstractParticle)\n\nCheck if the particle is an electron (has symbol 'e', charge -1, and electron mass).\n\nExamples\n\njulia> ChargedParticles.is_electron(electron())\ntrue\njulia> ChargedParticles.is_electron(proton())\nfalse\n\n\n\n\n\n","category":"function"},{"location":"api/#Constants","page":"API Reference","title":"Constants","text":"","category":"section"},{"location":"api/","page":"API Reference","title":"API Reference","text":"ChargedParticles.PARTICLE_ALIASES","category":"page"},{"location":"api/#ChargedParticles.PARTICLE_ALIASES","page":"API Reference","title":"ChargedParticles.PARTICLE_ALIASES","text":"PARTICLE_ALIASES\n\nDictionary of common particle aliases and their corresponding (symbol, charge, mass_number) tuples.\n\nEach entry maps a string alias to a tuple of (symbol, charge, mass_number)\n\n\n\n\n\n","category":"constant"},{"location":"manual/getting-started/#Getting-Started","page":"Getting Started","title":"Getting Started","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"using ChargedParticles","category":"page"},{"location":"manual/getting-started/#Basic-Usage","page":"Getting Started","title":"Basic Usage","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"First, import the package:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"using ChargedParticles","category":"page"},{"location":"manual/getting-started/#Creating-Particles","page":"Getting Started","title":"Creating Particles","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"There are several ways to create particles:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"using ChargedParticles\n# Using string format\ne = Particle(\"e-\")\np = Particle(\"H+\")\nalpha = Particle(\"He2+\")\n\n# Using convenience constructors\ne = electron()\np = proton()\n\n# Using atomic numbers\niron = Particle(26)  # Fe\nhelium = Particle(2, mass_numb=4, z=2)  # He⁴²⁺","category":"page"},{"location":"manual/getting-started/#Accessing-Properties","page":"Getting Started","title":"Accessing Properties","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"Each particle has several physical properties that can be accessed:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"using ChargedParticles\n\np = proton()\n\n# Get mass\nm = mass(p)\n\n# Get charge\nq = charge(p)\n\n# Get atomic and mass numbers\nz = atomic_number(p)\na = mass_number(p)\n\nprintln(\"Proton properties:\")\nprintln(\"Mass: \", m)\nprintln(\"Charge: \", q)\nprintln(\"Atomic number: \", z)\nprintln(\"Mass number: \", a)","category":"page"},{"location":"manual/getting-started/#Working-with-Ions","page":"Getting Started","title":"Working with Ions","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"Creating and working with ions is straightforward:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"using ChargedParticles\n\n# Create some ions\nfe3 = Particle(\"Fe3+\")     # Iron(III)\nhydride = Particle(\"H-\")   # Hydride ion\n\n# Check if particles are ions\nprintln(\"Is Fe3+ an ion? \", is_ion(fe3))\nprintln(\"Is H- an ion? \", is_ion(hydride))\nprintln(\"Is electron an ion? \", is_ion(electron()))","category":"page"},{"location":"manual/getting-started/#Working-with-Isotopes","page":"Getting Started","title":"Working with Isotopes","text":"","category":"section"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"You can create and work with isotopes using mass numbers:","category":"page"},{"location":"manual/getting-started/","page":"Getting Started","title":"Getting Started","text":"using ChargedParticles\n\n# Create isotopes\nfe56 = Particle(\"Fe-56\")\ndeuteron = Particle(\"D+\")\ntritium = Particle(\"T\")\n\nprintln(\"Fe-56 mass number: \", mass_number(fe56))\nprintln(\"Deuteron mass number: \", mass_number(deuteron))\nprintln(\"Tritium mass number: \", mass_number(tritium))","category":"page"},{"location":"manual/particle-types/#Particle-Types","page":"Particle Types","title":"Particle Types","text":"","category":"section"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"ChargedParticles.jl provides a flexible type system for representing various types of particles commonly encountered in plasma physics.","category":"page"},{"location":"manual/particle-types/#Type-Hierarchy","page":"Particle Types","title":"Type Hierarchy","text":"","category":"section"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"\nThe package uses a exhaustive type hierarchy:\n\n<pre>\nAbstractParticle\n├── AbstractChargeParticle\n│   ├── Particle\n│   └── SParticle\n├── AbstractFermion\n│   ├── AbstractLepton\n│   │   ├── Electron\n│   │   └── Muon\n│   └── AbstractQuark\n│   └── Neutron\n│   └── ...\n└── CustomParticle\n</pre>","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"AbstractParticle: Base abstract type for all particles\nAbstractChargeParticle: Particles that could carry an electric charge.\nParticle: Physically meaningful particle type (for ions where symbol encodes the actual type of the particle)\nSParticle: Type-parameterized particle type for memory-efficient representation\nCustomParticle: Custom particle type for user-defined particles (where symbol is just a label)","category":"page"},{"location":"manual/particle-types/#SParticle:-Type-Parameterized-Implementation","page":"Particle Types","title":"SParticle: Type-Parameterized Implementation","text":"","category":"section"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"SParticle is a memory-efficient, type-parameterized implementation of a particle. Unlike Particle which stores particle properties as runtime values, SParticle encodes these properties in its type parameters:","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"# Type parameters encode charge number (z), atomic number (Z), and mass number (A)\nSParticle{z,Z,A}","category":"page"},{"location":"manual/particle-types/#Memory-Efficiency","page":"Particle Types","title":"Memory Efficiency","text":"","category":"section"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"SParticle is a zero-size type, meaning it requires no runtime memory allocation. This makes it particularly efficient for large-scale simulations where memory usage is critical:","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"# Compare memory usage\nusing ChargedParticles # hide\nsizeof(SParticle{1,2,3}()), sizeof(Particle(:He, 1, 3))","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"However, it's less flexible than Particle when properties are dynamic or numerous or are determined at runtime.","category":"page"},{"location":"manual/particle-types/#Particle-Properties","page":"Particle Types","title":"Particle Properties","text":"","category":"section"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"Each particle (Particle) has the following properties:","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"Symbol (symbol::Symbol): Chemical symbol or particle identifier\nRegular elements: :Fe, :He, etc.\nElementary particles: :e (electron), :μ (muon)\nSpecial particles: :n (neutron)\nCharge Number (charge_number::Int): Number of elementary charges\nPositive for cations: +1, +2, etc.\nNegative for anions: -1, -2, etc.\nZero for neutral atoms/particles\nMass Number (mass_number::Int): Total number of nucleons\nFor isotopes: sum of protons and neutrons\nFor elementary particles: 0\nFor regular elements: most abundant isotope","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"Other properties derived from the above:","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"Mass (mass::Unitful.Mass): Particle mass\nCalculated from the particle's symbol and mass number\nElementary particles: predefined constants (me, mμ, etc.)\nAtoms and ions: looked up from isotope data\nCharge (q) (charge\\q::Unitful.Charge): Particle charge\nAtomic Number (Z) (atomic_number\\Z::Int): Number of protons in the particle\nElement (element::Element): Element associated with the particle","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"Accessing particle properties could be done using functions {property_name}(particle) or dot notation particle.{property_name}. Functions are preferred for performance.","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"using ChargedParticles # hide\ne = electron()\ne.mass, mass(e)","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"More properties (fields) about the element could be found in the Mendeleev.jl. These fields could be accessed by particle.element.{field_name} or element(particle).{field_name}.","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"p = Particle(\"Fe\")\n@show propertynames(p.element);","category":"page"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"p.element","category":"page"},{"location":"manual/particle-types/#Supported-Particle-Categories","page":"Particle Types","title":"Supported Particle Categories","text":"","category":"section"},{"location":"manual/particle-types/#Elementary-Particles","page":"Particle Types","title":"Elementary Particles","text":"","category":"section"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"using ChargedParticles # hide\n\n# Electron\ne = electron()\nprintln(\"Electron: charge = $(charge(e)), mass = $(mass(e))\")\n\n# Muon\nμ = Particle(\"mu-\")\nprintln(\"Muon: charge = $(charge(μ)), mass = $(mass(μ))\")","category":"page"},{"location":"manual/particle-types/#Atoms-and-Ions","page":"Particle Types","title":"Atoms and Ions","text":"","category":"section"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"using ChargedParticles\n\n# Neutral atom\nfe = Particle(\"Fe\")\nprintln(\"Iron: Z = $(atomic_number(fe)), A = $(mass_number(fe))\")\n\n# Positive ion\nfe3 = Particle(\"Fe3+\")\nprintln(\"Iron(III): charge = $(charge(fe3))\")\n\n# Negative ion\nh_minus = Particle(\"H-\")\nprintln(\"Hydride: charge = $(charge(h_minus))\")","category":"page"},{"location":"manual/particle-types/#Isotopes","page":"Particle Types","title":"Isotopes","text":"","category":"section"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"using ChargedParticles\n\n# Neutral isotope\nfe56 = Particle(\"Fe-56\")\nprintln(\"Fe-56: A = $(mass_number(fe56))\")\n\n# Charged isotope\nhe4_2plus = Particle(\"He2+\", mass_numb=4)\nprintln(\"He-4(2+): Z = $(atomic_number(he4_2plus)), A = $(mass_number(he4_2plus))\")","category":"page"},{"location":"manual/particle-types/#Special-Particles","page":"Particle Types","title":"Special Particles","text":"","category":"section"},{"location":"manual/particle-types/","page":"Particle Types","title":"Particle Types","text":"using ChargedParticles\n\n# Alpha particle\nα = Particle(\"alpha\")\nprintln(\"Alpha: Z = $(atomic_number(α)), A = $(mass_number(α))\")\n\n# Deuteron\nd = Particle(\"D+\")\nprintln(\"Deuteron: A = $(mass_number(d))\")\n\n# Triton\nt = Particle(\"T+\")\nprintln(\"Triton: A = $(mass_number(t))\")","category":"page"},{"location":"manual/construction/#Particle-Construction","page":"Construction","title":"Particle Construction","text":"","category":"section"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"ChargedParticles.jl provides multiple ways to construct particles, offering flexibility for different use cases.","category":"page"},{"location":"manual/construction/#String-Format","page":"Construction","title":"String Format","text":"","category":"section"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"The most common way to create particles is using string format:","category":"page"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"using ChargedParticles\n\n# Basic elements\nfe = Particle(\"Fe\")     # Iron\nhe = Particle(\"He\")     # Helium\n\n# Ions with charge\nfe3 = Particle(\"Fe3+\")  # Iron(III)\nfe2 = Particle(\"Fe2-\")  # Iron(-II)\n\n# Isotopes\nfe56 = Particle(\"Fe-56\")  # Iron-56\nu235 = Particle(\"U-235\")  # Uranium-235\n\nprintln(\"Iron: z = $(atomic_number(fe))\")\nprintln(\"Iron(III): charge = $(charge(fe3))\")\nprintln(\"Iron-56: A = $(mass_number(fe56))\")","category":"page"},{"location":"manual/construction/#String-Format-Rules","page":"Construction","title":"String Format Rules","text":"","category":"section"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"Basic Elements\nJust the symbol: \"Fe\", \"He\", \"U\"\nCase sensitive: \"Fe\" works, \"FE\" doesn't\nIons\nAppend charge: \"Fe3+\", \"Fe2-\"\nFormat: SYMBOL + NUMBER + +/-\nExamples: \"Fe3+\", \"Cl-\", \"Ca2+\"\nIsotopes\nFormat: SYMBOL + - + MASS_NUMBER\nExamples: \"Fe-56\", \"U-235\", \"C-14\"\nCombined Isotopes and Ions\nFormat: SYMBOL + - + MASS_NUMBER + NUMBER + +/-\nExamples: \"Fe-56_3+\", \"U-235_2+\"","category":"page"},{"location":"manual/construction/#Common-Particle-Aliases","page":"Construction","title":"Common Particle Aliases","text":"","category":"section"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"Many common particles have predefined aliases:","category":"page"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"using ChargedParticles\n\n# Elementary particles\ne = Particle(\"electron\")  # or \"e-\"\np = Particle(\"proton\")    # or \"p+\"\nn = Particle(\"neutron\")   # or \"n\"\n\n# Special particles\nα = Particle(\"alpha\")     # He²⁺\nd = Particle(\"deuteron\")  # D⁺\nt = Particle(\"triton\")    # T⁺\n\nprintln(\"Electron charge: $(charge(e))\")\nprintln(\"Alpha particle: z = $(atomic_number(α)), A = $(mass_number(α))\")\nprintln(\"Deuteron mass number: $(mass_number(d))\")","category":"page"},{"location":"manual/construction/#Atomic-Number-Constructor","page":"Construction","title":"Atomic Number Constructor","text":"","category":"section"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"You can also create particles using their atomic numbers:","category":"page"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"using ChargedParticles\n\n# Basic construction\nfe = Particle(26)        # Iron\nu = Particle(92)         # Uranium\n\n# With mass number and charge\nfe56_3plus = Particle(26, mass_numb=56, z=3)  # Fe-56³⁺\nu235_2plus = Particle(92, mass_numb=235, z=2)  # U-235²⁺\n\nprintln(\"Iron: z = $(atomic_number(fe))\")\nprintln(\"U-235²⁺: z = $(atomic_number(u235_2plus)), A = $(mass_number(u235_2plus))\")","category":"page"},{"location":"manual/construction/#Convenience-Constructors","page":"Construction","title":"Convenience Constructors","text":"","category":"section"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"The most common particles have dedicated constructors:","category":"page"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"using ChargedParticles\n\n# Using convenience constructors\ne = electron()\np = proton()\n\nprintln(\"Electron mass: $(mass(e))\")\nprintln(\"Proton charge: $(charge(p))\")","category":"page"},{"location":"manual/construction/#Error-Handling","page":"Construction","title":"Error Handling","text":"","category":"section"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"The constructors include error checking:","category":"page"},{"location":"manual/construction/","page":"Construction","title":"Construction","text":"using ChargedParticles\n\n# These will throw errors\ntry\n    invalid = Particle(\"XX\")  # Invalid element symbol\ncatch e\n    println(\"Error: \", e)\nend\n\ntry\n    invalid = Particle(-1)    # Invalid atomic number\ncatch e\n    println(\"Error: \", e)\nend","category":"page"},{"location":"#ChargedParticles.jl","page":"Home","title":"ChargedParticles.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Build Status) (Image: Documentation) ","category":"page"},{"location":"","page":"Home","title":"Home","text":"A Julia package for representing charged particles inspired by PlasmaPy's particles subpackage.","category":"page"},{"location":"#Overview","page":"Home","title":"Overview","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"ChargedParticles.jl provides a flexible type system for working with various particles including elementary particles, ions, and isotopes. It supports multiple string formats and construction methods, making it easy to work with common particles in plasma physics.","category":"page"},{"location":"#Features","page":"Home","title":"Features","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Support for elementary particles, ions, and isotopes\nFlexible string-based particle construction with common particle aliases\nPhysical properties (mass, charge, atomic number, charge number, etc.)\nIntegration with Mendeleev.jl for chemical element data","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using Pkg\nPkg.add(\"ChargedParticles\")","category":"page"},{"location":"#Quick-Example","page":"Home","title":"Quick Example","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using ChargedParticles\n\n# Create common particles\ne = electron()\np = proton()\nα = Particle(\"alpha\")\n\n# Create ions and isotopes\nfe = Particle(\"Fe-56 3+\")     # Iron(III) ion\nfe54 = Particle(:Fe, 3, 54)\nd = Particle(\"D+\")         # Deuteron\n\n# Access properties\nprintln(\"Electron mass: \", mass(e))\nprintln(\"Alpha particle charge: \", charge(α))\nprintln(\"Iron(III) ion charge: \", charge(fe))\nprintln(\"Iron-54 mass number: \", mass_number(fe54))\nprintln(\"Deuteron mass: \", mass(d))","category":"page"},{"location":"#Related-Packages","page":"Home","title":"Related Packages","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"PlasmaPy: A Python package for plasma physics.\nMendeleev.jl: A Julia package for accessing periodic table data.\nCorpuscles.jl: A Julia package for for particle physics.","category":"page"},{"location":"#Manual-Outline","page":"Home","title":"Manual Outline","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Pages = [\n    \"manual/getting-started.md\",\n    \"manual/particle-types.md\",\n    \"manual/construction.md\"\n]\nDepth = 2","category":"page"}]
}
