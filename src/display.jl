Base.show(io::IO, p::AbstractParticle) = print(io, particle_symbol(p))
Base.show(io::IO, p::SParticle) = print(io, typeof(p), " with symbol: ", particle_symbol(p))