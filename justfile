servedocs:
    #!/usr/bin/env -S julia --project=docs/ -i
    using Pkg
    Pkg.develop(PackageSpec(path=pwd()))
    using ChargedParticles, LiveServer;
    servedocs()