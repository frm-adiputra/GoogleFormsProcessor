module GoogleFormsProcessor

export FormSpec
export Dropdown, Checkboxes, MultipleChoice, ShortAnswer, Paragraph
export generate, describe, describeMatrix, textAnswers
export valueColName, otherColName, otherFlagColName, setOtherName, otherName

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

function otherFlagColName(col::Symbol)
    Symbol(col, " -- _$(otherName)_flag_")
end

include("types.jl")
include("FormSpec.jl")
include("HasOtherAnswers.jl")
include("HasMultipleAnswers.jl")
include("HasTextAnswers.jl")
include("question/Dropdown.jl")
include("question/Checkboxes.jl")
include("question/MultipleChoice.jl")
include("question/ShortAnswer.jl")
include("question/Paragraph.jl")

# export scrap

# function scrap()
#     df = DataFrame(
#         A = ["a", "b", "a", "a"]
#     )
#     ntot = nrow(df)
#     by(df, :A, N = :A => length, P = [:A] => x -> (length(x[:A])/ntot) * 10)
# end

end # module
