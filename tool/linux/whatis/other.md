[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Linux Tool][home topic] · [↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[aft whatis]: https://aft.dev/docs/
[aft git]:    https://github.com/akumansley/aft

Related topics

| Topic | Location | Kind    |
| - | - | - |
|[What is aft][aft whatis]|external| 
|[aft on github][aft git]|external| 

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">What is command</h1>

# Check a function exits
```sh
type info  >/dev/null 2>&1 || { echo "Missing function: info"; exit 1; }
type error >/dev/null 2>&1 || { echo "Missing function: error"; exit 1; }
```
