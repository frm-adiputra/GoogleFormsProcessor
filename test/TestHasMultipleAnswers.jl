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
    describeMatrixResult = GoogleFormsProcessor.describeMatrix(q, generatedResult)
    textAnswersResult = GoogleFormsProcessor.textAnswers(q, generatedResult)

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
        @test nrow(describedResult) === 5
        @test isequal(describedResult[!, 1], ["a", "b", "c", otherName, missing])
        @test isequal(describedResult[!, :N], [5, 2, 3, 2, 1])
    end

    @testset "describeMatrix" begin
        @test isequal(names(describeMatrixResult), [:a, :b, :c, :other, :N, :P])
        @test isequal(describeMatrixResult[!, :a], [true, true, true, true, false])
        @test isequal(describeMatrixResult[!, :b], [false, true, true, false, false])
        @test isequal(describeMatrixResult[!, :c], [true, true, false, false, false])
        @test isequal(describeMatrixResult[!, :other], [true, false, false, false, false])
        @test isequal(describeMatrixResult[!, :N], [2, 1, 1, 1, 1])
        @test isequal(describeMatrixResult[!, :P], [(2/6)*100, (1/6)*100, (1/6)*100, (1/6)*100, (1/6)*100])
    end

    @testset "textAnswers" begin
        @test names(textAnswersResult) == Symbol.(["Isian lainnya", "N"])
        @test textAnswersResult[!, 1] == ["d", "d, e"]
        @test textAnswersResult[!, 2] == [1, 1]
    end
end
