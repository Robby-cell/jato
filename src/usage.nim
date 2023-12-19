import std/strformat
import std/os

let
    exePath = getAppFilename()

proc printUsage(): void =
    echo fmt"""Usage: {exePath} <options> <?entry-file>
    run | r <options>   {exePath} run [-e | --entry] [Main]
                        run the project, optionally provide the name of the entry
    build | b           {exePath} build
                        build the project, and output the class files to the bin dir
    new | n             {exePath} new [-e | --entry] [MyProject]
                        create a new project in its own directory with a specified name, has a default name if none provided
    init | i            {exePath} init [-e | --entry] [MyProject]
                        initialize the current directory with a specified entry point
    index | x           {exePath} index
                        index the current project
"""

export printUsage