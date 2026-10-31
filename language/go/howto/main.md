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


# Todo

Yes! The logger and context are the foundational pillars, but in a true production-grade Go application, a well-architected `main()` function typically handles **three more critical things**:

---

### 1. Signal Handling (Graceful Shutdown)

In production, your app runs in environments like Kubernetes, Docker containers, or cloud VMs. When the server wants to stop your app, it sends an OS signal (like `SIGTERM` or `SIGINT` when you press `Ctrl+C`).

Instead of crashing instantly, your `main()` should listen for these signals and cancel the root context so active downloads or database writes can finish cleanly.

```go
// Listens for Ctrl+C or kill signals and automatically cancels the root context
ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
defer cancel()

```

---

### 2. Configuration & Environment Loading

Production apps don't hardcode values like file paths, timeouts, or API keys. They read them from environment variables or command-line flags right at the start of `main()`.

```go
// Example: reading a timeout flag or environment variable
timeout := flag.Duration("timeout", 30*time.Second, "operation timeout")
flag.Parse()

```

---

### 3. Deferred Cleanup (`logger.Sync()`, etc.)

Many production loggers (like Uber's Zap) buffer log entries in memory for performance. If your program exits abruptly, those logs might be lost. You should **always** defer a sync/flush right after initializing your logger.

```go
logger := logging.GetLogger(os.Stderr, loggerConf)
defer logger.Sync() // Flushes any buffered log entries before main exits

```

---

### The Anatomy of a Production-Grade `main()`

Putting it all together, a professional production `main()` function in Go looks like this:

```go
func main() {
    // 1. Initialize Configuration & Flags
    flag.Parse()

    // 2. Initialize Logger + Ensure buffer flushes on exit
    loggerConf := logging.Config{Level: logging.LevelInfo, AsJSON: true, Backend: logging.Zap}
    logger := logging.GetLogger(os.Stderr, loggerConf)
    defer logger.Sync() // ⚠️ Crucial for Zap/structured loggers

    // 3. Create a Root Context with OS Signal Handling (Graceful Shutdown)
    ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
    defer cancel()

    // 4. Add a safety timeout on top of the signal context if needed
    ctx, timeoutCancel := context.WithTimeout(ctx, 30*time.Second)
    defer timeoutCancel()

    logger.Info("Application starting...")

    // 5. Execute your core business logic (passing context and logger)
    files := []string{"file1.txt", "file2.txt", "file3.txt"}
    if err := DownloadFilesBatch(ctx, logger, files); err != nil {
        logger.Error("Application terminated with error", "error", err)
        os.Exit(1)
    }

    logger.Info("Application shut down successfully")
}

```

### Summary of `main()`'s Job:

`main()` should be a **dumb orchestrator**. It doesn't perform business logic; its only job is to **wire things up** (config, logger, context, signals), **run the app**, and **handle the exit code** cleanly.