[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]:  ../whatis/package
[module howto]:    ../howto/module
[build howto]:    ../howto/build
[build package howto]: ../howto/build#build-a-package
[build all howto]:     ../howto/build#build-all-package-of-a-module
[go.mod howto]: ../howto/go.mod.md

<div align="center">

# Langage Go — Howto - Module

[↑ Whatis][topic whatis]

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Related topics

| Topic | Location | Kind |
|-|-|-|
| [howto build][build howto] | internal |
| [howto for module][module howto] | internal |
| [howto build a package][build package howto] | internal |
| [howto build all packages of a module][build all howto] | internal |
| [howto for go.mod][go.mod howto] | internal |

# import a package

```go
// in go.mod
require github.com/spf13/cobra v1.10.1 // uses this version of the module
require golang.org/x/crypto    v0.21.0
require github.com/google/uuid v1.6.0

// In code
import "github.com/spf13/cobra"      // import the package of the same name 
import "golang.org/x/crypto/bcrypt"  // import the package with a different name 
import "github.com/google/uuid"      // import the package of the same name
```


## How it works
- You never import a whole module at once in code; 
- you import **a specific package** of a **versioned existing module**.
- But!! to be able to import a package; this package's module must be present in [go.mod][go.mod howto].






* **In terminal / dependency management:**
```bash
go get github.com/gin-gonic/gin@v1.9.1 // Adding a module version dependency

```


* **Precision point:** A single module can contain multiple packages. When another Go program adds your library as a dependency, it downloads the whole **module**, but its code only `import`s the specific **packages** it needs.

---

### Summary Checklist

| Concept | What it represents | How it's used |
| --- | --- | --- |
| **Package** | A folder of `.go` files working together. | Used in source code: `import "path/to/pkg"` |
| **Module** | A group of packages with a `go.mod` file and a version (e.g. `v1.2.0`). | Used by the Go toolchain (`go.mod`, `go get`) to fetch and version code. |

**Most accurate way to state it:**

> *"Reusable code is packaged as **modules** (for versioning and distribution) and consumed by importing specific **packages** in your Go code."*

# Manage external package
```go
// make a package content accessible to a code
import "github.com/google/uuid"

// use it
id := uuid.New()
fmt.Println("ID:", id)
```

