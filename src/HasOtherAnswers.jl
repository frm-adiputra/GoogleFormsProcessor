function generate(q::AbstractHasOtherAnswers, df::DataFrame)::Vector{QuestionSpecResult}
    [QuestionSpecResult(
        otherColName(q.name),
        [ !(x in q.values) for x in df[!, q.name]]
    );]
end

function describe(q::AbstractHasOtherAnswers, df::DataFrame)
    ntot = nrow(df)
    by(df, q.name, N = q.name => length, P = [q.name] => x -> (length(x[q.name])/ntot) * 100)
end

function textAnswers(q::AbstractHasOtherAnswers, df::DataFrame)
    df0 = df[df[!, otherColName(q.name)] .=== true, :]
    dd = by(df0, q.name, N = q.name => length)
    sort!(dd, [:N, q.name], rev = (true, false))
    rename!(dd, [Symbol("Isian lainnya"); :N])
end
