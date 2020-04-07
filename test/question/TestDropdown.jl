using GoogleFormsProcessor
using DataFrames

@testset "Dropdown" begin
    @testset "generate" begin
        df = DataFrame(Col = [ "a"; "b" ])
        result = generate(Dropdown(:Col), df)

        @test length(result) == 0
    end

    @testset "describe" begin
        df = DataFrame(Col = [
            "a"
            "b"
            "a"
            "b"
            "a"
            missing
        ])

        result = GoogleFormsProcessor.describe(Dropdown(:Col), df)

        @test isequal(result[!, :Col], [
            "a"
            "b"
            missing
        ])

        @test isequal(result[!, :N], [
            3
            2
            1
        ])
    end
end
