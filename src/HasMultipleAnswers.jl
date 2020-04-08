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
    dfr[!, otherFlagColName(q.name)] = fill(false, n)

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
            dfr[i, otherFlagColName(q.name)] = true
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

function describe(q::AbstractHasMultipleAnswers, df::DataFrame)
    dfr = DataFrame()
    dfr[!, q.name] = []
    dfr[!, :N] = []
    dfr[!, :P] = []
    ntot = nrow(df)

    for v in q.values
        n = length(df[df[!, valueColName(q.name, v)] .=== true, q.name])
        push!(dfr, (v, n, (n/ntot)*100))
    end

    # other values
    nother = length(collect(skipmissing(df[!, otherColName(q.name)])))
    push!(dfr, (otherName, nother, (nother/ntot)*100))
    return dfr
end

function describeMatrix(q::AbstractHasMultipleAnswers, df::DataFrame)
    ntot = nrow(df)
    longColNames = [[valueColName(q.name, v) for v in q.values]; otherFlagColName(q.name)]

    result = by(df, longColNames, N = q.name => length, P = [q.name] => x -> (length(x[q.name])/ntot) * 100)
    rename!(result, [Symbol.(q.values); Symbol(otherName); :N; :P])
    sort!(result, :N, rev = true)

    result
end
