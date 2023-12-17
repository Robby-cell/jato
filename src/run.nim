import std/os
from build import readBuildFile

proc handleRun*(entry: string): void =
    let
        buildConfig = readBuildFile()
    
    if entry in buildConfig.files:
        # handle the running
        return

export handleRun