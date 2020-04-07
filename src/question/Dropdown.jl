struct Dropdown <: AbstractQuestion
    name::Symbol
end

function generate(q::Dropdown, df::DataFrame)::Vector{QuestionSpecResult}
    []
end

function describe(q::Dropdown, df::DataFrame)
    ntot = nrow(df)
    by(df, q.name, N = q.name => length, P = [q.name] => x -> (length(x[q.name])/ntot) * 100)
end
