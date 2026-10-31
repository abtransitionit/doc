[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md


[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:    ../howto/goroutine.md
[channel whatis]: ../whatis/channel.md
[goroutine whatis ref]: https://dev.to/souvikinator/understanding-goroutines-and-channels-in-golang-with-intuitive-visuals-16gj

<div align="center">

# Langage Go — Whatis - Goroutine

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Channel][channel whatis]| internal |
| Whatis | [Goroutine][goroutine whatis ref]| external |


# Definition
- A function 
- Runs in concurent/asynchrone/parallel mode
- Managed by Go.

# Goroutine vs. Function

| Aspect   | Function   | Goroutine         |
| --------- | ---------- | ----------------- |
| Execution | Sequential | Concurrent        |
| Blocking  | Yes        | No (non-blocking) |
| Syntax    | `myFunc()` | `go myFunc()`     |

# Key Points
- Goroutines don’t return values directly.
- [channels][channel whatis] are used to get data out of a goroutine

# Operation
- block by the (go runtime)
- unblock by the (go runtime)

## Block

When a goroutine **blocks**: 
- It **stops** executing and waits. 
- It is **paused** by the **Go runtime** and does not run any further lines of code. 
- It sits there, doing nothing, until some event lets it continue.

**Example**: When do a goroutine **blocks**: 
- `ch <- value` on an unbuffered channel with no receiver → the sender goroutine blocks (freezes at that line).

## Unlock
When a goroutine unlocks: 
- It resume execution. 
- The paused goroutine **wakes up** and **continues** from the line where it was stuck.


# Syntax
## no argument

```go
go func() {downloadFile("file1.txt")}()
```

**Meaning**
- `downloadFile()` a std function
- `func() { ... }` defines an **anonymous function** (a function without a name) that wrap `downloadFile()`.
- `go func() {...}()` make that **anonymous function** a goroutine to launch
- `()` at the end define a space to provide argument to the function.

## with argument

```go
go func(f string) {downloadFile(f)}("file1.txt")
```

**Meaning**
- `downloadFile(f)` a std function
- `func() { ... }` defines an **anonymous function** (a function without a name).
- `go func() {...}()` make that **anonymous function** a goroutine to launch
- `(f string)` the argument of the anonymous function
- `("file1.txt")` the value of that argument that is passed to the nonymous

