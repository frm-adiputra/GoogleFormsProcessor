struct Dropdown <: AbstractQuestion
    name::Symbol
end

function generate(q::Dropdown, df::DataFrame)::Vector{QuestionSpecResult}
    []
end

function describe(q::Dropdown, df::DataFrame)
    by(df, q.name, N = q.name => length)
end
