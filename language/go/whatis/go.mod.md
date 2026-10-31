[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:     ../howto/go.mod
[go.mod whatis ref]: https://go.dev/ref/mod#go-mod-file
[go.sum howto]:     ../howto/go.sum
[module whatis]:  ../whatis/module
[module main whatis]:  ../whatis/module#kind
[module whatis]:  ../whatis/module

<div align="center">

# Langage Go - Whatis go.mod

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Module][module whatis]| internal |
| Howto | [go.sum][go.sum howto]| internal |
| Whatis | [go.mod reference][go.mod whatis ref]| external |




# Definition

- a txt file located in the root folder of a module
- defines some properties of the `main` [module][module main whatis]
  - version of the module
  - version of go toolchain
  - list of dependencies (direct and indirect)

# Directives
*   `module` : Déclare the path (ie. uniq id) of the current module.
*   `go` : Spécify the minimal required version of `Go` toolchain.
*   **dependency management** :
    *   `require` : Déclare a dependency to another module.
    *   `replace` : Replace the content of a module (a version or all) by another module or a local folder (needed to use a fork or test localy) .
    *   `exclude` : Exclude a specific version of a module from the graph dependencies.
*   **configuration tool** :
    *   `tool` : Add a tool as a dependency, to use with `go tool` .
    *   `toolchain` : propose a Go toolchain name to use.
    *   `godebug` : define default `GODEBUG` parameters défaut pour les paquets principaux du module .

# Example
```
module github.com/abtransitionit/go-core       ← name of the [main] module
go 1.26                                        ← toolchain version
require github.com/stretchr/testify v1.11.1    ← dependency module
require gopkg.in/yaml.v3 v3.0.1                ← dependency module
...
```
