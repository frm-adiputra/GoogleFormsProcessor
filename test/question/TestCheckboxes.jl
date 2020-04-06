using GoogleFormsProcessor
using DataFrames

@testset "Checkboxes" begin
    @testset "generate" begin
        df = DataFrame(Col = [ "a"; "b" ])
        result = generate(Checkboxes(:Col, ["a", "b", "c"]), df)

        @test length(result) == 4
    end

    # @testset "describe" begin
    #     df = DataFrame(Col = [
    #         "a"
    #         "b"
    #         "a"
    #         "b"
    #         "a"
    #         missing
    #     ])

    #     result = GoogleFormsProcessor.describe(Dropdown(:Col, ["a", "b", "c"]), df)

    #     @test isequal(result[!, :Col], [
    #         "a"
    #         "b"
    #         missing
    #     ])

    #     @test isequal(result[!, :N], [
    #         3
    #         2
    #         1
    #     ])
    # end
end
