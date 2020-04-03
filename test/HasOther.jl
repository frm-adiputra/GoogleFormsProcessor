using GoogleFormsProcessor
using DataFrames

@testset "HasOther" begin
    df = DataFrame(A = 1:7, B = 9:15)

    @test HasOther(:A, [1:3;]).options == [1:3;]

    @test generate(HasOther(:A, [1, 3, 5]), df)[1].name == Symbol("A -- __other__")

    @test generate(HasOther(:A, [1, 3, 5]), df)[1].data == [
        true
        false
        true
        false
        true
        false
        false
    ]
end
