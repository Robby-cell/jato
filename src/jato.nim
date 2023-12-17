import std/strformat
import std/os
from args import readBuildFile
import boilerplate

let
  cmdArgs = commandLineParams()
  exePath = getAppFilename()

if cmdArgs.len == 0:
  echo fmt"Usage: {exePath} <options> <?entry-file>"
  quit(1)

proc main(): void =
  let buildConfig = readBuildFile()
  echo buildConfig
  initProject("applet", "applet")

if isMainModule:
  main()
  echo entryPointBoilerplate("App")