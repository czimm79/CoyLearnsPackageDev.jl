module CoyLearnsPackageDev

# module level functions
greet(x) = println("Hey package user $(x)!")
export greet

# including everything
include("functions.jl")
include("fft.jl")

# fft functions
export fit_line, fftclean

# superficial stuff
export my_f, super_function

end
