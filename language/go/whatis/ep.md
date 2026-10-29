[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[go howto]:       ../howto/go
[build whatis]:   ../whatis/build
[module whatis]:  ../whatis/module
[envar whatis]:   ../whatis/envar
[library whatis]: ../whatis/library
[package whatis]: ../whatis/package
[project howto]:  ../howto/project.md
[project whatis]: ../whatis/project.md
[go dl ext]:      https://go.dev/dl/




<div align="center">

# Langage - Whatis - Go

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Project][project whatis] · [module][module whatis] · [Package][package whatis] · [Build][build whatis] · [Envar][envar whatis] | internal |
| Howto | [get GO][go dl ext] · [Project][project howto] | external |



# Terminology
|term|meaning|
|-|-|
|toolchain|the distribution (ie. set of files to install) to be able to write, build, compile and test `GO` code|
|module|a set of related [`Go`] packages within the same directory|
|Package|a set of related [`Go`] source files within the same directory|

# Definition
- aka. **Golang**
- a programming language developped by Google


# Key points
- **Cross-platform**: Distribution exists for most combination of [os/processor][go dl ext] ((ie. os: **mac**, **linux** or **windows** with processor **arm**, **amd** in **32** or **64** bit))
- **Concurrent**: Built-in goroutines and channels for concurrent programming
- **Garbage collected**: Automatic memory management

# Basic Workflow

- install the **toolchain**.
- creates `Go` projetcs by writing `Go` source code localy on that **VM**
    - create a hierarchy of files and folders
    - creates modules and packages for these projects
    - imports [packages][package whatis] contained in other [modules][module whatis]
- test and debug localy the code
- build **locally** for any specific [os/processor][go dl ext] the single binary **or** the libraries
- deploy it on the target.
- That's all!




# Content of a `GO` project

```
myproject/                     ← THIS IS THE MODULE
├── go.mod                     ← What makes this a module
├── go.sum
│
├── math/                      ← THIS IS A PUBLIC PACKAGE  – any packages can import myproject/math
│   ├── algebra.go             // package math
│   └── calculus.go            // package math
│
│── internal/                  ← internal directory
│   └── auth/                  ← THIS IS AN INTERNAL PACKAGE
│       └── auth.go            // package auth
│
├── api/
│   └── internal/             ← internal directory
│       └── validation/       ← THIS IS AN INTERNAL PACKAGE
│
│
├── mypkg/                      ← ANOTHER PUBLIC PACKAGE  – any packages can import myproject/mypkg/calculator
│   └── calculator/
│       └── calc.go            // package calculator
│
│
├── strings/                    ← ANOTHER PUBLIC PACKAGE – any packages can import myproject/strings
│   ├── reverse.go             // package strings
│   └── uppercase.go           // package strings
│
└── cmd/                        ← ANOTHER PUBLIC PACKAGE
    │
    ├── webapp/                 ← THIS IS A MAIN PACKAGE (will produce an executable on build with main() as entry point)
    │   └── main.go            // package main
    │       ├── main()         // function main()
    │       └── ....           // other identifier 
    │
    └── cli/                    ← THIS IS A MAIN PACKAGE (will produce an executable on build with main() as entry point)
        └── main.go            // package main
            ├── main()         // function main()
            └── ....           // other identifier 
``` 
> any packages can import a `public` package       
## Foder `internal`

```go
// internal package 
package auth

import "fmt"

// exported identifier inside an internal folder - only visible and accessible to packages myproject/... after they imports "myproject/internal/auth".
func Authenticate(user, pass string) bool {
    // calls unexported helper
    return validate(user, pass)
}

// unexported identifier - only visible and usable to files of package myproject/internal/auth/.
func validate(user, pass string) bool {
    // dummy check
    return user == "admin" && pass == "secret"
}

// Exported constant
const MaxAttempts = 3
```

An `internal` directory can appears at different levels:
```
myproject/
├── internal/                 ← only packages under myproject/...     can import myproject/internal/...,     other packages cannot
│   └── auth/
│
└── api/                      ← only packages under myproject/api/... can import myproject/api/internal/..., other packages cannot  
    └── internal/
        └── validation/
```

## Foder `mypkg`


```go
// public package 
package calculator

// exported identifier - visible and accessible to any after they imports "myproject/mypkg/calculator"
func Add(a, b int) int {
    return a + b
}

// unexported identifier - only visible and usable to files of package "myproject/mypkg/calculator"
func subtract(a, b int) int {
    return a - b
}

```

# Operation
- install `GO` (toolchain)
- write (`GO`) source code
- test code
- build artifact(s)

# Todo

- `go build` → builds 
- `go test` → compiles/tests
- `go install` → builds and installs
- `go run` → builds and runs

# Reference




<details>
<summary><h1>Document Metadata</h1></summary>

**Information**

| Property | Value |
|:--|:--|
| **Doc-ID**       | DOC-GO    |
| **Path**         | `ep.md)` |
| **Last Updated** | 2026-10-27         |

**Revision History**

| Date | Version | Author | Summary |
|:--|:--|:--|:--|
| 2026-10-27 | `v0.1` | amar | Initial draft |

</details>
