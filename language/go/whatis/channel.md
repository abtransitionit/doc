[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:      ../howto/channel.md
[context whatis]:   ../whatis/context.md
[goroutine whatis]:   ../whatis/goroutine.md


<div align="center">

# Langage Go - Whatis - Channel

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Context][context whatis] · [Goroutine][goroutine whatis]| internal |

# Definition
- A pipe
- Allow 2 goroutine to exhange data od a specific type
- Uses the following concept: sender/receiver, block/unlock,


# Kind
- **buffered**: syncrhonous exhange between goroutines
- **Unbuffered**: asyncrhonous exachanges between goroutines
- send only; read only; send and receive: 



# Key point
- The buffer of size 1 allows one value to be stored without a receiver being ready immediately.

# Unbuffred Channel mechanism
1. **Sender**: reaches the instruction `ch <- ...` (ie. Send a message into the channel), 
1. **runtime**: blocks sender (at this line of code) if no receiver.
1. **Receiver**: reaches the instruction `... <- ch ` (ie. receive the message from that channel)
1. **runtime**: blocks receiver (at this line of code) if no sender.
1. **Receiver and Sender**: are now at their exact respective line of code
1. **runtime** unblocks the sender (wakes it) if it was blocked.
1. **runtime** unblocks the receiver (wakes it) if it was blocked.
1. **Rendezvous**: Receiver takes the value **directly** from the sender
1. **Receiver and Sender**: are ready to continue executing the code after their respecting line of code.


## Graph

```
                        UNBUFFERED CHANNEL  (make(chan T))
                        ────────────────────────────────
                        capacity = 0  →  synchronous handoff


   SENDER goroutine                                   RECEIVER goroutine
   ────────────────                                   ──────────────────

   ①  ch <- value                                     ③  msg := <-ch
        │                                                  │
        ▼                                                  ▼
   ┌──────────────┐                                  ┌──────────────┐
   │  runtime:    │                                  │  runtime:    │
   │  BLOCK       │  ②  no receiver yet?             │  BLOCK       │  ④  no sender yet?
   │  sender at   │      → park & wait               │  receiver at │      → park & wait
   │  this line   │                                  │  this line   │
   └──────────────┘                                  └──────────────┘
        │                                                  │
        │                                                  │
        └──────────────────┐          ┌───────────────────┘
                           │          │
                           ▼          ▼
                    ┌───────────────────────┐
                    │   ⑤  RENDEZVOUS       │
                    │  both goroutines are  │
                    │  parked at their      │
                    │  respective lines     │
                    └───────────────────────┘
                           │          │
                           ▼          ▼
                    ┌───────────────────────┐
                    │  ⑥ runtime wakes     │
                    │     the SENDER        │
                    │  ⑦ runtime wakes     │
                    │     the RECEIVER      │
                    └───────────────────────┘
                           │          │
                           ▼          ▼
                    ┌───────────────────────┐
                    │  ⑧ VALUE HANDOFF      │
                    │  receiver takes the   │
                    │  value DIRECTLY from  │
                    │  the sender           │
                    │  (no buffer involved) │
                    └───────────────────────┘
                           │          │
                           ▼          ▼
                    ┌───────────────────────┐
                    │  ⑨ both proceed       │
                    │  executing the code   │
                    │  AFTER their line     │
                    └───────────────────────┘
                           │          │
                           ▼          ▼
                    sender continues    receiver continues
                    (next statement)    (next statement)


   LEGEND
   ──────
   ①  sender reaches   ch <- value
   ②  runtime blocks sender if no receiver is ready
   ③  receiver reaches value := <-ch
   ④  runtime blocks receiver if no sender is ready
   ⑤  both are at their exact line → rendezvous point
   ⑥  runtime unblocks (wakes) the sender
   ⑦  runtime unblocks (wakes) the receiver
   ⑧  receiver takes the value directly from the sender
   ⑨  both are ready to continue after their line of code
```

**summary**: an unbuffered channel is a synchronous rendezvous point — the send and the receive must meet at the same instant before either goroutine can move on.

# Unbuffered vs. Buffered

| Aspect | Unbuffered `make(chan T)` | Buffered `make(chan T, n)` |
|---|---|---|
| Capacity | 0 | `n` |
| Send blocks until… | a receiver is ready | buffer is full |
| Receive blocks until… | a sender is ready | buffer is empty |
| Synchronization | **synchronous** (handoff) | **asynchronous** (up to `n` items) |





#  Operation

The channel Operator

|name|syntax|meaning|runtime|example
| -- | -- | -- | -- | -- |
| send | **<-** | send a message into the pipe | block goroutine at that line | `ch <- "Hello"` |
| receive | **:= <-**  | receive a message from the pipe | block goroutine at that line | `msg := <-ch` |

after a certain delay when both arrives at their respective line of code, the value in the chanel is exchanged

## Unbuffered channel

It is mandatory to have a **receiver** ready to receive the message, otherwise the sending operation will **block forever** (or until a receiver appears).

|opeartion|code|meaning|
|-|-|-|
| Send | `ch <- ...` | the runtime stop at this line (block the sender) until a receiver is ready.
| Receive | `... := <-ch` | the runtime stop at this line (block the receiver) until a sender is ready.

When the sender and receiver meet, the exchange happens directly between them (rendez vous), and both can continue.

## Buffered channel

```
                    BUFFERED CHANNEL  (make(chan T, n))
                    ─────────────────────────────────
                    capacity = n  →  asynchronous handoff
                    (example below shows n = 3)


   SENDER goroutine                                   RECEIVER goroutine
   ────────────────                                   ──────────────────

   ①  ch <- value                                     ③  msg := <-ch
        │                                                  │
        ▼                                                  ▼
   ┌──────────────┐                                  ┌──────────────┐
   │  runtime:    │ ②  is the buffer FULL?           │  runtime:    │ ④  is the buffer EMPTY?
   │  check       │     ┌── YES → BLOCK sender       │  check       │     ┌── YES → BLOCK receiver
   │  buffer      │     └── NO  → proceed (see ⑤)    │  buffer      │     └── NO  → proceed (see ⑤)
   └──────────────┘                                  └──────────────┘
        │                                                  │
        │                                                  │
        ▼                                                  ▼
   ┌─────────────────────────┐                 ┌─────────────────────────┐
   │ ⑤a SENDER deposits the  │                 │ ⑤b RECEIVER lifts the   │
   │    value INTO the       │                 │    value OUT of the     │
   │    BUFFER (no receiver  │                 │    BUFFER (no sender    │
   │    needed right now)    │                 │    needed right now)    │
   └─────────────────────────┘                 └─────────────────────────┘
        │                                                  │
        ▼                                                  ▼
   ┌──────────────────────────────────────────────────────────────┐
   │                     THE BUFFER (ring)                         │
   │  ┌─────┬─────┬─────┐                                          │
   │  │  a  │  b  │  c  │   ← up to n values can sit here          │
   │  └─────┴─────┴─────┘     without a matching receiver/sender  │
   │   head ↑           ↑ tail                                     │
   └──────────────────────────────────────────────────────────────┘
        │                                                  │
        ▼                                                  ▼
   sender continues immediately                 receiver continues immediately
   (unless buffer was full → ⑥)                 (unless buffer was empty → ⑦)


   ────────────────────────────────────────────────────────────────
   WHAT HAPPENS WHEN THE OTHER SIDE IS *NOT* READY
   ────────────────────────────────────────────────────────────────

   CASE A — sender arrives, buffer FULL (capacity reached)
   ────────────────────────────────────────────────────────
   ① sender:  ch <- value
        │
        ▼
   ② runtime: buffer full → BLOCK sender at this line
        │
        ▼
   ③ receiver: value := <-ch
        │
        ▼
   ④ runtime: buffer not empty → receiver takes head value
        │
        ▼
   ⑥ runtime: a slot just freed up → WAKE the blocked sender
        │
        ▼
   ⑧ sender deposits its value into the freed slot → proceeds
      (value goes INTO buffer, NOT directly to receiver)
        │
        ▼
   ⑨ both continue after their respective lines


   CASE B — receiver arrives, buffer EMPTY
   ────────────────────────────────────────
   ③ receiver: value := <-ch
        │
        ▼
   ④ runtime: buffer empty → BLOCK receiver at this line
        │
        ▼
   ① sender: ch <- value
        │
        ▼
   ② runtime: buffer not full → sender deposits into buffer
        │
        ▼
   ⑦ runtime: buffer no longer empty → WAKE the blocked receiver
        │
        ▼
   ⑧ receiver lifts the value OUT of the buffer → proceeds
      (value comes FROM buffer, NOT directly from sender)
        │
        ▼
   ⑨ both continue after their respective lines


   LEGEND / KEY DIFFERENCES vs UNBUFFERED
   ──────────────────────────────────────
   ①  sender reaches   ch <- value
   ②  runtime: send blocks ONLY if buffer is FULL
   ③  receiver reaches value := <-ch
   ④  runtime: receive blocks ONLY if buffer is EMPTY
   ⑤  if both sides are happy → sender writes INTO buffer,
                                 receiver reads FROM buffer
                                 (no rendezvous required)
   ⑥  a receive frees a slot → runtime wakes one blocked sender
   ⑦  a send fills a slot   → runtime wakes one blocked receiver
   ⑧  the value travels THROUGH the buffer, never directly
       from sender to receiver
   ⑨  both goroutines resume after their line of code

   ✦ NO strict 1-to-1 rendezvous: sender and receiver are DECOUPLED
     up to n items. They don't need to meet at the same instant.
   ✦ Capacity = 0 collapses this back into the unbuffered rendezvous.
```


# Todo


### Closing a channel

```go
close(ch)
```

That's it — `close()` is a built-in function that marks the channel as closed.

### What does closing do?

After you close a channel:

1. **You can no longer send** to it — sending to a closed channel panics.
2. **You can still receive from it** — but receives return immediately with the **zero value** of the channel's type.
3. **Receiving from a closed channel also returns a second value** `ok` = `false`:

```go
ch := make(chan string)
close(ch)

msg, ok := <-ch
fmt.Println(msg, ok) // ""  false   <- zero value, ok=false
```

Compare to receiving from an open (but empty) channel, which *blocks* until something arrives.


### The idiomatic "range" pattern


### Quick rules to remember


So closing is a one-way "I'm done" signal — and that's exactly how `context` tells your goroutine "stop now."