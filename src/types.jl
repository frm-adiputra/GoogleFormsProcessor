abstract type AbstractQuestionSpec end
abstract type AbstractQuestion end
abstract type AbstractHasOtherAnswers <: AbstractQuestion end
abstract type AbstractHasMultipleAnswers <: AbstractQuestion end
abstract type AbstractHasTextAnswers <: AbstractQuestion end

struct QuestionSpecResult
    name::Symbol
    data::Vector{Any}
end
