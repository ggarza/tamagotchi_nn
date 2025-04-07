# we use dual numbers to implement automatic differentiation


function Babylonian(x; N=10)
    t = (1+x)/2 # one step from t=1
    for i in 2:N
        t = (t + x/t)/2
    end
    return t
end


struct D <: Number # our dual number type is a subtype of Number
    value::Float64
    derivative::Float64
end


Base.:+(x::D, y::D) = D(x.value + y.value, x.derivative + y.derivative)
Base.:-(x::D, y::D) = D(x.value - y.value, x.derivative - y.derivative)
Base.:*(x::D, y::D) = D(x.value * y.value, x.derivative * y.value + x.value * y.derivative)
Base.:/(x::D, y::D) = D(x.value / y.value, (x.derivative * y.value - x.value * y.derivative) / (y.value^2))


Base.convert(::Type{D}, r::Real) = D(r, 0.0) # convert real numbers to dual numbers
Base.promote_rule(::Type{D}, ::Type{<:Real}) = D
Base.show(io::IO, x::D) = print(io, x.value, " + ", x.derivative, "ε") # show dual numbers in a readable format

Base.exp(x::D) = D(exp(x.value), exp(x.value) * x.derivative) # define exp for dual numbers


x = 49
Babylonian(D(x, 1))


function logistic(x)
    1/(1 + exp(0-x))
end

exp(D(7,1))