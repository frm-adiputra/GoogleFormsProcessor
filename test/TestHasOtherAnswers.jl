using GoogleFormsProcessor
using DataFrames

@testset "HasOtherAnswers" begin
    @testset "generate" begin
        df = DataFrame(A = 1:7, B = 9:15)

        result = GoogleFormsProcessor.generate(MultipleChoice(:A, [1, 3, 5]), df)

        @test result[1].name == otherColName(:A)

        @test result[1].data == [
            false
            true
            false
            true
            false
            true
            true
        ]
    end

    @testset "textAnswers" begin
        df0 = DataFrame(A = ["a", "b", "c", "d", "c"])
        q = MultipleChoice(:A, ["a", "b"])
        df = GoogleFormsProcessor.generate(FormSpec([q]), df0)
        result = textAnswers(q, df)

        @test names(result) == Symbol.(["A --- Isian lainnya", "N"])
        @test result[!, 1] == ["c", "d"]
        @test result[!, 2] == [2, 1]
    end
end
