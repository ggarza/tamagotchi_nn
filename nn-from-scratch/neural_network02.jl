# Hidden layer: 2 perceptrons
# Output layer: 1 perceptron that takes the outputs from the hidden layer


#  Define the activation function and perceptron 
function step(x)
    return x >= 0 ? 1.0 : 0.0
end

function perceptron(inputs, weights, bias)
    z = sum(inputs .* weights) + bias
    return step(z)
end


# Define the hidden layer
function hidden_layer(inputs)
    # Hidden neuron 1
    w1 = [0.5, -0.6, 0.1]
    b1 = 0.0
    h1 = perceptron(inputs, w1, b1)

    # Hidden neuron 2
    w2 = [-0.3, 0.8, 0.7]
    b2 = -0.1
    h2 = perceptron(inputs, w2, b2)

    return [h1, h2]
end


# Define the output layer
function output_layer(hidden_outputs)
    w_out = [0.6, -0.4]
    b_out = 0.2
    return perceptron(hidden_outputs, w_out, b_out)
end


# Run the full network
function predict(inputs)
    h = hidden_layer(inputs)
    return output_layer(h)
end


# Try it!
inputs = [1.0, 0.0, 1.0]
println("Network output: ", predict(inputs))


# loss function
function loss(prediction, target)
    return (prediction - target)^2
end