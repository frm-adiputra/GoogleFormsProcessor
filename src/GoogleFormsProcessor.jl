module GoogleFormsProcessor

export FormSpec
export Dropdown, Checkboxes, MultipleChoice, ShortAnswer, Paragraph
export generate, describe
export valueColName, otherColName, setOtherName, otherName

using DataFrames

otherName = "other"

function setOtherName(v)
    global otherName
    otherName = v
end

function valueColName(col::Symbol, value)
    Symbol(col, " -- ", "'", value, "'")
end

function otherColName(col::Symbol)
    Symbol(col, " -- _$(otherName)_")
end

include("types.jl")
include("FormSpec.jl")
include("HasOther.jl")
include("HasMultipleAnswers.jl")
include("question/Dropdown.jl")
include("question/Checkboxes.jl")
include("question/MultipleChoice.jl")
include("question/ShortAnswer.jl")
include("question/Paragraph.jl")

end # module
