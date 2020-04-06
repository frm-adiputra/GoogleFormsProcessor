using GoogleFormsProcessor
using DataFrames

@testset "HasMultipleAnswers" begin
    df = DataFrame(Col = [
        "a, b, c"
        "a, b"
        "a"
        "a, d, c"
        "a, d, c, e"
        missing
    ])

    q = Checkboxes(:Col, ["a", "b", "c"])

    generatedResult = GoogleFormsProcessor.generate(FormSpec([q]), df)
    describedResult = GoogleFormsProcessor.describe(q, generatedResult)

    @testset "generate" begin
        @test generatedResult[!, valueColName(:Col, "a")] == [
            true
            true
            true
            true
            true
            false
        ]

        @test generatedResult[!, valueColName(:Col, "b")] == [
            true
            true
            false
            false
            false
            false
        ]

        @test isequal(generatedResult[!, otherColName(:Col)], [
            missing
            missing
            missing
            "d"
            "d, e"
            missing
        ])
    end

    @testset "describe" begin
        @test nrow(describedResult) === 4
        @test isequal(describedResult[!, 1], ["a", "b", "c", otherName])
        @test isequal(describedResult[!, :N], [5, 2, 3, 2])
    end
end
