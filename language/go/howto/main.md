[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: #

<div align="center">

# Langage Go — Howto - main()

[↑ Whatis][topic whatis]

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Related topics

| Topic | Location | Kind |
|-|-|-|


# An Improved Pattern for main()

The best practice is to push **all** logic—including flag parsing and output—into a function that accepts its dependencies explicitly. `main` becomes trivial.

```go
package main

import (
    "flag"
    "fmt"
    "io"
    "os"
)

func main() {
    os.Exit(run(os.Args[1:], os.Stdout, os.Stderr))
}

// run is testable
func run(args []string, stdout, stderr io.Writer) int {
    fs := flag.NewFlagSet("myapp", flag.ContinueOnError)
    fs.SetOutput(stderr)
    // ... define flags on fs ...

    if err := fs.Parse(args); err != nil {
        return 2 // Standard exit code for usage error
    }

    // ... actual logic, writing to stdout/stderr ...
    fmt.Fprintln(stdout, "doing work")

    return 0
}
```

### Why This Is "Far Better"

1.  **Zero Global State in Logic**: `run` does not touch `os.Args`, `os.Stdout`, or `os.Stderr`. It receives them as parameters. Tests can pass `strings.Builder` for output and a simple `[]string` for arguments, making the function deterministic and safe for `t.Parallel()` .
2.  **Single Point of Exit**: Only `main` calls `os.Exit`. This ensures that `defer` statements inside `run` (like closing files or flushing buffers) execute correctly before the process terminates .
3.  **Trivial `main`**: `main` has no logic to test. It is a one-liner wiring the real OS primitives to your pure function. You don't need to exclude `main` from coverage or use build tags; it's genuinely just the "glue" .
4.  **Explicit Error Handling**: `run` returns an `int` (or an error that `main` translates to an exit code), forcing you to handle failure paths explicitly rather than relying on `log.Fatal` scattered throughout the code .

### When to Use This vs. the Simpler `realMain`

- **Use the simpler `realMain()`** for tiny scripts (under ~50 lines) where the overhead of injecting `io.Writer` and `[]string` feels like overkill. It's still better than putting logic in `main`.
- **Use the injected `run()` pattern** for any CLI tool or service you intend to maintain, test thoroughly, or parallelize in tests. This is the pattern that scales to production-grade testability.

If your application grows further, the next step is to move the `run` logic into a separate `internal/app` package and keep `main` in `cmd/` purely for wiring .