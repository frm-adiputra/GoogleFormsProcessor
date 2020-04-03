using GoogleFormsProcessor
using DataFrames

@testset "FormSpec" begin
    df = DataFrame(A = 1:7, B = 9:15)

    @test names(generate(FormSpec([
        HasOther(:A, [1, 3, 5])
    ]), df)) == [
        Symbol("A")
        Symbol("B")
        Symbol("A -- __other__")
    ]
end
