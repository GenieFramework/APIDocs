#!/bin/zsh
root_folder="/Users/pere/genie/geniedocssite/content/2.docs/"

# Function to execute your code
process_folder() {
	folder_name="$1"
	destination_folder="$2"
	echo "Processing folder: $folder_name"
	echo "Destination folder: $destination_folder"
	cd $folder_name
	julia --project make.jl >>documenter.log
	find build/ -type f -name "*.md" -exec grep -l 'Missing docstring for' {} \; | xargs -I{} sed -i '' -e 's/.*\(Missing docstring for.*\)Check.*/::alert{type="info"}\r\1\r::/g' {}
	find build/ -type f -name "*.md" -exec sed -i '' -e '/^!!! warning "Missing docstring\."/d' {} \;
	find $destination_folder/ -type d -name "*.md" -exec rm -r {} +
	cp -rf build/API/ "$destination_folder/"
	cd ..
}

# Check if arguments are provided
if [ $# -eq 0 ]; then
	echo "Usage: $0 folder1 folder2 folder3 ..."
	exit 1
fi

# Mapping from folder name to destination folder name
typeset -A folder_map
folder_map=("genie" "2.server" "stipple" "3.UI" "searchlight" "4.database")

# Iterate over the arguments (folder names)
for folder_name in "$@"; do
	if [[ -d "$folder_name" ]]; then
		destination_folder="$root_folder${folder_map[$folder_name]}/99.API/"
		if [[ -n "$destination_folder" ]]; then
			process_folder "$folder_name" "$destination_folder"
		else
			echo "No mapping found for folder: $folder_name"
		fi
	else
		echo "Folder not found: $folder_name"
	fi
done
