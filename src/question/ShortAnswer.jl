struct ShortAnswer <: AbstractQuestion
    name::Symbol
end

function generate(q::ShortAnswer, df::DataFrame)::Vector{QuestionSpecResult}
    []
end

function describe(q::ShortAnswer, df::DataFrame)
    by(df, q.name, N = q.name => length)
end
