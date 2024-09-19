include("utils.jl")

args = parse_commandline()
output_folder = abspath(args["output-folder"])
docs_site_root = args["docs-site-root"]
@show docs_site_root
return

package_info = Dict(
    "Genie" => (url = "https://github.com/GenieFramework/Genie.jl.git", docs_folder = joinpath(docs_site_root, "2.genie.jl", "3.API")),
    "Stipple" => (url = "https://github.com/GenieFramework/Stipple.jl.git", docs_folder = joinpath(docs_site_root, "3.stipple.jl", "3.API")),
    "StippleUI" => (url = "https://github.com/GenieFramework/StippleUI.jl.git", docs_folder = joinpath(docs_site_root, "3.stipple.jl", "3.API", "components")),
    "Searchlight" => (url = "https://github.com/GenieFramework/SearchLight.jl.git", docs_folder = joinpath(docs_site_root, "4.searchlight.jl", "3.API")),
    "GenieCache" => (url = "https://github.com/GenieFramework/GenieCache.jl.git", docs_folder = joinpath(docs_site_root, "2.genie.jl", "3.API", "GenieCache")),
    "GenieDeploy" => (url = "https://github.com/GenieFramework/GenieDeploy.jl.git", docs_folder = joinpath(docs_site_root, "2.genie.jl", "3.API", "GenieDeploy")),
    "GenieSession" => (url = "https://github.com/GenieFramework/GenieSession.jl.git", docs_folder = joinpath(docs_site_root, "2.genie.jl", "3.API", "GenieSession")),
    "GenieAuthentication" => (url = "https://github.com/GenieFramework/GenieAuthentication.jl.git", docs_folder = joinpath(docs_site_root, "2.genie.jl", "3.API", "GenieAuthentication")),
    "GenieAuthorisation" => (url = "https://github.com/GenieFramework/GenieAuthorisation.jl.git", docs_folder = joinpath(docs_site_root, "2.genie.jl", "3.API", "GenieAuthorisation"))
)

packages = args["packages"] != [] ? args["packages"] : keys(package_info)

mkpath(output_folder)
mkpath("packages")

root_folder = pwd()

for package in packages
    println("Checking repository $package")
    repo_version = split(package, '-')
    if length(repo_version) > 1
        package, version = repo_version
        clone_or_update_repo(package_info[package].url, package, version)
    else
        clone_or_update_repo(package_info[package].url, package)
    end

    if docs_site_root != ""
        doc_output = joinpath(output_folder, package_info[package].docs_folder)
    else
        doc_output = joinpath(output_folder, package)
    end

    process_folder(joinpath("packages", package, "docs"), doc_output)
end

println("Documentation generation complete.")
