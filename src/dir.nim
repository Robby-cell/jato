import std/os
import std/strutils

proc ensureDirExists*(root, path: string): void =
  let
    dirs = path.split('/')
  var
    current = root

  for sub in dirs:
    current = current / sub
    if not dirExists(current):
      createDir(current)

proc findAllInDir(root, ext: string): seq[string] =
  for kind, entry in walkDir root:
    if kind == pcDir:
      for entry in findAllInDir(entry, ext):
        result.add(entry)
    elif kind == pcFile and entry.splitFile().ext == "." & ext:
      let
        basePath = entry.splitFile().dir
        fileName = entry.splitFile().name
      let
        entryPath = basePath / fileName
      result.add($entryPath)
  # for i in 0..<recursive.len:
  #   recursive[i] = recursive[i][root.len..<recursive[i].len]

proc findAllInDirSantized*(root, ext: string): seq[string] =
  result = findAllInDir(root, ext)
  for i in 0..<result.len:
    result[i] = result[i][root.len+1..<result[i].len]

export ensureDirExists, findAllInDirSantized
