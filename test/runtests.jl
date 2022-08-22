using CoyLearnsPackageDev
using Test

println("hi")

@testset "CoyLearnsPackageDev.jl Unit tests" begin
    @test my_f(2, 1) == 7
end
