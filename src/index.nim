from build import BuildConfig, readBuildFile, buildConfigToJson
import std/os
from boilerplate import defaultBuildJson
import vector
from std/strutils import replace, split, tokenize, join, startsWith, removePrefix
import std/strformat

proc handleIndex*(): void =
    var srcDir: string
    var buildConfig: BuildConfig
    try:
        buildConfig = readBuildFile()
        srcDir = buildConfig.srcDir
    except Exception as e:
        discard e
        let buildJson = open("build.json", fmWrite)
        defer: buildJson.close()
        buildJson.write(defaultBuildJson(@["App"]))

        try:
            buildConfig = readBuildFile()
        except:
            discard
        srcDir = buildConfig.srcDir

    var files = initVector[string]();
    for kind, path in walkDir(srcDir):
        if kind == pcFile:
            var
                pathTo = path.splitFile().dir.replace("src")
                name = path.splitFile().name.split('.')[0]
                nameOfFile = (
                    var output = pathTo & "/"
                    output.removePrefix('/')
                    output = output & name
                    output
                )
            # var iter = nameOfFile.tokenize({'/'})

            echo nameOfFile
            pushBack(files, nameOfFile)

    buildConfig.files = files.data
    buildConfigToJson(buildConfig)

    return

export handleIndex