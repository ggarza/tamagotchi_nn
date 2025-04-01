# Hidden layer: 2 perceptrons
# Output layer: 1 perceptron that takes the outputs from the hidden layer

function sigmoid(x)
    1.0 / (1.0 + exp(-x))
end

# define the network layer as matrix multiplication
function layer(inputs, weights, biases)
    sigmoid.(weights' * inputs .+ biases)
end


inputs = [1.0, 0.0, 1.0]


# Hidden layer 1
w1 = [0.5 -0.3; -0.6 0.8; 0.1 0.7]
b1 = [0.0; -0.1]

h1 = layer(inputs, w1, b1)
println("Hidden layer 1 output: ", h1)


# Output layer
w_out = [0.6; -0.4]
b_out = 0.2

o = layer(h1, w_out, b_out)
println("Output layer output: ", o)