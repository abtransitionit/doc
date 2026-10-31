[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md


[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]:   ../whatis/channel.md
[context howto]:  ../howto/context.md


<div align="center">

# Langage Go — Howto - Channel

[↑ Whatis][topic whatis]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Howto | [Context][context howto] | internal |




# Create an ubufferd channel
```go
// create a channel of strings that can send and reveive
ch := make(chan string)
```

**Meaning**:
- the channel is **unbuffered** (no size is specified)
- the channel can **send** and **receive** data (aka. message) of type **string**
- it does not create a **goroutine** nor a **channel**


# Send a msg into a channel
```go
```

# Receive a msg from a channel
```go
msg, ok := <-ch
```


# close a channel
```go
close(ch)
```

**Meaning**:
- sending to a closed channel panics.
- the channel can **send** and **receive** data (aka. message) of type **string**
- it does not create a **goroutine** nor a **channel**

# Temporary summary

| Operation | syntax | On open channel | On closed channel |
|---|---|---|---|
| Send | `ch <- x` | blocks until received | **panics** |
| Receive | `<-ch` | blocks until sent | returns zero value immediately |
| Receive | `v, ok := <-ch` | ok=true when received | ok=false |
| Close | `close(ch)` | closes it | **panics** (double close) |


# Consume a channel until it's closed:

```go
for msg := range ch {
    fmt.Println(msg)
}
```

**Meaning**
- Loop exits automatically when `ch` is closed. 
- This is why closing is useful: it's the signal "no more values coming."

# Create an buffered channel

```go
// create a buffered channel of strings with capacity 3
ch := make(chan string, 3)
```

**Meaning**:
- the channel is **buffered** (a size/capacity of `3` is specified)
- the channel can **send** and **receive** data (aka. message) of type **string**
- it can hold up to **3** values in its buffer **without a corresponding receiver** being ready
- sends block **only when the buffer is full**
- receives block **only when the buffer is empty**
- it does not create a **goroutine** nor a **channel** (it *is* the channel)



# Unbuffered

```go
package main

import "fmt"

func main() {
    // create a buffred channel
	ch := make(chan string, 3)

	// These three sends do NOT block, because the buffer has room.
	ch <- "a"
	ch <- "b"
	ch <- "c"

	// A 4th send would block until a receive frees a slot:
	// ch <- "d" // deadlock here in a single goroutine

	fmt.Println(<-ch) // a
	fmt.Println(<-ch) // b
	fmt.Println(<-ch) // c
}
```

**Key takeaway**: buffering decouples sender and receiver up to a fixed capacity. It does **not** make the channel infinite — once full, sends still block. And closing the channel still signals "no more values," regardless of buffer size.



# The deadlock
## V1
```go
func main() {
    ch := make(chan string) // create the channel
    ch <- "Hello"           // SEND ← sender block here until a receiver 
}
```

**Meaning**:
- `main()` starts
- at the **send** line `ch <-`: the runtime block
- as there is no receiver: an error occured

## V2
```go
func main() {
    ch := make(chan string) // create the channel

    ch <- "Hello" // SEND    ← runtime block that goroutine here until a receiver (running concurently receive)
    msg := <-ch   // RECEIVE ← code never reached

    fmt.Println(msg)
}
```

**Meaning**:
- `main()` starts
- at the **send** line `ch <-`: the runtime block until a parallel other goroutine do a `<- ch`
- as there is no other **concurent** receiver: an error occured

# Basic Usage - No deadlock

```go
package main

import "fmt"

func main() {
    // create the channel
    ch := make(chan string)

    // create a goroutine
    go func() {
        ch <- "Hello from goroutine" // send data (aka. message) to the channel from that goroutine
    }()

    // Receive the message from the channel in the main goroutine
    msg := <-ch
    fmt.Println(msg)
}
```
**Meaning**:
- `main()` starts
- `main()`: create a channel
- `goroutine()` starts
- form now the `main()` process and the `goroutine()` process runs in parallel
- `goroutine()`: reaches and stuck at SEND (`ch <-`) by runtime
- `main()`: reaches and stuck at RECEIVE (`<- ch `) by runtime
- `main()` and `goroutine()` communicate to exchange the value in the channel


# Buffered Channel

```go
package main

import "fmt"

func main() {
	ch := make(chan string, 3) // Buffered Channel can contains 3 items max

	// These three sends do NOT block, because the buffer has room.
	ch <- "a"
	ch <- "b"
	ch <- "c"

	// A 4th send would block until a receive frees a slot:
	// ch <- "d" // deadlock here in a single goroutine

	fmt.Println(<-ch) // a
	fmt.Println(<-ch) // b
	fmt.Println(<-ch) // c
}
```