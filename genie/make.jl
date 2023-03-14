push!(LOAD_PATH, "../src/")
using Pkg
Pkg.update("DocumenterMarkdown")

using Documenter
using DocumenterMarkdown


using Genie, Genie.Assets, Genie.Commands, Genie.Configuration, Genie.Cookies
using Genie.Encryption, Genie.Exceptions
using Genie.FileTemplates, Genie.Generator
using Genie.Headers, Genie.HTTPUtils, Genie.Input, Genie.Loader, Genie.Logger
using Genie.Renderer, Genie.Repl, Genie.Requests, Genie.Responses, Genie.Router, Genie.Secrets, Genie.Server
using Genie.Toolbox, Genie.Util, Genie.Watch, Genie.WebChannels, Genie.WebThreads

push!(LOAD_PATH, "../../src", "../../src/renderers")

makedocs(
    sitename="Genie - The Highly Productive Julia Web Framework",
    format=Markdown(),
    pages=[
        "API" => [
            "Assets" => "API/assets.md",
            "Commands" => "API/commands.md",
            "Configuration" => "API/configuration.md",
            "Cookies" => "API/cookies.md",
            "Encryption" => "API/encryption.md",
            "Exceptions" => "API/exceptions.md",
            "FileTemplates" => "API/filetemplates.md",
            "Generator" => "API/generator.md",
            "Genie" => "API/genie.md",
            "Headers" => "API/headers.md",
            "HttpUtils" => "API/httputils.md",
            "Input" => "API/input.md",
            "Loader" => "API/loader.md",
            "Logger" => "API/logger.md",
            "Renderer" => "API/renderer.md",
            "HTML Renderer" => "API/renderer-html.md",
            "JS Renderer" => "API/renderer-js.md",
            "JSON Renderer" => "API/renderer-json.md",
            "Requests" => "API/requests.md",
            "Responses" => "API/responses.md",
            "Router" => "API/router.md",
            "Secrets" => "API/secrets.md",
            "Server" => "API/server.md",
            "Toolbox" => "API/toolbox.md",
            "Util" => "API/util.md",
            "Watch" => "API/watch.md",
            "WebChannels" => "API/webchannels.md",
            "WebThreads" => "API/webthreads.md"
        ]
    ],
)

deploydocs(
    repo="github.com/GenieFramework/Genie.jl.git",
)
