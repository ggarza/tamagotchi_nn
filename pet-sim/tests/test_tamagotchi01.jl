using Test
include("../tamagotchi01.jl")

@testset "Tamagotchi State Transitions" begin
    pet = Tamagotchi()

    # Test initial state
    @test pet.hunger == 5
    @test pet.happiness == 5

    # Feed action
    pet2 = update(pet, "feed")
    @test pet2.hunger == 3
    @test pet2.happiness == 5

    # Play action
    pet3 = update(pet, "play")
    @test pet3.hunger == 6  # hunger +1
    @test pet3.happiness == 7  # happiness +2

    # Wait action
    pet4 = update(pet, "wait")
    @test pet4.hunger == 6
    @test pet4.happiness == 4
end