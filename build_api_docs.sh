#!/bin/zsh
root_folder="$(pwd)"
mkdir -p $1
output_folder="$(realpath $1)/"
shift


# Function to execute your code
process_folder() {
    docs_folder="$1/docs"
    output="$2"
    echo "Docs folder: $docs_folder"
    echo "Output folder: $output"
    mkdir -p $output
    cd $docs_folder
    julia --project make.jl >>documenter.log 2>&1
    find build/ -type f -name "*.md" -exec grep -l 'Missing docstring for' {} \; | xargs -I{} sed -i '' -e 's/.*\(Missing docstring for.*\)Check.*/::alert{type="info"}\r\1\r::/g' {}
    find build/ -type f -name "*.md" -exec sed -i '' -e '/^!!! warning "Missing docstring\."/d' {} \;
    find $output/ -type d -name "*.md" -exec rm -r {} +
    cp -rf build/API/* "$output/"
    cd $root_folder
}

# Check if arguments are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 folder1 folder2 folder3 ..."
    exit 1
fi

# Mapping from folder name to destination folder name
# typeset -A folder_map
# folder_map=("genie" "2.server" "stipple" "3.UI" "searchlight" "4.database")
declare -A folder_map
folder_map=( ["genie"]="2.server" ["stipple"]="3.UI"  ["stipple-v0.27.3"]="3.UI/v0.27.3" ["stippleui"]="3.UI/components" ["searchlight"]="4.database" )

# Iterate over the arguments (folder names)
for folder_name in "$@"; do
    echo "Processing $folder_name"
    process_folder "packages/$folder_name" "$output_folder${folder_map[$folder_name]}"
done
