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
[error whatis]:  ../whatis/logging.md
[logging whatis]:  ../whatis/error.md

<div align="center">

# Langage Go - Whatis - Context

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Channel][channel whatis] . [Error][error whatis] . [Logging][logging whatis]| internal |
| Howto | [CLI][cli go howto]| internal |
| List | [CLI][cli list]| internal |




# Mechanism
The core mechanism of context is to utilize the "broadcast" nature of channel closure to notify all listening goroutines to stop working.


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

|Member|Description|Notes|
| -- | -- | -- |
| `Deadline()` | returns the time at which work should be cancelled, if any.
| `Done()` | returns a channel closed when the context is cancelled or the deadline expires.
| `Err()` | returns `nil` while active, or `context.Canceled` / `context.DeadlineExceeded` after cancellation.
| `Value(key`) | returns the value associated with `key`, or `nil`.|

It is implemented through a technical mechanism (interfaces, mutexes, channels, and goroutines under the hood) whose sole purpose is to **carry** three things:

1. **Cancellation signals** - telling the process and their child to shut down gracefully or immediate.
1. **Timeouts / Deadlines** — Setting a maximum execution time, combined with signal cancellation.
1. **Custom Context Values** — Injecting application-wide identifiers (execution ID, tracing data, etc.).



- Custom Context Values: Injecting application-wide identifiers like
    - a unique execution ID
    - a tracing data



# Operation
- Cancel a Context

## Cancel a context
- means: closing its Done() channel.
   ```go
   // create a context
   ctx, cancel := context.WithCancel(context.Background())

    // cancel a context ... somewhere in the code
    cancel() 

    // Anywhere waiting on <-ctx.Done() now unblocks immediately
   ```
- cancel a context ⇒ sendi the stop signal ⇒ stop what you're doing ⇒

- Who cancels? Whoever holds the cancel function 
    - `context.WithCancel`, 
    - `context.WithTimeout`
    - `signal.NotifyContext` on Ctrl+C
    - HTTP server on client disconnect, ...

- Who listens? 
    - a goroutines, via `<-ctx.Done()`.



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



# Rule 1: Context is Always the First Parameter

It **must** be the very first parameter. It is a convention

Never put it in the middle or at the end of a parameter list.

* **❌ Bad:** `func downloadFile(filename string, ctx context.Context) error`
* **✅ Good:** `func downloadFile(ctx context.Context, filename string) error`


# Rule 2: Never Store Context in Structs

A context represents a **single request lifecycle or operation boundary**, not a long-lived object configuration.

* **❌ Bad:** Storing a `ctx` as a field inside a service struct.
* **✅ Good:** Passing `ctx` down explicitly through method calls as it flows through your call stack.

```go
type Downloader struct {
    client *http.Client
}

// Pass ctx into the method, never store it in 'd'
func (d *Downloader) Download(ctx context.Context, filename string) error {
    // ...
}

```

# Rule 3: Respect Cancellation (`ctx.Done()`)

Any function that performs a **blocking operation** (like network requests, disk I/O, database queries, or long loops) **must** monitor `ctx.Done()` so it can abort immediately if the user cancels or a timeout occurs.

In Go, you **listen** for cancellation using a `select` statement:

```go
func downloadFile(ctx context.Context, filename string) error {
    // Simulate a slow operation, but watch for context cancellation
    select {
    case <-time.After(2 * time.Second): // Work finishes
        if filename == "file2.txt" {
            return errors.New("network timeout")
        }
        return nil
    case <-ctx.Done():
        // The parent cancelled, a timeout hit, or errgroup aborted!
        // Return ctx.Err() to indicate why we stopped.
        return ctx.Err() 
    }
}

```

---

### Rule 4: Always Call `defer cancel()`

When you create a child context with a timeout or cancellation function (like `context.WithTimeout` or `context.WithCancel`), you **must** immediately defer the cancel function.

Failing to do this causes a **context leak**, leaking memory and internal timers until the program exits.

```go
func main() {
    // Create a timeout context for the whole application lifecycle
    ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
    defer cancel() // ⚠️ CRITICAL: Prevents memory and timer leaks!

    // ... pass ctx down ...
}

```

---

### Rule 5: Context is for Request Scope, Not Optional Function Arguments

Never use `context.Context` just to pass optional configuration parameters (like a string feature flag, a user ID, or a config setting) into a function. Context is strictly for:

1. **Cancellation signals** (stop working now).
2. **Deadlines / Timeouts** (stop working by X time).
3. **Request-scoped values** (like tracing IDs or authentication tokens—use sparingly).

---

### How Context Ties Into Your `errgroup` Pattern

When you used `errgroup.WithContext(ctx)` earlier, Go automatically linked context cancellation to your batch tasks:

1. `ctx` enters `main`.
2. `errgroup.WithContext(ctx)` creates a derived child context (`gCtx`).
3. If **any** worker returns an error, `errgroup` automatically triggers cancellation on `gCtx`.
4. All other running goroutines check `<-ctx.Done()` or pass `gCtx` to their sub-functions, allowing them to **abort instantly** instead of wasting CPU and network resources completing doomed tasks.