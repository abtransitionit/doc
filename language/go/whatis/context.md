[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:  ../howto/context.md
[cli go howto]:    ../howto/cli.go.md
[cli list]:        ../list/cli.md
[channel whatis]:  ../whatis/channel.md

<div align="center">

# Langage Go - Whatis - Context

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Related topics

| Topic | Location | Kind |
|-|-|-|
| [What is a Channel][channel whatis] | internal |
| [How-to for cli][cli go howto] | internal |
| [list of cli][cli list] | internal |


# Definition

`context.Context` is a data structure defined in the package `context`.
```go
type Context interface {
    Deadline() (deadline time.Time, ok bool)
    Done() <-chan struct{}
    Err() error
    Value(key any) any
}
```

**Meaning**

|Member|Kind|Description|Notes|
| -- | -- | -- | -- |
| `Deadline()` | returns the time at which work should be cancelled, if any.
| `Done()` | returns a channel closed when the context is cancelled or the deadline expires.
| `Err()` | returns `nil` while active, or `context.Canceled` / `context.DeadlineExceeded` after cancellation.
| `Value(key) | returns the value associated with `key`, or `nil`.|

It is implemented through a technical mechanism (interfaces, mutexes, channels, and goroutines under the hood) whose sole purpose is to **carry** three things:

1. **Cancellation signals** - telling the process and their child to shut down gracefully or immediate.
1. **Timeouts / Deadlines** — Setting a maximum execution time, combined with signal cancellation.
1. **Custom Context Values** — Injecting application-wide identifiers (execution ID, tracing data, etc.).



- Custom Context Values: Injecting application-wide identifiers like
    - a unique execution ID
    - a tracing data



## Cancellation Signals

- Created with `context.WithCancel(parent)`.
- Returns `(ctx, cancel)`; calling `cancel()` closes `ctx.Done()`.
- Downstream goroutines listen on `ctx.Done()` and abort promptly.
- `ctx.Err()` reports `context.Canceled`.

```go
ctx, cancel := context.WithCancel(context.Background())
defer cancel()

go func() {
    select {
    case <-ctx.Done():
        // cancellation signal received
    case <-workDone:
        // finished normally
    }
}()
```

- Two-Stage Graceful Shutdown
    - Pressing Ctrl+C once tells the app to shut down gracefully. 
    - Pressing Ctrl+C a second time forces an immediate hard exit.

## Two-Stage Graceful Shutdown (the "Hard Exit" pattern)

A common pattern that combines contexts with OS signals:

- **Ctrl+C once** → tells the app to shut down **gracefully** (stop accepting new work, finish in-flight work).
- **Ctrl+C a second time** → forces an **immediate hard exit**.

Implementation sketch:

```go
func main() {
    ctx, cancel := context.WithCancel(context.Background())
    defer cancel()

    sigCh := make(chan os.Signal, 2)
    signal.Notify(sigCh, os.Interrupt, syscall.SIGTERM)

    go func() {
        <-sigCh          // first Ctrl+C
        cancel()         // start graceful shutdown
        <-sigCh          // second Ctrl+C
        os.Exit(1)       // hard exit
    }()

    if err := run(ctx); err != nil && ctx.Err() == nil {
        log.Fatal(err)
    }
}
```

The context coordinates the **graceful phase**; a second signal **bypasses** it.



## Timeouts / Deadlines

It sets a maximum execution time for an operation.

- A **timeout** is a relative duration (`--timeout 30s`).
- A **deadline** is an absolute point in time.
- Enforced by the **context mechanism**, not by ad-hoc timers scattered through code.
- When reached, the context is **cancelled automatically**.
- Cancellation produces a **signal** that propagates to everything listening on the context.
- That signal is **combined with** normal cancellation (e.g. Ctrl+C / SIGINT).
- The operation stops for **either reason**: deadline expired **or** explicit cancellation signal.
- Downstream goroutines/APIs observe `ctx.Done()` and **abort promptly**.
- `ctx.Err()` distinguishes the cause: `context.DeadlineExceeded` vs `context.Canceled`.
- Result: a **bounded, predictable** maximum runtime that still supports graceful early cancellation.

```go
// Relative timeout
ctx, cancel := context.WithTimeout(parent, 30*time.Second)
defer cancel()

// Absolute deadline
ctx, cancel := context.WithDeadline(parent, time.Now().Add(30*time.Second))
defer cancel()
```

## Custom Context Values

Inject **application-wide identifiers** into the context so they flow through the call chain without changing function signatures.

- Set with `context.WithValue(parent, key, val)`.
- Retrieved with `ctx.Value(key)`.
- Typical uses: unique **execution ID**, **tracing data**, request metadata, auth principals.

```go
type ctxKey string
const execIDKey ctxKey = "execID"

ctx = context.WithValue(ctx, execIDKey, "abc-123")
// later, deep in the call chain:
id := ctx.Value(execIDKey).(string)
```

**Rules for values:**
- Use **unexported custom key types** (not raw strings) to avoid collisions.
- Values are for **request-scoped metadata only** — never for passing optional function parameters.
- Keep values **immutable** and safe for concurrent use.




## 4. The Context Tree

Contexts form an **immutable parent/child tree**:

- `context.Background()` — root; never cancelled. Use at `main`, init, tests.
- `context.TODO()` — placeholder when the right context is unclear; never cancelled.
- Every `WithCancel` / `WithTimeout` / `WithDeadline` / `WithValue` returns a **child**.
- Cancelling a parent **cancels all descendants**.
- A child can be cancelled **independently** of the parent (via its own `cancel`).

```
Background
   └── WithTimeout(parent, 30s)      ← deadline
         └── WithValue(execID)       ← metadata
               └── WithCancel()      ← explicit cancel
```

---

## 5. Best Practices

- **Always call `cancel()`** returned by `WithCancel` / `WithTimeout` / `WithDeadline` — use `defer cancel()`.
  - For `WithTimeout`/`WithDeadline`, `cancel()` releases timers even if the deadline already fired.
- **Pass `ctx` as the first parameter**, named `ctx`:
  ```go
  func DoWork(ctx context.Context, arg T) error
  ```
- **Never store a context in a struct** — pass it explicitly through the call chain.
- **Never pass `nil`** as a context; use `context.TODO()` if unsure.
- **Propagate the context** — do not create a fresh `context.Background()` deep in a call chain; carry the caller's `ctx`.
- **Watch `ctx.Done()` in blocking code** (select blocks, goroutines, DB/HTTP calls).
- **Use custom unexported key types** for `WithValue`.
- **Do not use context values for optional parameters** or core business data.
- **Return `ctx.Err()`** appropriately so callers can distinguish cancellation vs. deadline vs. genuine failure.
- **For services**, use `context.WithTimeout` per request to bound latency.
- **Respect cancellation** in libraries: check `ctx.Done()` in long loops and blocking operations.
- **Avoid context sprawl** — one context per request, derived children as needed.

---

## 6. Common Pitfalls

- Forgetting `defer cancel()` → **goroutine and timer leaks**.
- Storing context in a struct field → hidden coupling, poor clarity.
- Passing `nil` context → panics in downstream code.
- Using raw `string` keys in `WithValue` → collisions; prefer custom types.
- Using `context.Background()` deep inside a request → **breaks cancellation propagation**.
- Not checking `ctx.Done()` in long-running work → cancellation is ignored.
- Treating `ctx.Err()` as always an error — `context.Canceled` is often **expected** (e.g. client disconnect).

---

## 7. Summary

`context.Context` is a plain data structure whose technical machinery exists to **carry cancellation signals, deadlines/timeouts, and arbitrary request-scoped values** across goroutines and API boundaries. It enables:

- **Bounded execution** via timeouts/deadlines combined with cancellation signals.
- **Graceful shutdown**, including the two-stage "Ctrl+C once = graceful, twice = hard exit" pattern.
- **Metadata propagation** (execution IDs, tracing data) without changing function signatures.

Use it as the **first parameter** of any function that does I/O or may block, always `defer cancel()`, propagate the caller's context, and keep values request-scoped and immutable.


# Key idea
- The `Done()` method