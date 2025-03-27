
inputs = [1.0, 0.0, 1.0]
weights = [0.8, -0.5, 0.3]
bias = -0.2


# The step function is used to determine the output of the perceptron.

function step(x)
    return x >= 0 ? 1.0 : 0.0
end

function sigmoid(x)
    return 1.0 / (1.0 + exp(-x))
end

# The perceptron will output 1 if the weighted sum of inputs plus bias is greater than or equal to 0,
function predict(inputs, weights, bias)
    z = sum(inputs .* weights) + bias
    return step(z)
end


predict(inputs, weights, bias)


function loss(prediction, target)
    return (prediction - target)^2
end


weights = [11, -0.5, 0.3]
loss(predict(inputs, weights, bias), 1.0)  # Assuming the target output is 1.0