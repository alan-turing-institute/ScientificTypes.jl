@testset "scitype" begin
    X = [1, 2, 3]
    @test scitype(X) == AbstractVector{Unknown}

    @test scitype(missing) == Missing
    @test scitype((5, 2)) == Tuple{Unknown,Unknown}
    anyv = Any[5]
    @test scitype(anyv[1]) == Unknown

    X = [missing, 1, 2, 3]
    @test scitype(X) == AbstractVector{Union{Missing, Unknown}}

    Xnm = X[2:end]
    @test scitype(Xnm) == AbstractVector{Union{Missing, Unknown}}
    @test scitype(Xnm, tight=true) == AbstractVector{Unknown}

    Xm = Any[missing, missing]
    @test scitype(Xm) == AbstractVector{Missing}
end

@testset "scitype2" begin
    ScientificTypes.Scitype(::Type{<:Integer}, ::MockMLJ) = Count
    X = [1, 2, 3]
    @test scitype(X) == AbstractVector{Count}
    Xm = [missing, 1, 2, 3]
    @test scitype(Xm) == AbstractVector{Union{Missing,Count}}
    Xnm = Xm[2:end]
    @test scitype(Xnm) == AbstractVector{Union{Missing,Count}}
    @test scitype(Xnm; tight=true) == AbstractVector{Count}

    @test elscitype(X) == Count
    @test elscitype(Xm) == Union{Missing,Count}
    @test elscitype(Xnm) == Union{Missing,Count}
    @test elscitype(Xnm, tight=true) == Count
end
