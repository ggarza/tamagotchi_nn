# https://docs.julialang.org/en/v1/stdlib/Test/
# https://www.matecdev.com/posts/julia-testing.html
# https://discourse.julialang.org/t/getting-started-with-unit-testing-in-julia/19216

using Test
include("../auto_differentiation01.jl")

@testset "1D Auto Differention" begin
    @test D(3,5) == D(3.0, 5.0) # test dual number constructor

    func1(x) = x # simple function
    @test func1(D(3,5)) == D(3, 5)

    func2(x) = x + 7 # tests addition
    @test func2(D(11, 1)) == D(11 + 7, 1)

    func3(x) = x - 7 # tests subtraction
    @test func3(D(11, 1)) == D(11 - 7, 1)

    func4(x) = x * x # tests multiplication
    @test func4(D(11, 1)) == D(11 * 11 , 2 * 11)

    func5(x) = 1 / x # tests division
    @test func5(D(11, 1)) == D( 1/11, - 1/ (11 *11))

    func6(x) = x^2 - 3x + 7 # tests addition, subtraction, multiplication, exponentiation
    @test func6(D(11, 1)) == D(11^2 - 11*3 + 7, 2*11 - 3)

    func7(x) = exp(x) # tests exponent function 
    @test func7(D(11, 1)) == D(exp(11), exp(11))

    func8(x) = exp(x^3 - 13x) # tests composition and exponent function 
    @test func8(D(11, 1)) == D(exp(11^3 - 13 * 11), (3*11^2 -13)*exp(11^3 - 13 * 11))
end 