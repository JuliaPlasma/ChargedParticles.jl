# String representation
function Base.show(io::IO, p::AbstractParticle)

    supercripts = ["", '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹']

    charge_str = @match p.charge_number begin
        x, if x > 0
        end => "$(supercripts[x])⁺"
        x, if x < 0
        end => "$(supercripts[abs(x)])⁻"
        0 => ""
    end
    # if mass number is the default, no need to print it
    if is_chemical_element(p)
        mass_number_str = is_default_isotope(p) ? "" : "-$(mass_number(p))"
    else
        mass_number_str = ""
    end
    print(io, "$(p.symbol)$(mass_number_str)$(charge_str)")
end