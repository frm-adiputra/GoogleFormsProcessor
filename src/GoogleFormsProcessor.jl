module GoogleFormsProcessor

abstract type AbstractQuestionSpec end

export FormSpec
export HasOther, MultipleValues, generate

function valueColName(col::Symbol, value)
    Symbol(col, " -- ", "'", value, "'")
end

function otherColName(col::Symbol)
    Symbol(col, " -- __other__")
end

include("QuestionSpecResult.jl")
include("FormSpec.jl")
include("HasOther.jl")
include("MultipleValues.jl")

end # module
