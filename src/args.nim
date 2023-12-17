from usage import printUsage

type
    Intentions = enum
        Run
        Build
        New
        Init

type
    Mode = enum
        ExpectName
        Normal

type
    Command* = object
        intentions*: Intentions
        entry*: string

proc parseArgs(args: seq[string]): Command =
    var
        mode: Mode = Mode.Normal
    
    for arg in args:
        if mode == Mode.Normal:
            case arg
            of "run", "r":
                result.intentions = Intentions.Run
            of "build", "b":
                result.intentions = Intentions.Build
            of "new", "n":
                result.intentions = Intentions.New
            of "init", "i":
                result.intentions = Intentions.Init
            of "-e", "--entry":
                mode = Mode.ExpectName
            else:
                printUsage()
                quit(1)
        elif mode == Mode.ExpectName:
            result.entry = arg
            mode = Mode.Normal

    if result.entry == "":
        result.entry = "App"

export parseArgs, Intentions, Command