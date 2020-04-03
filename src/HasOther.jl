using DataFrames

struct HasOther <: AbstractQuestionSpec
    name::Symbol
    options::Vector{Any}
end

function generate(v::HasOther, df::DataFrame)::Vector{QuestionSpecResult}
    [QuestionSpecResult(
        otherColName(v.name),
        [ x in v.options for x in df[!, v.name]]
    );]
end
