function generate(q::AbstractHasTextAnswers, df::DataFrame)::Vector{QuestionSpecResult}
    []
end

function describe(q::AbstractHasTextAnswers, df::DataFrame)
    ntot = nrow(df)
    by(df, q.name, N = q.name => length, P = [q.name] => x -> (length(x[q.name])/ntot) * 100)
end

function textAnswers(q::AbstractHasTextAnswers, df::DataFrame)
    dd = by(df, q.name, N = q.name => length)
    sort!(dd, [:N, q.name], rev = (true, false))
    rename!(dd, [Symbol(q.name, " --- Isian"); :N])
end
