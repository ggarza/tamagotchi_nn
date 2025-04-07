# https://docs.julialang.org/en/v1/stdlib/Test/
# https://www.matecdev.com/posts/julia-testing.html
# https://discourse.julialang.org/t/getting-started-with-unit-testing-in-julia/19216

using Test
include("../tamagotchi01.jl")

@testset "Tamagotchi State Transitions" begin
    pet = Tamagotchi()

    # Test initial state
    @test pet.hunger == 5
    @test pet.happiness == 5

    # Feed action
    pet2 = update(pet, "feed")
    @test pet2.hunger < pet.hunger  # hunger should decrease
    @test pet2.happiness >= pet.happiness  # happiness should not decrease

    # Play action
    pet3 = update(pet, "play")
    @test pet3.hunger > pet.hunger  # hunger +1
    @test pet3.happiness > pet.happiness  # happiness +2

    # Wait action
    pet4 = update(pet, "wait")
    @test pet4.hunger > pet.hunger
    @test pet4.happiness < pet.happiness
end