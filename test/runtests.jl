using Test
using CoyLearnsPackageDev

@testset "superficial" begin
    @test my_f(2, 1) == 7
    @test super_function(3, 3) == 18
end

@testset "FFT" begin
    tol = 0.055
    # setup
    f1 = 3
    f2 = 5
    a1 = 1
    a2 = 0.5
    m_true = 8
    b_true = 3

    f(x) = a1*sin(f1*2π*x) + a2*sin(f2*2π*x) + m_true*x + b_true

    x = range(0, 2π, length=100)
    y = f.(x)

    # fit_line
    m, b = fit_line(x, y)

    @test isapprox(m, m_true, atol=tol)
    @test isapprox(b, b_true, atol=tol)

    # detrend
    y_detrended = CoyLearnsPackageDev.detrend(y)
    
    @test isapprox(fit_line(x, y_detrended)[1], 0.0, atol=tol)

    # fft
    xf, yf = fftclean(x, y)
    @test isapprox(yf[argmax(yf)], a1, atol=tol)
    @test isapprox(xf[argmax(yf)], f1, atol=tol)

    println(3)
end
