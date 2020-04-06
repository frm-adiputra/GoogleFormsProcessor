# struct HasOther <: AbstractQuestionSpec
#     name::Symbol
#     options::Vector{Any}
# end

function generate(q::AbstractHasOtherAnswer, df::DataFrame)::Vector{QuestionSpecResult}
    [QuestionSpecResult(
        otherColName(q.name),
        [ x in q.values for x in df[!, q.name]]
    );]
end

function describe(q::AbstractHasOtherAnswer, df::DataFrame)
    by(df, q.name, N = q.name => length)
end
