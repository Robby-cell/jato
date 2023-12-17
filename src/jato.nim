import std/os
from args import parseArgs, Command, Intentions
import boilerplate
from usage import printUsage
from run import handleRun
from build import handleBuild

let
  cmdArgs = commandLineParams()

if cmdArgs.len == 0:
  printUsage()
  quit(1)

proc main(): void =
  let command = parseArgs(cmdArgs)
  case command.intentions
  of Intentions.Run:
    handleRun(command.entry)
  of Intentions.Build:
    handleBuild()
  of Intentions.New:
    initProject(command.entry, command.entry)
  of Intentions.Init:
    initProject(command.entry, ".")

if isMainModule:
  main()
  echo entryPointBoilerplate("App")