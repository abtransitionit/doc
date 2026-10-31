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

