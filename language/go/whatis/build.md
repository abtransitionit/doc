[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:    ../howto/build
[envar whatis]:   ../whatis/envar
[package whatis]: ../whatis/package


<div align="center">

# Langage Go - Whatis - Build

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Package][package whatis] | internal |


# Definition
- Applies to a [package][package whatis]; not a module
- Conceptually made of 2 stages:
  1. **Compile stage**
     - The package is compiled into an artifact and stored in the cache ([envar][envar whatis] `GOCACHE`).
     - Its dependencies are also compiled as needed.
     - Previously compiled results may be reused from the build cache ([envar][envar whatis] GOCACHE).
  1. **Link stage** (⚠️ Only if the build produce one or more executable artifacts.)
     - The previously compiled package are linked together to produce a single executable artifact.

