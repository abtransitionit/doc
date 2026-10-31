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


# Check a CLI is installed


```sh
# check a CLI is on the PATH
command -v podman
command -v docker
command -v info  >/dev/null || { echo "Missing function: info"; exit 1; }
command -v error >/dev/null || { echo "Missing function: error"; exit 1; }
```

**Meaning**:Checks whether a name is available as an **alias**, **function**, **builtin** or **executable** command. It doesn't specifically verify that it's a function.

