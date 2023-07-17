dst_folder="/Users/pere/genie/geniedocssite/content/2.docs/"
cd stipple
julia --project make.jl
find build/ -type f -name "*.md" -exec grep -l 'Missing docstring for' {} \; | xargs -I{} sed -i '' -e 's/.*\(Missing docstring for.*\)Check.*/::alert{type="info"}\r\1\r::/g' {}
find build/ -type f -name "*.md" -exec sed -i '' -e '/^!!! warning "Missing docstring\."/d' {} \;
rm -r "$dst_folder/3.UI/99.API/*.md"
cp -rf build/API/* "$dst_folder/3.UI/99.API/"
cd ../genie
julia --project make.jl
find build/ -type f -name "*.md" -exec grep -l 'Missing docstring for' {} \; | xargs -I{} sed -i '' -e 's/.*\(Missing docstring for.*\)Check.*/::alert{type="info"}\r\1\r::/g' {}
find build/ -type f -name "*.md" -exec sed -i '' -e '/^!!! warning "Missing docstring\."/d' {} \;
cp -rf build/API/* "$dst_folder/2.server/99.API/"
cd ../searchlight
julia --project make.jl
find build/ -type f -name "*.md" -exec grep -l 'Missing docstring for' {} \; | xargs -I{} sed -i '' -e 's/.*\(Missing docstring for.*\)Check.*/::alert{type="info"}\r\1\r::/g' {}
find build/ -type f -name "*.md" -exec sed -i '' -e '/^!!! warning "Missing docstring\."/d' {} \;
cp -rf build/API/* "$dst_folder/4.database/99.API/"
