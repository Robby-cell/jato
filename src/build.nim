import std/json
import std/sequtils
import std/os
from dir import ensureDirExists

const
  MOVE =
    when defined windows:
      "move"
    elif defined linux:
      "mv"
    elif defined mac:
      "mv"
    else:
      compileError("Unsupported platform")

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

proc handleBuild*(buildConfig: BuildConfig): void {.sideEffect.} =
  if not dirExists(buildConfig.outDir):
    createDir(buildConfig.outDir)
  for file in buildConfig.files:
    discard execShellCmd("cd " & buildConfig.srcDir &
      " && " & buildConfig.javac &
      " " & file & ".java")
    ensureDirExists(buildConfig.outDir, file.splitFile().dir);
    discard execShellCmd(MOVE & " " & buildConfig.srcDir / file & ".class" &
        " " & buildConfig.outDir / file & ".class")

proc buildConfigToJson(buildConfig: BuildConfig): void =
  let file = open("build.json", fmWrite)
  defer: file.close()
  file.write(%*buildConfig)

export buildConfigToJson, BuildConfig, BuildConfigFromJson, readBuildFile, handleBuild
