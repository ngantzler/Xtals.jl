"""
    atom_colors = read_cpk_colors()

Read in CPK color scheme for atoms. Return `atom_colors::Dict{Symbol, Tuple{Int, Int, Int}}` such that
`atom_colors[":C"]` gives RGB code for carbon as a tuple, `(144, 144, 144)`.
https://en.wikipedia.org/wiki/CPK_coloring

# Returns
- `atom_colors::Dict{Symbol, Tuple{Int, Int, Int}}`: A dictionary linking an element symbol to its' corresponding CPK color in RGB
"""
function read_cpk_colors(filename::String="cpk_atom_colors.csv")
    atom_colors = Dict{Symbol, Tuple{Int, Int, Int}}()
    df_colors = CSV.read(joinpath(PATH_TO_DATA, filename), DataFrame)
    for row in eachrow(df_colors)
        atom_colors[Symbol(row[:atom])] = (row[:R], row[:G], row[:B])
    end
    return atom_colors
end


# makes dict from stringified cpk_atom_colors.csv
function _CPKColors(headers::Array{Symbol}, data::String)::Dict{Symbol,Tuple{Int,Int,Int}}
    atom_colors = Dict{Symbol, Tuple{Int, Int, Int}}()
    species = Symbol[]
    r = Int[]
    g = Int[]
    b = Int[]
    hex = String[]
    for line ∈ split(data, "\n")
        fields = split(line, ",")
        if length(fields) == 5
            push!(species, Symbol(fields[1]))
            push!(r, parse(Float64, fields[2]))
            push!(g, parse(Float64, fields[3]))
            push!(b, parse(Float64, fields[4]))
            push!(hex, fields[5])
        end
    end
    df_colors = DataFrame([species, r, g, b, hex], headers)
    for row in eachrow(df_colors)
        atom_colors[Symbol(row[:atom])] = (row[:R], row[:G], row[:B])
    end
    return atom_colors
end


"""
    get_cpk_colors()
Returns the global CPK colors dictionary
"""
function get_cpk_colors()
    return CPK_COLORS
end


# global cpk color dictionary
CPK_COLORS = _CPKColors([:atom, :R, :G, :B, :Hex],
"""H,255,255,255,FFFFFF
He,217,255,255,D9FFFF
Li,204,128,255,CC80FF
Be,194,255,0,C2FF00
B,255,181,181,FFB5B5
C,144,144,144,909090
N,48,80,248,3050F8
O,255,13,13,FF0D0D
F,144,224,80,90E050
Ne,179,227,245,B3E3F5
Na,171,92,242,AB5CF2
Mg,138,255,0,8AFF00
Al,191,166,166,BFA6A6
Si,240,200,160,F0C8A0
P,255,128,0,FF8000
S,255,255,48,FFFF30
Cl,31,240,31,1FF01F
Ar,128,209,227,80D1E3
K,143,64,212,8F40D4
Ca,61,255,0,3DFF00
Sc,230,230,230,E6E6E6
Ti,191,194,199,BFC2C7
V,166,166,171,A6A6AB
Cr,138,153,199,8A99C7
Mn,156,122,199,9C7AC7
Fe,224,102,51,E06633
Co,240,144,160,F090A0
Ni,80,208,80,50D050
Cu,200,128,51,C88033
Zn,125,128,176,7D80B0
Ga,194,143,143,C28F8F
Ge,102,143,143,668F8F
As,189,128,227,BD80E3
Se,255,161,0,FFA100
Br,166,41,41,A62929
Kr,92,184,209,5CB8D1
Rb,112,46,176,702EB0
Sr,0,255,0,00FF00
Y,148,255,255,94FFFF
Zr,148,224,224,94E0E0
Nb,115,194,201,73C2C9
Mo,84,181,181,54B5B5
Tc,59,158,158,3B9E9E
Ru,36,143,143,248F8F
Rh,10,125,140,0A7D8C
Pd,0,105,133,006985
Ag,192,192,192,C0C0C0
Cd,255,217,143,FFD98F
In,166,117,115,A67573
Sn,102,128,128,668080
Sb,158,99,181,9E63B5
Te,212,122,0,D47A00
I,148,0,148,940094
Xe,66,158,176,429EB0
Cs,87,23,143,57178F
Ba,0,201,0,00C900
La,112,212,255,70D4FF
Ce,255,255,199,FFFFC7
Pr,217,255,199,D9FFC7
Nd,199,255,199,C7FFC7
Pm,163,255,199,A3FFC7
Sm,143,255,199,8FFFC7
Eu,97,255,199,61FFC7
Gd,69,255,199,45FFC7
Tb,48,255,199,30FFC7
Dy,31,255,199,1FFFC7
Ho,0,255,156,00FF9C
Er,0,230,117,00E675
Tm,0,212,82,00D452
Yb,0,191,56,00BF38
Lu,0,171,36,00AB24
Hf,77,194,255,4DC2FF
Ta,77,166,255,4DA6FF
W,33,148,214,2194D6
Re,38,125,171,267DAB
Os,38,102,150,266696
Ir,23,84,135,175487
Pt,208,208,224,D0D0E0
Au,255,209,35,FFD123
Hg,184,184,208,B8B8D0
Tl,166,84,77,A6544D
Pb,87,89,97,575961
Bi,158,79,181,9E4FB5
Po,171,92,0,AB5C00
At,117,79,69,754F45
Rn,66,130,150,428296
Fr,66,0,102,420066
Ra,0,125,0,007D00
Ac,112,171,250,70ABFA
Th,0,186,255,00BAFF
Pa,0,161,255,00A1FF
U,0,143,255,008FFF
Np,0,128,255,0080FF
Pu,0,107,255,006BFF
Am,84,92,242,545CF2
Cm,120,92,227,785CE3
Bk,138,79,227,8A4FE3
Cf,161,54,212,A136D4
Es,179,31,212,B31FD4
Fm,179,31,186,B31FBA
Md,179,13,166,B30DA6
No,189,13,135,BD0D87
Lr,199,0,102,C70066
Rf,204,0,89,CC0059
Db,209,0,79,D1004F
Sg,217,0,69,D90045
Bh,224,0,56,E00038
Hs,230,0,46,E6002E
Mt,235,0,38,EB0026
""")