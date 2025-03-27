# This is a simple example of a perceptron in Julia.
# It demonstrates how to implement a perceptron that takes three inputs,
# applies weights to them, adds a bias, and uses a step function to produce an output.

# In our example, we are training a perceptron to decide whether or not 
# to feed a virtual pet. The inputs represent the pet's hunger level,
# sleepiness level, and boredom level. The weights represent the importance
# of each input, and the bias represents a threshold that must be met for the pet to be fed.

# The inputs, weights, and bias are defined as follows:
# Inputs: [hunger, sleepiness, boredom]
# Weights: [0.8, -0.5, 0.3] (indicating the importance of each input)
# Bias: -0.2 (indicating the threshold for feeding the pet)


inputs = [1.0, 0.0, 1.0]
weights = [0.8, -0.5, 0.3]
bias = -0.2


# The step function is used to determine the output of the perceptron.

function step(x)
    return x >= 0 ? 1.0 : 0.0
end


# The perceptron will output 1 if the weighted sum of inputs plus bias is greater than or equal to 0,
function predict(inputs, weights, bias)
    z = sum(inputs .* weights) + bias
    return step(z)
end


predict(inputs, weights, bias)

inputs = [1.0, 1.0, 0.0]
predict(inputs, weights, bias)