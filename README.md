# CoyLearnsPackageDev

[![Documentation, latest](https://img.shields.io/badge/docs-latest-blue.svg)](https://czimm79.github.io/CoyLearnsPackageDev.jl/dev/)
[![Build Status](https://github.com/czimm79/CoyLearnsPackageDev.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/czimm79/CoyLearnsPackageDev.jl/actions/workflows/CI.yml?query=branch%3Amaster)

This repo is public so I can use GitHub Actions for free and learn about continuous integration (CI) while learning the ins and outs of proper Julia package development. None of this is really intended as a tutorial for others yet, and is just a reference for myself.

## My Resources

* <https://julialang.org/contribute/developing_package/> (Pretty good, but lacking the nitty gritty like proper order of operations with creating a repo. `.jl` is automatically added by some source?)

## WIP Self Q&A

> Why use julia package mode and `dev` a package? What does this do?

`dev`, or `develop` in julia Pkg mode `]` is a slick way to clone a public package and place it in your `user/.julia/dev` folder for you to develop and make changes to. The advantage here is that your environment now *uses that package*. You can check it using `]status`.

> How do I properly run the tests from the command line before pushing/committing?

Go into `Pkg` mode using `]` in the repl, then simply run `test`. This takes a bit longer as it looks like it creates a clean package environment. For quick testing, just run `include("test/runtests.jl")` in the VSCode julia terminal.

> What is a `git stash`?

It looks like its a way to save your work and restore the repo to the latest clean commit. This allows you to switch branches. I probably won't get to into this quite yet.

> How do I incorporate `Revise.jl`? Is it included in VSCode?

It is automatically included in the Julia VSCode extension, however, `Revise` must be added in the current package environment (`]add Revise` in Julia REPL). Then, when opening a new REPL in VSCode, it is automatically loaded. This prevents the need to reload the repo or some other funky stuff. Just change the source code in any files, then run whatever you want in the same repo and it will update behind the scenes.

> Are there any catches I need to be aware of when using `Revise.jl`?

* It looks like it needs to be added as a package *in the project you're working in* for VSCode to automatically load it.

> What are the important keybinds for `Julia in VSCode`?

Keybindings are [here](https://www.julia-vscode.org/docs/stable/userguide/keybindings/).

> How do I quickly and efficiently view Julia docs in VSCode? What are the keybinds?

Here's a link for [common features in the editor](https://code.visualstudio.com/Docs/editor/editingevolved). Click around, and the IntelliSense section has some good stuff, mainly the symbols and the `cntrl+space` keybind, which I will now use *HEAVILY*. (It shows the docs when autocompleting)

> How does Makie make use of `ReferenceTests.jl`? Will it be useful for my packages?

> Can I clone using `dev --local` as in the Makie docs, edit, create new branch, commit, push, and create PR? Read the contributing page [here](https://julialang.org/contribute/opportunities/), especially the guide to contributing to `Images.jl`.

Yes! I will attempt to do this whole process to fix a Makie documentation bug here soon...

> How do I create a package local environment and make it persist while I'm developing? Similar to Python virtual environments..?

So it looks like VSCode just does it automatically and stores it in the `Project.toml` and `Manifest.toml` files.

> How does Documenter.jl interact with `julia-repl` tags in docstrings for functions?

It doesn't. Instead, it looks at `jldoctest` snippets and tests them using `doctest(CoyLearnsPackageDev)` that I've included in `runtests.jl` according to the docs.

## Initializing a new package

1. Use `PkgTemplates` first. It needs to be added to the current environment if it hasn't been already (`]add PkgTemplates` in Julia REPL).

```julia
using PkgTemplates

t = Template(;
           user="czimm79",
           license="MIT",
           authors=["Coy Zimmermann"],
           plugins=[Git(),
               GitHubActions(),
           ],
       )

t("CoyLearnsPackageDev")
```

2. After running this code, there is a new package in `<user>/.julia/dev/`. Using GitHub Desktop, add a local repository from `<user>/.julia/dev/CoyLearnsPackageDev`.
3. Now, you should see this repo added into GitHub desktop with a `.jl` added at the end of the name, like `CoyLearnsPackageDevelopment.jl`.
4. If you try to push to remote, it yells at you and says that the repo doesn't exist. Go to github in the browser, and make a new repo with the same name as the package, *including* the `.jl`. Now, push to remote using GitHub desktop!
5. Success! Now, we have a package whose folder name is `CoyLearnsPackageDevelopment` but a repository with a `.jl` at the end.

## Organization

Code goes in `src/` and is stitched together in `packagename.jl` when a user does `using packagename`. The `include()` function brings in other files. User-accessible functions should be exported from the top level `packagename` module in `src/packagename.jl`.

Likewise, unit tests are ran from `test/runtests.jl`. The same stitching is used for organization, see any large Julia package. The `@testset` macro just organizes the tests with a header description string:

```julia
@testset "description string" begin 
    @test this_function(3) == 6
end
```

## Documentation

It seems the vast majority of Julia packages manage their documentation with `Documenter.jl`. So, this'll what I'll learn and get accustomed to. I have a bit of experience from MuControl and using the Python analogue: Sphinx.

The package initiation guide to get setup is fairly good and self explanatory. Two points though:

1. When it asks you to use the terminal to run `julia make.jl`, just run the `make.jl` file inside of VSCode. This allows it to use the `Documenter.jl` that is in the project environment. This can also be done quickly by running the command `include("docs/make.jl")` in the terminal. (I like this the best)
2. While setting things up locally, add the format kwarg `makedocs(sitename="My Documentation", format = Documenter.HTML(prettyurls = false))` to allow for easy local HTML browsing.

It looks like `jldoctest`, or documentation tests, are most useful for keeping the documentation up to date and without error. This is in contrast to the tests in `test/` that minimizes code breakage during use.
