using GoogleFormsProcessor
using DataFrames

@testset "HasTextAnswers" begin
    df = DataFrame(Col = [
        "abc"
        "ab"
        "ab"
        "ab"
        "a"
        "a"
        "adc"
        "adce"
        missing
    ])

    q = ShortAnswer(:Col)

    generatedResult = GoogleFormsProcessor.generate(FormSpec([q]), df)
    textAnswersResult = GoogleFormsProcessor.textAnswers(q, generatedResult)

    @testset "textAnswers" begin
        @test names(textAnswersResult) == Symbol.(["Col --- Isian", "N"])
        @test isequal(textAnswersResult[!, 1], ["ab", "a", "abc", "adc", "adce", missing])
        @test textAnswersResult[!, 2] == [3, 2, 1, 1, 1, 1]
    end
end
