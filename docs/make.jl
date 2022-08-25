using Documenter, CoyLearnsPackageDev

DocMeta.setdocmeta!(CoyLearnsPackageDev, :DocTestSetup, :(using CoyLearnsPackageDev); recursive=true)
makedocs(sitename="CoyLearnsPackageDev.jl", format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"))

deploydocs(repo = "github.com/czimm79/CoyLearnsPackageDev.jl.git")