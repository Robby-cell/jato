# jato

A simple CLI tool to build, create and run java apps, similar to the way something like cargo or zig would work

+ to run the app:
```bash
jato run
```
+ to specifiy an entry point, if the entry point was in `src/Foo.java`:
```bash
jato run --entry Foo
```

+ to build, it is similar to run, except it builds everything in the src directory, which can be specified in `build.json`
```bash
jato build
```

+ in order to build, the project has to be indexed
```bash
jato index
```

+ to create a new project, in a new directory, with the name `Foo`, and the entry file `src/Foo.java`
```bash
jato new --entry Foo
```

+ `init` works similarly, but it will use the current directory rather than creating a new directory
```bash
jato init
```
+ the default name is `App`

## We can do better

+ all commands have shorter version
- `jato init` is the same as `jato i`
- `jato run` is the same as `jato r`
- `jato build` is the same as `jato b`
- `jato index` is the same as `jato x`
- `--entry` is the same as `-e`
