#!/bin/sh

root=$(pwd)
mkdir -p packages
# List of repositories
declare -a repos=("genie.jl" "stipple.jl" "searchlight.jl" "stippleUI.jl")

# Iterate over repositories
for repo in "${repos[@]}"; do
    # Delete the folder if it already exists
    rm -rf "packages/${repo%.jl}"

    # Clone the repository to a folder with the same name, but without the ".jl" extension
    git clone https://github.com/GenieFramework/$repo "packages/${repo%.jl}"

    cd "packages/${repo%.jl}/docs"

    gsed -i '1i using DocumenterMarkdown' make.jl
    gsed -i 's/^\s*format\s*=\s*.*/format=Markdown(),/' make.jl
	julia --project -e 'using Pkg; Pkg.add(url="https://github.com/PGimenez/DocumenterMarkdown.jl"); Pkg.add("Documenter")' >> documenter.log

    cd $root
done
