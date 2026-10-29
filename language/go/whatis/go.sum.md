[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[gomod whatis]:     ../whatis/go.mod
[module whatis]:  ../whatis/module

<div align="center">

# Langage Go - Whatis - go.sum


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Related topics

| Topic | Location | Kind |
|-|-|-|
| [what is a module][module whatis] | internal |
| [what is go.mod][gomod whatis] | internal |


# Definition
- a text file
- managed by `Go`
- contains version and checksums of [dependency modules][module whatis]
- typically 2 lines per dependency module version:
    - one line indicates the checksum of the module's source archive
    - one line indicates the checksum of the module's go.mod file
