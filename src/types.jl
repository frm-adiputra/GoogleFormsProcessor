abstract type AbstractQuestionSpec end
abstract type AbstractQuestion end
abstract type AbstractHasOtherAnswer <: AbstractQuestion end
abstract type AbstractHasMultipleAnswers <: AbstractQuestion end

struct QuestionSpecResult
    name::Symbol
    data::Vector{Any}
end
