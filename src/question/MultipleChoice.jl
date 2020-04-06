struct MultipleChoice <: AbstractHasOtherAnswer
    name::Symbol
    values::Vector
end

function describe(q::MultipleChoice, df::DataFrame)
    by(df, q.name, N = q.name => length)
end
