dst_folder="/Users/pere/genie/geniedocssite/content/2.docs/"
cd stipple
julia --project make.jl
rm -r "$dst_folder/3.UI/99.API/*.md"
cp -rf build/API/* "$dst_folder/3.UI/99.API/"
cd ../genie
julia --project make.jl
cp -rf build/API/* "$dst_folder/2.server/99.API/"
