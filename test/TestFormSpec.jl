using GoogleFormsProcessor
using DataFrames

@testset "FormSpec" begin
    @testset "constructor" begin
        fs = FormSpec([
            Dropdown(:ColA, ["a", "b", "c"]),
            Dropdown(:ColB, ["a", "b", "c"])
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
            Symbol("A -- __other__")
            Symbol("B -- 'a'")
            Symbol("B -- 'b'")
            Symbol("B -- 'c'")
            Symbol("B -- __other__")
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
