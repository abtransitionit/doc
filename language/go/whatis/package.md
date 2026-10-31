[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]:  ../howto/package
[build whatis]:  ../whatis/build
[module whatis]: ../whatis/module
[module main whatis]:  ../whatis/module#main-module-vs-dependency-module
[module build whatis]: ../whatis/module#the-build-process
[source whatis]: ../whatis/source
[go whatis]:     ../whatis/go
[build whatis]:  ../whatis/go#the-build-process


<div align="center">

# Langage Go - Whatis - Package

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Module][module whatis] . [Build][build whatis] . [Source file][source whatis]| internal |






# Definition
- belongs to a [module][module whatis]
- directory or sub-directory within a module
- generally one package per directory.
- contains a set of `GO` [source files][source whatis] and/or directories


# Key points
- Conceptually each package of the module has the same version : the version of the module it belongs.
- at build time, all source files of one package are compiled together to produce an artifact (ie. an compiled file with extesion `.a`)
- all source files of one package **MUST** have the same directive `package xxx`

```
cmd/server/
├── main.go    → // package main
└── foo.go     → // package foo    ❌
```


# Kind
### Related to build


**Main package**
- package name MUST be `main`
- must contains `func main()` that is the entry point of the executable
- is intended to produce an executable with the main function as entry point.

**Library package**
- package name is NOT `main`
- can be imported by other packages
- contains `functions/types/...`. that other packages can `import`
- may contain a function named `main`, but it has no special meaning


---
### Related to access
**Internal package**
- any package under directory `internal/...`
- only packages under (Parent of internal)/... can import it

**Public package**
- any packages can import it


# The build process
`go build` over one package of a [module][module build whatis] means: [builds][build whatis] artifacts from the provided package.

- if the package is a `main` package:
    - compile the package and its dependencies. It produce one or more compiled artifacts (`.a` archives)
    - install the compiled package into `GOCACHE`
    - link the compiled artifacts. 
    - produce an executable artifact in which `main()` is the executable's entry point
    - install the binary artifact into `GOCACHE`

- if the package is a `library` package:
    - compile the package and its dependencies. It produce one or more compiled artifacts (`.a` archives)
    - install the compiled package into `GOCACHE`



## Use case
### Module with only `library` packages
```
Dev time                         Compil time               Link time                                                 

Module/
│
├── Package A.    (library package)
│   │
│   ├── foo.go ─┐
│   ├── bar.go ─┼─────► compiler ───► PackageA.a  ──────► BUILD CACHE
│   └── baz.go ─┘                                           
│                                                            
└── Package B.    (library package)                                               
    │                                                       
    ├── qux.go ─┐                                           
    ├── quux.go ┼─────► compiler ───►  PackageB.a ──────► BUILD CACHE
    └── xyz.go ─┘
```
> `Package A` and `Package B` are compiled separately, even though they belong to the same module.

> build constraints can exclude files for a particular build

> The selected source file for a package are compiled together to produce the compiled artifact (`.a` archive file).


```go
Package A
   │
   ├── foo.go
   ├── bar_linux.go    ← selected on Linux
   └── bar_windows.go  ← selected on Windows
```





### Module with one or more `main` package
```
Dev time                         Compil time               Link time                                                 

Module/
│
├── Package A     (main package)
│   │
│   ├── foo.go ─┐
│   ├── bar.go ─┼─────► compiler ───► PackageA.a ───────────┐
│   └── baz.go ─┘                                           │
│                                                           │ 
└── Package B     (library package)                         ┼─────► linker ─────► executable
    │                                                       │
    ├── qux.go ─┐                                           │
    ├── quux.go ┼─────► compiler ───►  PackageB.a ──────────┘
    └── xyz.go ─┘
```

> ⚠️ to build an artifact from a package. `go` must compile each dependencies or find them in the cache

# Package `main` vs function `main()`
```
Package            (name: main)
│
├── foo.go
├── bar.go
└── main.go ──► func main() {...}

Package            (name: main)
│
├── foo.go  ──► func main() {...}
├── bar.go
└── other.go

```
→ will produce an **executable** on build
  - The location/filename of `main()` doesn't matter
  - The function `main()` is the entry point of the **executable**
```
Package            (name: foo)
│
├── foo.go
├── bar.go
└── main.go ──► func main() {...}

Package            (name: foo)
│
├── foo.go  ──► func main() {...}
├── bar.go
└── other.go
```
> → will not produce an executable on build


# Use case
## Module containing 1 package `main`
```
Module
│
├── package foo ──compile──► foo.a
├── package bar ──compile──► bar.a
└── package main ──compile──► main.o
                              │
                              └──► LINK ──► myprogram
```
## Module containing `library` packages only (ie. no package main)
```
Module
│
├── package foo ──compile──► foo.a
├── package bar ──compile──► bar.a
└── package baz ──compile──► baz.a

                         no main package
                              │
                              ▼
                         no executable
                             └──► a library
```                         
## Module containing several package `main`

```
my-module/
│
├── go.mod
├── go.sum
│
├── cmd/
│   ├── server/
│   │   └── main.go       ← package main    ──► imports internal/auth
│   │
│   └── client/
│       └── main.go       ← package main    ──► imports internal/auth
│
└── internal/
    ├── database/         ← package library  
    │   └── ...
    │
    └── auth/             ← package library  ──► imports internal/database
        └── ...
```

- in that case `go build ./...` means **"Find all the packages under the current directory and build them"**.
```
                      compil time

my-module/
│
├── go.mod
├── go.sum
│
├── cmd/
│   ├── server/
│   │   └── main.go       ────► compiler ───► server.a (in cache)
│   │
│   └── client/
│       └── main.go       ────► compiler ───► client.a (in cache)
│
└── internal/
    ├── database/.        ────► compiler ───► database.a (in cache)
    │   └── ...
    │
    └── auth/.            ────► compiler ───► auth.a (in cache)
        └── ...
```
order of compilation

1. database.a (put in GOMODCACHE)
1. auth.a     (put in GOMODCACHE)
1. server.a   (put in GOMODCACHE)
1. client.a   (put in GOMODCACHE)```
```
                              build time

database.a ──┐
             │
auth.a ──────┼──► LINK ──► client executable  (put in GOMODCACHE)
             │
client.a ────┘

database.a ──┐
             │
auth.a ──────┼──► LINK ──► client executable (put in GOMODCACHE)
             │
client.a ────┘


    IMPORT GRAPH for client/server 
                       
client ───────► auth ───────► database
  │              │              │
  ▼              ▼              ▼
client.a       auth.a       database.a
  │              │              │
  └──────────────┴──────────────┘
                 │
                LINK
                 │
                 ▼
          client executable
```

# Compilation
- at build time, packages are compiled individually.
- conceptually

```
  module v1.2.3 
   ├── package A                        →  archive A.a
   ├── package B    ──→ compilation ──→ →  archive B.a   ──→ linker ──→ executable (v1.2.3) 
   └── package C                        →  archive C.a
                                            dependencies ─┘
```

# Operation
- import
- create
- [build][build whatis]



# Todo
```
Dev time                                Compil time               Link time                                                 

                          Module
                            │
             ┌──────────────┴────────────┐
             │                           │
        Package A                    Package B
             │                           │
       ┌─────┼─────┐               ┌─────┼─────┐
       │     │     │               │     │     │
     foo.go bar.go baz.go         qux.go quux.go xyz.go
       │     │     │               │     │     │
       └─────┴─────┘               └─────┴─────┘
             │                           │
             │                           │
          compiler                    compiler
             │                           │
             │                           │
             ▼                           ▼
        PackageA.a                   PackageB.a
             │                            │
             └───────────┬────────────────┘
                         │
                       linker
                         │
                         ▼
                   executable/library
```

# Todo
# Terminology
|term|meaning|
|-|-|
|compile|produce an artifact (`.a`) from all go source file of a package|
|link|combine one or several `.a` artifacts into an executable **artifact**.
|build|involve multiple compilation steps + one linking|

- **Dev time**: the developer writes codes
- **Compil time**: the compiler creates an artifact for each package involved in the compilation
- **Link time**: the linker links one or more compiled artifacts to produce an artifact (ie. an executable)
- **Build tume**: the developer launch `go build` that activate one or more compilation + one linking
