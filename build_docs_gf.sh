#!/bin/zsh
root_folder="/Users/pere/genie/geniedocssite/content/2.docs/"
folder_name="genieframework/"

remove_existing() {
    rm -rf $1"2.server/99.API/*.md"
    rm -rf $1"3.reactive-ui/99.API/*.md"
    rm -rf $1"4.Database/99.API/*.md"
}


destination_folder="$root_folder/"

remove_existing $destination_folder

cd "$folder_name"
julia --project make.jl >>documenter.log
find build/ -type f -name "*.md" -exec grep -l 'Missing docstring for' {} \; | xargs -I{} sed -i '' -e 's/.*\(Missing docstring for.*\)Check.*/::alert{type="info"}\r\1\r::/g' {}
find build/ -type f -name "*.md" -exec sed -i '' -e '/^!!! warning "Missing docstring\."/d' {} \;
rsync -avh build/ "$destination_folder/"
cd ..
