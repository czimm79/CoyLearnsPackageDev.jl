module CoyLearnsPackageDev

greet(x) = println("Hey package user $(x)!")

include("functions.jl")

export my_f

end
