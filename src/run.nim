import std/os
from build import readBuildFile

proc handleRun*(entry: var ref string): void =
    let
        buildConfig = readBuildFile()
    
    if entry[] in buildConfig.files:
        # handle the running
        discard
    else:
        entry[] = buildConfig.default

    for file in buildConfig.files:
        discard execShellCmd("java -cp " & buildConfig.outDir & " " & buildConfig.srcDir / file)

    discard execShellCmd("cd " & buildConfig.srcDir & " && " & buildConfig.javac & " " & entry[])


export handleRun