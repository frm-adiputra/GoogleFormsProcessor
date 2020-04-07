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

    @testset "describeMatrix" begin
        @test isequal(names(describeMatrixResult), [:a, :b, :c, :other, :N])
        @test isequal(describeMatrixResult[!, :a], [false; fill(true, 4)])
        @test isequal(describeMatrixResult[!, :b], [fill(false, 3); fill(true, 2)])
        @test isequal(describeMatrixResult[!, :c], [false, false, true, false, true])
        @test isequal(describeMatrixResult[!, :other], [false, false, true, false, false])
        @test isequal(describeMatrixResult[!, :N], [1, 1, 2, 1, 1])
    end
end
