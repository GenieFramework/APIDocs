#!/bin/zsh
root_folder="build/"

# Function to execute your code
process_folder() {
	folder_name="$1"
	destination_folder="$2"
	echo "Processing folder: $folder_name"
	echo "Destination folder: $destination_folder"
	cd "$folder_name/docs"
	   julia --project -e 'using Pkg; Pkg.add(url="https://github.com/PGimenez/DocumenterMarkdown.jl"); Pkg.add("Documenter")' >>documenter.log
	julia --project make.jl >>documenter.log
	cd ../../
    pwd
    mkdir -p $destination_folder
	find $destination_folder -type d -name "*.md" -exec rm -r {} +
	cp -rf "$folder_name/docs/build/" "$destination_folder/"
	find $destination_folder -type f -name "*.md" -exec grep -l 'Missing docstring for' {} \; | xargs -I{} sed -i '' -e 's/.*\(Missing docstring for.*\)Check.*/::alert{type="info"}\r\1\r::/g' {}
	find $destination_folder -type f -name "*.md" -exec sed -i '' -e '/^!!! warning "Missing docstring\."/d' {} \;
}

# Check if arguments are provided
if [ $# -eq 0 ]; then
	echo "Usage: $0 folder1 folder2 folder3 ..."
	exit 1
fi


# Iterate over the arguments (folder names)
for folder_name in "$@"; do
	if [[ -d "$folder_name" ]]; then
		destination_folder="$root_folder$folder_name/"
			process_folder "$folder_name" "$destination_folder"
	else
		echo "Folder not found: $folder_name"
	fi
done
