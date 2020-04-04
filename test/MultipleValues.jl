using GoogleFormsProcessor
using DataFrames

@testset "MultipleValues" begin
    df = DataFrame(Col = [
        "a, b, c"
        "a, b"
        "a"
        "a, d, c"
        "a, d, c, e"
    ])

    result = generate(MultipleValues(:Col, ["a", "b", "c"]), df)

    @test result[1].data == [
        true
        true
        true
        true
        true
    ]

    @test result[2].data == [
        true
        true
        false
        false
        false
    ]

    @test isequal(result[4].data, [
        missing
        missing
        missing
        "d"
        "d, e"
    ])
end
