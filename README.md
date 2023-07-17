# Genie Framework API docs builder

Builds the API docs for the packages in the Genie Framework. Uses `Documenter.jl` to generate markdown files with the docstrings for the objects listed in the `$package/src/API/` folder.

The Markdown renderer has been modified from `DocumenterMarkdown.jl` to generate Markdown files in the format of the docs in the resource center. The modified version is on [PGimenez/DocumenterMarkdown.jl](https://github.com/PGimenez/DocumenterMarkdown.jl)

# Building the docs

The `build_docs_gf.sh` script builds the guides on genieframework.com
 
The `build_api_docs.sh` builds the API documentation

Before running either script do the following: 

1. Download the packages with `download_packages.sh`. 
2. Install the modified `DocumenterMarkdown` from [https://github.com/PGimenez/DocumenterMarkdown.jl](https://github.com/PGimenez/DocumenterMarkdown.jl) to the `/docs/` folder of the package.
3. Add `using DocumenterMakrdown` to `make.jl`, and change the `format` parameter in the call to `makedocs` to `format=Markdown()`
