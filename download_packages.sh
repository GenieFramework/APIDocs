#!/bin/sh

root=$(pwd)
mkdir -p packages

# List of repositories with optional versions (e.g., "genie-1.0")
declare -a repos=("genie" "stipple-v0.27.3" "searchlight" "stippleUI")
declare -a repos=("stipple-v0.27.3")

# Iterate over repositories
for repo_version in "${repos[@]}"; do
    # Delete the folder if it already exists
    rm -rf "packages/${repo_version}"

    # Create a new directory for the package
    mkdir -p "packages/${repo_version}"

    # Extract the repository name for cloning or downloading
    repo_name="${repo_version%-*}"
    version="${repo_version##*-}"

    # Download and unzip the specific version if specified
    if [ "$repo_name" != "$version" ]; then
        wget -O "packages/${repo_version}.tar.gz" "https://github.com/GenieFramework/${repo_name}.jl/archive/refs/tags/${version}.tar.gz"
        tar -xzf "packages/${repo_version}.tar.gz" -C "packages/${repo_version}" --strip-components=1
        rm "packages/${repo_version}.tar.gz"
    else
        # Clone the repository if no specific version is specified
        git clone https://github.com/GenieFramework/${repo_name}.jl "packages/${repo_version}"
    fi

    # Change to the docs directory
    cd "packages/${repo_version}/docs"

    gsed -i '1i using DocumenterMarkdown' make.jl
    gsed -i 's/^\s*format\s*=\s*.*/format=Markdown(),/' make.jl
    julia --project -e 'using Pkg; Pkg.add(url="https://github.com/PGimenez/DocumenterMarkdown.jl"); Pkg.add("Documenter")' >> documenter.log

    cd $root
done
