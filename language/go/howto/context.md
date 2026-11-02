[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: ../whatis/context.md

<div align="center">

# Langage Go — Howto - Context

[↑ Whatis][topic whatis]

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Topic | Location | Kind |
|-|-|-|



# Create a context
```sh
# create an empty context
ctx := context.Background()
```

# Configure a context

```sh
# Add cancellation ⇨ allow to stop process hierarchy
ctx, cancel := context.WithCancel(ctx)
defer cancel()

# Add timeout ⇨ allow to stop a process hierarchy
ctx, cancel := context.WithTimeout(ctx, 5*time.Second)
defer cancel()

# Add kvpair ⇨ make a kvpair available
ctx = context.WithValue(ctx, "requestID", "123")
```
# Manage kvpair with context
```go
func DoSomething(ctx context.Context) {
    userID := ctx.Value("userID")
    fmt.Println(userID)
}

func main() {
    // create empty context
    ctx := context.Background()

    // add a kvpair
    ctx = context.WithValue(ctx, "userID", "user-123")

    // pass the vaule to that function only
    DoSomething(ctx)
}
```

# create a triggable context
```go
// can only be triggered by the instruction cancel()
ctx, cancel := context.WithCancel(ctx)
defer cancel()

// can only be triggered by user Ctrl+C 
// Listens for signals: Ctrl and kill to trigger the cancelation
ctx, stop := signal.NotifyContext(ctx, os.Interrupt)
defer stop()

```

**Meaning**
- `cancel()` → Done() closes → your code wakes up
- `user presses Ctrl+C`  →  triggers Done() to close  →  your code wakes up

# Todo
Because each HTTP request gets its own context instance.

Look at this example:

```
func handler(w http.ResponseWriter, r *http.Request) {
    ctx := context.WithValue(
        r.Context(),
        "userID",
        getUserID(r),
    )

    process(ctx)
}

func process(ctx context.Context) {
    userID := ctx.Value("userID")
    fmt.Println(userID)
}
```

Imagine two requests arriving simultaneously:

Request 1

```
ctx1 := context.WithValue(
    context.Background(), "userID", "Alice",
)
```

Request 2

```
ctx2 := context.WithValue(
    context.Background(), "userID", "Bob",
)
```

They are two different context instances.

Goroutine 1

`ctx1` → `userID = Alice`

Goroutine 2

`ctx2` → `userID = Bob`

When `process(ctx1)` executes, it gets Alice.

When `process(ctx2)` executes, it gets Bob.

Why? Because `context.WithValue` returns a new context derived from its parent. It doesn't modify the parent context or a global variable.

That's how concurrent requests keep their own values.

# Listen to cancelation

```go
select {
case <-ctx.Done():
    // Context was canceled (or timed out)
    return
default:
    // Context is still active, do your work
}
```

**Example**
```go
func workerDoTask(ctx context.Context) {
    for {
        select {
        case <-ctx.Done():
            fmt.Println("Stopping:", ctx.Err())
            return // Exit the goroutine
        default:
            // Perform your task here
        }
    }
}
```
**Key Points**

- **`ctx.Done()` returns a channel**: When the context is canceled, this channel is closed. Reading from it returns immediately .
- **Always `defer cancel()`**: If you create a context with `context.WithCancel` or `context.WithTimeout`, always defer the cancel function to avoid leaking resources .
- **Check `ctx.Err()`**: After cancellation, `ctx.Err()` tells you *why* it stopped (e.g., `context.Canceled` or `context.DeadlineExceeded`).

If you need to know the *specific reason* (e.g., a custom cause or a signal), you can use `context.Cause(ctx)` (Go 1.20+), but for simply *listening* for the cancellation signal, `<-ctx.Done()` is the simplest and most universal way .


# Why does this matter for `ctx.Done()`?

`ctx.Done()` returns a channel of type `<-chan struct{}` (receive-only). 

The context package **closes that channel internally** when the context is canceled.

So when you write:

```go
<-ctx.Done()
```

...you're **receiving from a channel** (like you already know!). It just returns *immediately* because the channel got closed. That's the whole trick — no magic, just a closed channel.

