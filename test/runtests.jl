using Test, Documenter
using CoyLearnsPackageDev

@testset "documenter tests" begin
    DocMeta.setdocmeta!(CoyLearnsPackageDev, :DocTestSetup, :(using CoyLearnsPackageDev); recursive=true)
    doctest(CoyLearnsPackageDev)
end

@testset "superficial" begin
    @test my_f(2, 1) == 7
    @test super_function(3, 3) == 18
end

@testset "FFT" begin
    error_tolerance = 0.055

    # setup waveform with linear trend
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

    @test isapprox(m, m_true, atol=error_tolerance)
    @test isapprox(b, b_true, atol=error_tolerance)

    # detrend
    y_detrended = CoyLearnsPackageDev.detrend(y)
    
    @test isapprox(fit_line(x, y_detrended)[1], 0.0, atol=error_tolerance)

    # fft
    xf, yf = fftclean(x, y)
    @test isapprox(yf[argmax(yf)], a1, atol=error_tolerance)
    @test isapprox(xf[argmax(yf)], f1, atol=error_tolerance)

end
