import std/os
from args import parseArgs, Command, Intentions
import boilerplate
from usage import printUsage
from run import handleRun
from build import handleBuild, readBuildFile
from index import handleIndex

proc main(): void =
  let
    cmdArgs = commandLineParams()
  if cmdArgs.len == 0:
    printUsage()
    quit(1)

  let command = parseArgs(cmdArgs)
  case command.intentions
  of Intentions.Run:
    var entry: ref string = string.new()
    entry[] = command.entry
    handleRun(entry)
  of Intentions.Build:
    let
      buildConfig = readBuildFile()
    handleBuild(buildConfig)
  of Intentions.New:
    initProject(command.entry, command.entry)
  of Intentions.Init:
    initProject(command.entry, ".")
  of Intentions.Index:
    handleIndex()

if isMainModule:
  main()