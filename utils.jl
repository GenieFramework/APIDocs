using Pkg
using LibGit2
using Downloads
using ArgParse

function parse_commandline()
    s = ArgParseSettings()
    @add_arg_table s begin
        "--docs-site-root", "-r"
            help = "Root folder for docs site documentation"
            default = ""
        "--output-folder", "-o"
            help = "Base output folder for documentation"
            default = "output/"
        "packages"
            help = "Names of the packages to generate the documentation for"
            nargs = '+'
            default = []
            required = false
    end
    return parse_args(s)
end

function clone_or_update_repo(repo_url::String, folder_name::String, version::Union{String,Nothing}=nothing)
    println("Attempting to clone or update $folder_name")
    repo_path = joinpath("packages", folder_name)
    rm(repo_path, force=true, recursive=true)
    mkpath(repo_path)

    if version !== nothing
        tarball_url = "https://github.com/GenieFramework/$(folder_name).jl/archive/refs/tags/$(version).tar.gz"
        tarball_path = "$(repo_path).tar.gz"
        Downloads.download(tarball_url, tarball_path)
        run(`tar -xzf $tarball_path -C $repo_path --strip-components=1`)
        rm(tarball_path)
    else
        LibGit2.clone(repo_url, repo_path)
    end
end

function process_folder(docs_folder::String, output::String)
    package = basename(output)
    
    println("Processing folder $docs_folder")
    println("Output folder: $output")
    mkpath(output)
    cd(docs_folder)

    make_content = read("make.jl", String)
    make_content = "using DocumenterMarkdown\n" * make_content
    make_content = replace(make_content, r"format\s*=\s*.*" => "format=Markdown(),")
    write("make.jl", make_content)

    run(`julia --project -e 'using Pkg; Pkg.add(url="https://github.com/PGimenez/DocumenterMarkdown.jl"); Pkg.add("Documenter")'`)
    run(`julia --project make.jl`)
    
    for (root, _, files) in walkdir("build")
        for file in files
            if endswith(file, ".md")
                filepath = joinpath(root, file)
                content = read(filepath, String)
                
                content = replace(content, r".*Missing docstring for(.*)Check.*" => s"::alert{type=\"info\"}\nMissing docstring for\1\n::")
                content = replace(content, r"!!! warning \"Missing docstring\.\".*" => "")
                
                write(filepath, content)
            end
        end
    end
    
    for item in readdir(output, join=true)
        if isdir(item) && endswith(item, ".md")
            rm(item, recursive=true)
        end
    end
    
    cp(joinpath("build", "API"), output, force=true)
    
    open(joinpath(output, "_dir.yml"), "w") do f
        write(f, "title: $package")
    end
    
    cd(root_folder)
end
