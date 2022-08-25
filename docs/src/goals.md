# Goals
* Allow this to auto-update using continuous integration.
* Add to readme how to set it up with GitHub Actions and address the note where the docs say I shouldn't commit the `build` folder to master. Is it more complex than just adding it to the `.gitignore`?
* Multiple section headers over on the sidebar `<--` just like how the [Documenter documentation](https://juliadocs.github.io/Documenter.jl/stable/man/guide/) looks.
* Assure that doctests are running, and figure out what happens when one fails. Are doctests covered in CI? AKA are they useful or used in industry standard packages?

## When do I move to a useful repository?
When I can successfully commit both source code and docs to the appropriate regions, auto-host updated docs, and figure out the deal with doc tests.