struct Checkboxes <: AbstractHasMultipleAnswers
    name::Symbol
    values::Vector{String}
end

function describe(q::Checkboxes, df::DataFrame)
    by(df, q.name, N = q.name => length)
end
