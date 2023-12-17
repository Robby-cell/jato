from build import BuildConfig, BuildConfigFromJson
import std/json

proc readBuildFile*(): BuildConfig =
    let
        fileContents = (
            let file = open("build.json", fmRead);
            defer: file.close();
            let contents = file.readAll();
            contents
        )
        config = parseJson(fileContents)
    result = BuildConfigFromJson(config)

export readBuildFile