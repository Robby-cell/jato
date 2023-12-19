from build import BuildConfig, readBuildFile, buildConfigToJson
from boilerplate import defaultBuildJson
import vector
from dir import findAllInDirSantized

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
    for file in findAllInDirSantized(srcDir, "java"):
        echo file
        pushBack(files, file)

    buildConfig.files = files.data
    buildConfigToJson(buildConfig)

    return

export handleIndex
