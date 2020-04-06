# struct MultipleValues <: AbstractQuestionSpec
#     name::Symbol
#     values::Vector{String}
# end

function generate(q::AbstractHasMultipleAnswers, df::DataFrame)::Vector{QuestionSpecResult}
    dfr = DataFrame()
    n = nrow(df)

    for c in q.values
        dfr[!, valueColName(q.name, c)] = fill(false, n)
    end
    dfr[!, otherColName(q.name)] = Array{Union{Missing, String}}(missing, n)

    d = df[!, q.name]
    for i in eachindex(d)
        if ismissing(d[i])
            continue
        end

        sv = [strip(x) for x in split(d[i], ",")]
        others = []
        for e in sv
            if e in q.values
                dfr[i, valueColName(q.name, e)] = true
            else
                push!(others, e)
            end
        end

        if length(others) != 0
            dfr[i, otherColName(q.name)] = join(others, ", ")
        end
    end

    result = []
    for name in names(dfr)
        push!(result, QuestionSpecResult(
            name,
            dfr[!, name]
        ))
    end
    result
end
