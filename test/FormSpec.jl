using GoogleFormsProcessor
using DataFrames

@testset "FormSpec" begin
    df = DataFrame(A = 1:5, B = [
        "a, b, c"
        "a, b"
        "a"
        "a, d, c"
        "a, d, c, e"
    ])

    @test names(generate(FormSpec([
        HasOther(:A, [1, 3, 5]),
        MultipleValues(:B, ["a", "b", "c"])
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
