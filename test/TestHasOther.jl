using GoogleFormsProcessor
using DataFrames

@testset "generate data for HasOtherAnswer" begin
    df = DataFrame(A = 1:7, B = 9:15)

    # @test HasOther(:A, [1:3;]).options == [1:3;]

    @test GoogleFormsProcessor.generate(MultipleChoice(:A, [1, 3, 5]), df)[1].name == otherColName(:A)

    @test GoogleFormsProcessor.generate(MultipleChoice(:A, [1, 3, 5]), df)[1].data == [
        true
        false
        true
        false
        true
        false
        false
    ]
end
