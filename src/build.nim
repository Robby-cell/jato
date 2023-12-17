import std/json
import std/sequtils

type
  BuildConfig = object
    java: string
    javac: string
    files: seq[string]
    srcDir: string
    outDir: string

proc BuildConfigFromJson*(node: JsonNode): BuildConfig =
  result.java = node["java"].str
  result.javac = node["javac"].str
  let files = node["files"].getElems().map(proc(x: JsonNode): string = x.str)
  result.files = files
  result.outDir = node["outDir"].str
  result.srcDir = node["srcDir"].str


export BuildConfig, BuildConfigFromJson