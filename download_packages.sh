#!/bin/sh

# List of repositories
declare -a repos=("genie.jl" "stipple.jl" "searchlight.jl")

# Iterate over repositories
for repo in "${repos[@]}"; do
    # Delete the folder if it already exists
    # rm -rf "${repo%.jl}"

    # Clone the repository to a folder with the same name, but without the ".jl" extension
    git clone https://github.com/GenieFramework/$repo "${repo%.jl}"

    # Change directory into the cloned repo
    cd "${repo%.jl}"

    # Execute the Julia command

    # Return to the root directory
    cd ..
done
