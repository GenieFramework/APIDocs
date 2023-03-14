using Pkg
Pkg.update("DocumenterMarkdown")
using Documenter
using DocumenterMarkdown

push!(LOAD_PATH, "../../src")

using Stipple, Stipple.Elements, Stipple.Layout, Stipple.Typography, Stipple.ReactiveTools

makedocs(
    sitename="Stipple - data dashboards and reactive UIs for Julia",
    format=Markdown(),
    pages=[
        "Stipple API" => [
            "Elements" => "API/elements.md",
            "Layout" => "API/layout.md",
            "Stipple" => "API/stipple.md",
        ]
    ],
)

deploydocs(
    repo="github.com/GenieFramework/Stipple.jl.git",
)
