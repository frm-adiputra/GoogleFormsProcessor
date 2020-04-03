using DataFrames

struct FormSpec
    questionSpec::Vector{AbstractQuestionSpec}
end

function generate(fs::FormSpec, df::DataFrame)
    dfcpy = copy(df)
    for v in fs.questionSpec
        r = generate(v, df)
        for i in r
            dfcpy[!, i.name] = i.data
        end
    end
    return dfcpy
end
