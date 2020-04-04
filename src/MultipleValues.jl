using DataFrames

struct MultipleValues <: AbstractQuestionSpec
    name::Symbol
    values::Vector{String}
end

function generate(s::MultipleValues, df::DataFrame)::Vector{QuestionSpecResult}
    dfr = DataFrame()
    n = nrow(df)

    for c in s.values
        dfr[!, valueColName(s.name, c)] = fill(false, n)
    end
    dfr[!, otherColName(s.name)] = Array{Union{Missing, String}}(missing, n)

    d = df[!, s.name]
    for i in eachindex(d)
        if ismissing(d[i])
            continue
        end

        sv = [strip(x) for x in split(d[i], ",")]
        others = []
        for e in sv
            if e in s.values
                dfr[i, valueColName(s.name, e)] = true
            else
                push!(others, e)
            end
        end

        if length(others) != 0
            dfr[i, otherColName(s.name)] = join(others, ", ")
        end
    end
    dfr
    result = []
    for name in names(dfr)
        push!(result, QuestionSpecResult(
            name,
            dfr[!, name]
        ))
    end
    result
end
