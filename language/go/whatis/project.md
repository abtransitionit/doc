[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]: ../howto/project.md
[package howto]: ../howto/package.md

<div align="center">

# Langage Go - Whatis - Project

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Topic | Location | Kind |
|-|-|-|
| [howto for Package][package howto] | internal |


# Definition


# Kind
- [Executable](#executables)
- [Library](#library)

## Executable

- Projects that output one or more **Executable binary**
- They contain a `package main` and a `main()` function, which acts as the entry point of the program.
- They are built running `go build` that compiles the code into an executable binary
- Used as programs designed to be invoke directly by an agent.
- **Common Examples:**
    - CLIs like `kubectl`, `hugo`, `aws`, web servers, microservices, and system daemons.

## Library
- Projects that are collections of reusable code
- They do not contain a `package main` or a `main()` function
- They only contains Packages named after their directory/functionality (e.g., `utils`, `client`).
- Reusable code is meant to be imported and used by *other* Go programs.
- * **How it's built:** They cannot be run directly. Instead, they are published as modules (e.g., on GitHub) so other developers can run `go get` to import them into their own projects.
* **Common Examples:** SDKs, database drivers, utility packages, and open-source helper libraries.


# Key points
- Once a library project is push to a Git repository; the [go CLI][cli ] alows to manage it automatically 

---


### Pro-Tip: The Hybrid Approach

In real-world Go development, it is also very common to see a **hybrid structure** within a single repository (following the standard [Go Project Layout](https://github.com/golang-standards/project-layout)).

A single project repository might contain:

* A core **library** in the root directory (so others can import it).
* A `cmd/` directory containing one or more subfolders with `package main`, which compile into **binaries** (like a CLI client for that library).