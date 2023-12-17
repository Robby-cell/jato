import std/strformat
import std/os

let
    exePath = getAppFilename()

proc printUsage(): void =
    echo fmt"Usage: {exePath} <options> <?entry-file>"

export printUsage