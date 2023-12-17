import std/strformat
import std/os
import std/json

proc entryPointBoilerplate(className: string): string =
    result = fmt"""
public class {className} {{
    public static void main(String[] args) {{
        System.out.println("Hello, World!");
    }}
}}"""

proc constructorBoilerplate(className: string): string =
    result = fmt"""
public class {className} {{
    public {className}() {{
        // TODO
    }}
}}
"""

proc defaultBuildJson(files: seq[string]): string =
    let filesJson = %*files
    result = fmt"""{{
    "java": "java",
    "javac": "javac",
    "files": {filesJson},
    "default": "{files[0]}",
    "srcDir": "src",
    "outDir": "bin"
}}
"""

proc initProject(name, dir: string): void {.sideEffect.} =
    # get current dir, and figure out if we need to create the project dir
    var projectDir = getCurrentDir()
    if dir != "." and dir != "./":
        if not dirExists(dir):
            createDir(dir)
        projectDir = projectDir / dir
    let
        buildFile = open(projectDir / "build.json", fmWrite)
    defer: buildFile.close()
    buildFile.write(defaultBuildJson(@[name]));

    let
        srcDir = projectDir / "src"
        binDir = projectDir / "bin"
    if not dirExists(srcDir):
        createDir(srcDir)
    if not dirExists(binDir):
        createDir(binDir)
    block:
        let entryFile = open(srcDir / name & ".java", fmWrite)
        defer: entryFile.close()
        entryFile.write(entryPointBoilerplate(name))

export entryPointBoilerplate, constructorBoilerplate, initProject, defaultBuildJson