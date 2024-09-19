# Genie Framework API Docs Generator

This project builds the API documentation for packages in the Genie Framework. It uses `Documenter.jl` to generate markdown files with docstrings for objects listed in each package's `src/API/` folder.

## Packages Covered

The packages are listed in the `main.jl` script in the `package_info` variable. Each package has an url to download the source from, and an optional `docs_site_folder` field specifying the folder in the Genie docs site where the documentation should be placed.

## Prerequisites


## Usage

Required Julia packages: ArgParse, Documenter, DocumenterMarkdown, LibGit2

The main script to run is `main.jl`. It accepts the following command-line arguments:

- `--docs-site-root` or `-r`: Root folder for docs site documentation
- `--output-folder` or `-o`: Base output folder for documentation (default: "output/")
- `packages`: Names of the packages to generate the documentation for (optional)

Note: You must specify either `--docs-site-root` OR `--output-folder`, but not both. If neither is specified, the default output folder "output/" will be used.

Example usage:

```
julia main.jl --docs-site-root "/path/to/docs/site" Genie Stipple
```

This will generate documentation for the Genie and Stipple packages and place it in the appropriate subdirectories of the specified docs site root.

Alternatively:

```
julia main.jl --output-folder "/path/to/output" Genie Stipple
```

This will generate documentation for the Genie and Stipple packages and place it in the specified output folder.

## How It Works

1. The script clones or updates the specified package repositories.
2. It modifies the `make.jl` file in each package's docs folder to use `DocumenterMarkdown`.
3. It runs the modified `make.jl` to generate the documentation.
4. The generated documentation is processed to format warnings and create a `_dir.yml` file.
5. The processed documentation is copied to the specified output location (either within the docs site structure or to the specified output folder).

## Note on DocumenterMarkdown

This project uses a modified version of `DocumenterMarkdown.jl` to generate Markdown files in the format required for the Genie Framework documentation site. The modified version is available at [PGimenez/DocumenterMarkdown.jl](https://github.com/PGimenez/DocumenterMarkdown.jl).

