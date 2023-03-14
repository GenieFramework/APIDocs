# Genie Framework API docs builder

Builds the API docs for the packages in the Genie Framework. Uses `Documenter.jl` to generate markdown files with the docstrings for the objects listed in the `$package/src/API/` folder.

The Markdown renderer has been modified from `DocumenterMarkdown.jl` to generate Markdown files in the format of the docs in the resource center. The modified version is on [PGimenez/DocumenterMarkdown.jl](https://github.com/PGimenez/DocumenterMarkdown.jl)
