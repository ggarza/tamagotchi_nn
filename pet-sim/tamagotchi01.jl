# Simple Tamagotchi Simulation in Julia
# This code defines a simple Tamagotchi simulation where you can feed, play with, or let the pet wait.

# Tamagotchi Type
struct Tamagotchi
    hunger::Int
    happiness::Int
end

# Outer constructor
function Tamagotchi()
    # uses inner constructor
    Tamagotchi(5, 5) # Default values for hunger and happiness
end

# Display the current state
function show_status(pet::Tamagotchi)
    println("Hunger: $(pet.hunger), Happiness: $(pet.happiness)")
end

# Update the pet state based on an action
function update(pet::Tamagotchi, action::String)
    hunger = pet.hunger
    happiness = pet.happiness

    if action == "feed"
        hunger = max(hunger - 2, 0)
    elseif action == "play"
        happiness = min(happiness + 2, 10)
        hunger = min(hunger + 1, 10)
    elseif action == "wait"
        hunger = min(hunger + 1, 10)
        happiness = max(happiness - 1, 0)
    else
        println("Unknown action.")
    end

    Tamagotchi(hunger, happiness)
end

# Simple interactive loop (for testing)
function run_simulation()
    pet = Tamagotchi()
    for t in 1:10
        println("\n--- Time Step $t ---")
        show_status(pet)
        println("Choose action: feed, play, wait")
        action = readline()
        pet = update(pet, action)
    end
    println("\nFinal Status:")
    show_status(pet)
end

# Uncomment to run
run_simulation()