import std/json
import std/sequtils

type
  BuildConfig* = object
    java*: string
    javac*: string
    files*: seq[string]
    default*: string
    srcDir*: string
    outDir*: string

proc BuildConfigFromJson*(node: JsonNode): BuildConfig =
  result.java = node["java"].str
  result.javac = node["javac"].str
  let files = node["files"].getElems().map(proc(x: JsonNode): string = x.str)
  result.files = files
  result.default = node["default"].str
  result.outDir = node["outDir"].str
  result.srcDir = node["srcDir"].str

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

proc handleBuild*(): void {.sideEffect.} =
  return

export BuildConfig, BuildConfigFromJson, readBuildFile, handleBuild