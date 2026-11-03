
# Why it feels like a nightmare

`Channel`, `mutex` and `select` are **low-level primitives**. When you have:
- N senders, M receivers
- some closing, some not
- some cancellable, some not
- some needing responses, some fire-and-forget

problem appears:
- Who closes? (Close-on-sender vs. close-on-receiver deadlocks)
- What if a receiver leaves early? (Sender blocks forever)
- Who guarantees delivery? (Nothing — no ACK)
- How do you know work is done? (Now you need `WaitGroup` *and* channels)
- How do you cancel? (Now you need `context` too)


# The Go community's own conclusion

Don't try to do everything with **channels**.
- Use channels for **ownership transfer** and **orchestration**. 
- Use `sync` primitives (`Mutex`, `WaitGroup`, `RWMutex`) for **shared state**. 
- Use `context` for **cancellation**. 

Most production Go codebases 
- use channels **sparingly** — for pipelines, worker pools, fan-in/fan-out, and signaling 
- use `Mutex` for anything that's genuinely shared state. 


# The mental models that tame it


## Model 1 — **Ownership transfer** (channels shine)

- One goroutine *owns* a value. 
- It hands ownership to another via a channel. 
- After the send, the sender **never touches it again**. 
- No locks needed. This is the happy path 
— use channels for this.

```go
// producer owns the data, sends it, forgets it
ch <- &Result{...}
```

## Model 2 — **Pipeline** (channels shine)

- `Stage A → Stage B → Stage C`
- each a goroutine, connected by channels. 
- Each stage has **one input, one output**. 
- **Rule**: 
     - **the sender closes its output channel** when done. 
     - **Receivers** use `for v := range ch`. 
     - This eliminates the "who closes?" nightmare — the answer is always "the sender."

```go
func stage(in <-chan int) <-chan int {
    out := make(chan int)
    go func() {
        defer close(out) // ← the rule: sender closes
        for v := range in {
            out <- transform(v)
        }
    }()
    return out
}
```

The `defer close(out)` + `for v := range in` pattern is *the* answer to "who closes and who stops." 

Learn this one pattern and **80%** of multi-goroutine channel code becomes mechanical.

## Model 3 — **Worker pool** (channels shine)

- N workers
- one job channel
- one results channel. 
- `WaitGroup` waits for workers. 
- `context` cancels. 
- This is the standard shape for "many goroutines, bounded concurrency":

```go
jobs := make(chan Job)
results := make(chan Result)
var wg sync.WaitGroup

for i := 0; i < N; i++ {
    wg.Add(1)
    go func() {
        defer wg.Done()
        for j := range jobs {        // ← range, not select
            select {
            case results <- do(j):    // ← cancellable send
            case <-ctx.Done():
                return
            }
        }
    }()
}

// feeder closes jobs when done
go func() {
    defer close(jobs)
    for _, j := range allJobs {
        select {
        case jobs <- j:
        case <-ctx.Done():
            return
        }
    }
}()

// closer closes results when workers finish
go func() {
    wg.Wait()
    close(results)
}()

for r := range results { // ← main just ranges
    handle(r)
}
```

**Notice**: 
- **each goroutine owns exactly one channel boundary**. 
- The main loop is trivial. 
- The complexity is *contained* in the setup, not spread across every line.


## Model 4 — **Select loop / event loop** (the escape hatch)

- When you genuinely have many channels and complex routing
- **collapse them into one goroutine with a `select`**. 
- One goroutine, one loop, N channels:

```go
for {
    select {
    case a := <-chA: ...
    case b := <-chB: ...
    case <-ctx.Done(): return
    }
}
```

- This is the "single-threaded event loop" pattern (Node.js style) recreated in Go. 
- It's how you avoid `Mutex` for shared state
- the state lives inside one goroutine, and the `select` serializes access. 
- **This is the single most powerful mental model** for "many goroutines communicating.
- You don't need to synchronize N goroutines against each other
- you funnel their messages into *one* goroutine that owns the state.

## Model 5 — **Just use a Mutex** (the honest answer)

- If two goroutines need to read/write the same map
- **don't** build a channel-based map server. Just:

```go
type Store struct {
    mu sync.Mutex
    m  map[string]int
}

func (s *Store) Set(k string, v int) {
    s.mu.Lock()
    defer s.mu.Unlock()
    s.m = append...
}
```

- Channels are *worse* than a `Mutex` for shared state
- slower, more code, more failure modes. The Go team says this explicitly. 
- Reach for a channel only when the problem is **flow** (data moving through stages), not **state** (data being read/modified by many).


# Best practices


**The channel complexity wall**
- 1 goroutine → easy. 
- 2 goroutines → manageable. 
- N goroutines with cancellation → suddenly you need `chan` + `WaitGroup` + `context` + close-discipline.
- By the end, the learner sees channels as **one tool in a small toolbox**, not the toolbox itself. 
- That's the difference between "nightmare" and "boring" — and boring is the goal in concurrency.


> - **Pipeline**: who closes? → the sender. Who stops? → `range` ends on close.
> - **Worker pool**: N workers, 1 job channel, 1 result channel, 1 `WaitGroup`, 1 `context`. Fixed shape.
> - **Event loop**: many channels → one `select` loop → one owner of state.
> - **Mutex**: shared state → don't use channels.


Don't invent coordination per-project; you recognize which of ~5 shapes you're in and apply the template.




| Problem | Tool |
|---------|------|
| Move a value between 2 goroutines | `chan` (Meth00–01) |
| Wait for N goroutines to finish | `WaitGroup` (Meth02) |
| Signal an event to many waiters | `close(chan)` (Meth03) |
| Cancel work in flight | `context` (Meth04) |
| Stream many values through stages | pipeline + `close` by sender (next) |
| Bound concurrency | worker pool (next) |
| Own mutable state from many goroutines | event loop `select` (next) |
| Shared read/write state | `Mutex` (next) |


**Bottom line**

1. **Use channels only for flow** (ownership transfer, pipelines, worker pools, signaling).
2. **Use `Mutex` for state.**
3. **Use `context` for cancellation.**
4. **Recognize 5 patterns** and stop inventing coordination per-project.
5. **Collapse many channels into one `select` loop** when it gets hairy.

**pipeline / worker pool / event loop** 

**who closes**, **who stops**, **who owns state**
