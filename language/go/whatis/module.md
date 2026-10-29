[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:     ../howto/module
[module whatis ref]: https://golang.org/ref/mod
[go whatis]:        ../whatis/go
[package whatis]:   ../whatis/package
[package build whatis]:   ../whatis/package#the-build-process
[go.mod whatis]:   ../whatis/go.mod
[go.sum whatis]:   ../whatis/go.sum
[library whatis]:   ../whatis/library
[build whatis]:     ../whatis/go#the-build-process


<div align="center">

# Langage Go - Whatis - Module

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Topic | Location | Kind |
|-|-|-|
| [what is go][go whatis] | internal |
| [what is a package][package whatis] | internal |
| [go module reference][module whatis ref] | internal |
| [what is a library][library whatis] | internal |
| [what is go.mod][go.mod whatis] | internal |
| [what is go.sum][go.sum whatis] | internal |



# Definition
- a directory
- contains a set of related Go [`Go`] [packages][package whatis].

## Member
- version (e.g., v1.2.3)
- a file [`go.sum`][go.sum whatis]
- a file [`go.mod`][go.mod whatis] that list dependencies (dependency modules)
- defined by a file [`go.mod`][go.mod whatis] at its root
- has a file [`go.sum`][go.sum whatis] tracking version and checksum of dependency modules

## Content of a Module
**example 01**
```text
module
├── go.mod     ← file defined by the developper and partially by go
├── go.sum     ← file managed by go or through go CLI
│
├── package A  ← directory
├── package B  ← directory
└── package C  ← directory
```

# Kind

**main module**
- the module identified by the directive:`module` in the file:[go.mod][go.mod whatis]

**dependency module**
  - module identified by the directive:`require` in the file:[`go.mod`][go.mod whatis]
  - module required by those dependencies (transitive/indirect dependencies).


# Key points
- **Without a `go.mod` file at its root, a directory is not a Go module**
- can contain zero, one, or several `main` [packages][package whatis].
- can produce one or more artifacts at build time (ie. when building each of its package).




## Content of a module


**example 02**
```
my-module/
│
├── go.mod             ← file
├── go.sum             ← file
│
├── cmd/               ← package
│   ├── server/        ← main package    ──► compiler ──► ...
│   │   └── main.go    
│   │
│   └── client/        ← main package    ──► compiler ──► ...
│       └── main.go    
│
├── foo/               ← library package ──► compiler ──► ...
│   └── foo1.go        
│   └── foo2.go
│
└── bar/               ← library package ──► compiler ──► ...
    └── bar1.go        
    └── bar2.go

Module
│
├── Package main ──► compiler + linker ──► executable A
├── Package main ──► compiler + linker ──► executable B
├── Package foo  ──► compiler          ──► library
├── Package bar  ──► compiler          ──► library
└── Package baz  ──► compiler          ──► library
```





# The build process

`go build ./...` on a module means: *[Build][build whatis] all the [packages][package build whatis] in this module*:

## Resolving dependencies
modules are automatically donwloaded (in GO) on
  - `go build`
  - `go test`
  - `go mod tidy`


# operation
- list dependencies
- create

## Managing a module
*   `go mod tidy`:   clean the file `go.mod` and `go.sum` by adding missing dependencies and removing unused dependencies.
*   `go mod vendor`: Create a folder `vendor` containing a local copy of all dependencies.
*   `go mod edit`:   Permet de modifier le fichier `go.mod` via des scripts ou la ligne de commande (par exemple, pour ajouter une directive `exclude`) .
*   `go mod init` : Initialize a new module by creating the file `go.mod` .

## Other cli

`go get` : add, update, downgrade, delete a dependency
  - `go get example.com/pkg@v1.2.3`: version spécifique
  - `go get example.com/mod@none`: supprimer .
- `go work` : manage *workspace* (regroupent plusieurs modules locaux pour le développement)
  - `init`, `use`: add a module to workspace ou `sync` .
  - `sync`

