using GoogleFormsProcessor
using DataFrames

@testset "FormSpec" begin
    @testset "constructor" begin
        fs = FormSpec([
            Dropdown(:ColA),
            Dropdown(:ColB)
        ])

        @test fs.questions[:ColA].name == :ColA
        @test fs.questions[:ColB].name == :ColB
    end

    @testset "generate" begin
        df = DataFrame(A = 1:5, B = [
            "a, b, c"
            "a, b"
            "a"
            "a, d, c"
            "a, d, c, e"
        ])

        @test names(generate(FormSpec([
            MultipleChoice(:A, [1, 3, 5]),
            Checkboxes(:B, ["a", "b", "c"])
        ]), df)) == [
            Symbol("A")
            Symbol("B")
            otherColName(:A)
            valueColName(:B, "a")
            valueColName(:B, "b")
            valueColName(:B, "c")
            otherColName(:B)
            otherFlagColName(:B)
        ]
    end

    @testset "describe" begin
        df = DataFrame(A = 1:5, B = [
            "a, b, c"
            "a, b"
            "a"
            "a, d, c"
            "a, d, c, e"
        ])

        fs = FormSpec([
            MultipleChoice(:A, [1, 3, 5]),
            Checkboxes(:B, ["a", "b", "c"])
        ])

        @test_throws ErrorException GoogleFormsProcessor.describe(fs, :C, df)
    end
end
