module GoogleFormsProcessor

export FormSpec
export generate
export Dropdown, Checkboxes, MultipleChoice, describe

using DataFrames

function valueColName(col::Symbol, value)
    Symbol(col, " -- ", "'", value, "'")
end

function otherColName(col::Symbol)
    Symbol(col, " -- __other__")
end

include("types.jl")
include("FormSpec.jl")
include("HasOther.jl")
include("HasMultipleAnswers.jl")
include("question/Dropdown.jl")
include("question/Checkboxes.jl")
include("question/MultipleChoice.jl")

end # module
