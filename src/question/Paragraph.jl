struct Paragraph <: AbstractQuestion
    name::Symbol
end

function generate(q::Paragraph, df::DataFrame)::Vector{QuestionSpecResult}
    []
end

function describe(q::Paragraph, df::DataFrame)
    by(df, q.name, N = q.name => length)
end
