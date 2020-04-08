struct FormSpec
    questions::Dict{Symbol,AbstractQuestion}
    FormSpec(v::Vector{<:AbstractQuestion}) = new(Dict{Symbol,AbstractQuestion}(x.name => x for x in v))
end

function describe(fs::FormSpec, questionName::Symbol, df::DataFrame)
    if !haskey(fs.questions, questionName)
        error("question name not found: $questionName")
    end
    q = fs.questions[questionName]
    describe(q, df)
end

function describeMatrix(fs::FormSpec, questionName::Symbol, df::DataFrame)
    if !haskey(fs.questions, questionName)
        error("question name not found: $questionName")
    end
    q = fs.questions[questionName]
    describeMatrix(q, df)
end

function textAnswers(fs::FormSpec, questionName::Symbol, df::DataFrame)
    if !haskey(fs.questions, questionName)
        error("question name not found: $questionName")
    end
    q = fs.questions[questionName]
    textAnswers(q, df)
end

function generate(fs::FormSpec, df::DataFrame)
    dfcpy = copy(df)
    for v in values(fs.questions)
        r = generate(v, df)
        for i in r
            dfcpy[!, i.name] = i.data
        end
    end
    return dfcpy
end
