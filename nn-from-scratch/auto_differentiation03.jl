# we use hyper dual numbers to implement automatic differentiation
# including the second derivative

struct D <: Number # our dual number type is a subtype of Number
    value::Float64
    eps1::Float64
    eps2::Float64
    eps3::Float64
end


Base.:+(x::D, y::D) = D(x.value + y.value, 
                        x.eps1 + y.eps1,
                        x.eps2 + y.eps2,
                        x.eps3 + y.eps3)
Base.:-(x::D, y::D) = D(x.value - y.value, 
                        x.eps1 - y.eps1,
                        x.eps2 - y.eps2,
                        x.eps3 - y.eps3)
Base.:*(x::D, y::D) = D(x.value * y.value, 
                        x.value * y.eps1 + x.eps1 * y.value,
                        x.value * y.eps2 + x.eps2 * y.value,
                        x.value * y.eps3 + x.eps1 * y.eps2 + x.eps2 * y.eps1 + x.eps3 * y.value)    
Base.:/(x::D, y::D) = D(x.value / y.value, 
                (x.eps1 * y.value - x.value * y.eps1) / (y.value^2),
                (x.eps2 * y.value - x.value * y.eps2) / (y.value^2),
                (x.eps3 * y.value - x.value * x.eps1 - x.eps1 * y.eps2 - x.eps2 * y.eps1)/ (y.value^2) + (2 * x.value * y.eps1 * y.eps2)/(y.value^3))


Base.convert(::Type{D}, r::Real) = D(r, 0.0, 0.0, 0.0) # convert real numbers to dual numbers
Base.promote_rule(::Type{D}, ::Type{<:Real}) = D
Base.show(io::IO, x::D) = print(io, x.value, 
                            " + ", x.eps1, "ϵ₁",
                            " + ", x.eps2, "ϵ₂",
                            " + ", x.eps3, "ϵ₁ϵ₂")

Base.exp(x::D) = D(exp(x.value), 
                   exp(x.value) * x.eps1, 
                   exp(x.value) * x.eps2, 
                   exp(x.value) * x.eps3 + exp(x.value) * x.eps1 * x.eps2 
                   ) # define exp for dual numbers

const ϵ₁ = D(0,1,0,0)
const ϵ₂ = D(0,0,1,0)
const ϵ₁ϵ₂ = D(0,0,0,1)
const ϵ₂ϵ₁ = D(0,0,0,1)

function test1(x)
    return x^2 + 3x + 2
end

x = test1(7 + ϵ₁ + ϵ₂ + ϵ₁ϵ₂)

x.value # 7^2 + 3*7 + 2 = 49 + 21 + 2 = 72
x.eps1 # 2*7 + 3 = 14 + 3 = 17
x.eps3 - x.eps2 # 2


function test2(x)
    return exp(x^2 + 3x + 2)
end


x = test2(7 + ϵ₁ + ϵ₂ + ϵ₁ϵ₂) 
print((x.value, x.eps1, x.eps3-x.eps1), "\n", (exp(72), exp(72)*17, 2 * exp(72) + exp(72) * 289))