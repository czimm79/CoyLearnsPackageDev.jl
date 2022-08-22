# CoyLearnsPackageDev

[![Build Status](https://github.com/czimm79/CoyLearnsPackageDev.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/czimm79/CoyLearnsPackageDev.jl/actions/workflows/CI.yml?query=branch%3Amaster)

This repo is public so I can use GitHub Actions for free and learn about continuous integration (CI) while learning the ins and outs of proper Julia package development. None of this is really intended as a tutorial for others yet, and is just a reference for myself.

## My Resources
* https://julialang.org/contribute/developing_package/ (Pretty good, but lacking the nitty gritty like proper order of operations with creating a repo. `.jl` is automatically added by some source?)

# WIP Self Q&A
> Why use julia package mode and `dev` a package? What does this do?

> How do I properly run the tests from the command line before pushing/committing?

> What is a `git stash`?

> How do I incorporate `Revise.jl`? Is it included in VSCode?

It is automatically included in the Julia VSCode extension, however, `Revise` must be added in the current package environment (`]add Revise` in Julia REPL). Then, when opening a new REPL in VSCode, it is automatically loaded. This prevents the need to reload the repo or some other funky stuff. Just change the source code in any files, then run whatever you want in the same repo and it will update behind the scenes.

> Does `Revise.jl` remove the *hidden state* that is so frustrating with environments like Jupyter? Are there any catches I need to be aware of?

> What are the important keybinds for `Julia in VSCode`?

Keybindings are [here](https://www.julia-vscode.org/docs/stable/userguide/keybindings/). Big ones are 

> How do I quickly and efficiently view Julia docs in VSCode? What are the keybinds?

**TODO** Check these https://code.visualstudio.com/Docs/editor/editingevolved

> How does Makie make use of `ReferenceTests.jl`? Will it be useful for my packages?

> Can I clone using `dev --local` as in the Makie docs, edit, create new branch, commit, push, and create PR? Read the contributing page [here](https://julialang.org/contribute/opportunities/), especially the guide to contributing to `Images.jl`.

> How do I create a package local environment and make it persist while I'm developing? Similar to Python virtual environments..?


# Initializing a new package
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

# Organization 
Code goes in `src/` and is stitched together in `packagename.jl` when a user does `using packagename`. The `include()` function brings in other files. User-accessible functions should be exported from the top level `packagename` module in `src/packagename.jl`.

Likewise, unit tests are ran from `test/runtests.jl`. The same stitching is used for organization, see any large Julia package. The `@testset` macro just organizes the tests with a header description string:
```julia 
@testset "description string" begin 
    @test this_function(3) == 6
end
```