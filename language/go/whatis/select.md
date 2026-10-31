[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md


[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:    ../howto/select.md
[channel whatis]: ../whatis/channel.md
[goroutine whatis]: ../whatis/goroutine.md

<div align="center">

# Langage Go — Whatis - Select

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
- A `switch` for channels.
- Can monitor multiple channel operations simultaneously.
- If no case is ready, select blocks (ie. waits) unless a `     ` exists.
- **Cases must be channel ops** (send/receive).
- **Blocks** until one case is ready.
- **Random pick** if multiple ready (fairness).
- **`default`** makes it non-blocking.
- No `fallthrough`; unlike `switch`, it blocks by default.

**Use cases:** timeouts, non-blocking channel ops, multiplexing multiple channels.