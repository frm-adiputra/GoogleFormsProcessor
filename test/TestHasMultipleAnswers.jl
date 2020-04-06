using GoogleFormsProcessor
using DataFrames

@testset "generate data for HasMultipleAnswers" begin
    df = DataFrame(Col = [
        "a, b, c"
        "a, b"
        "a"
        "a, d, c"
        "a, d, c, e"
        missing
    ])

    result = GoogleFormsProcessor.generate(Checkboxes(:Col, ["a", "b", "c"]), df)

    @test result[1].data == [
        true
        true
        true
        true
        true
        false
    ]

    @test result[2].data == [
        true
        true
        false
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
        missing
    ])
end
