import std/os
from build import readBuildFile, handleBuild

proc handleRun*(entry: var ref string): void =
    let
        buildConfig = readBuildFile()
    
    if entry[] in buildConfig.files:
        # handle the running
        discard
    else:
        entry[] = buildConfig.default

    handleBuild(buildConfig)

    discard execShellCmd("cd " & buildConfig.outDir & " && " & buildConfig.java & " " & entry[])


export handleRun