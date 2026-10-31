[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md


[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]:    ../whatis/select.md
[channel howto]:    ../howto/channel.md
[context howto]:    ../howto/context.md

<div align="center">

# Langage Go — Howto - Select

[↑ Whatis][topic whatis]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Howto | [Channel][channel howto] . [Context][context howto]| internal |



```go
func main() {
    // create a channel
    ch := make(chan string)

    // launch a goroutine
    go func() {
        time.Sleep(1 * time.Second)
        ch <- "done" // SEND ... WAIT for receiver
    }()

    select {
    case msg := <-ch1:
        // A message was received from ch1

    case ch2 <- "hello":
        // A message was sent to ch2

    case <-time.After(2 * time.Second):
        // Timeout occurred

    default:
        // Execute immediately if no case is ready
    }

// runtime blocks execution of code here until a ready case
    select {
    case msg := <-ch: // RECEIVE ... WAIT for sender 
        fmt.Println("received:", msg)
    case <-time.After(2 * time.Second):
        fmt.Println("timeout")
    }
}
```

**Meaning**:
- `time.After(2 * time.Second)` creates a timer that sends a value into a channel after 2 seconds.
- create a channel
- launch a concurent goroutine (that do a job ... sends msg to a channel)
- select waits for a ready case to proceed
- the select
    - if msg arrives ⇒ OK; proceed
    - if 
- the select finishes after the delay or when a message arrives