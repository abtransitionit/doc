[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic howto]: ../howto/cli.go.md
[cli list]:  ../list/cli.md

<div align="center">

# Langage Go - Whatis - go CLI

[↑ Howto][topic howto]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Related topics

| Topic | Location | Kind |
|-|-|-|
| [howto for go cli][cli go howto] | internal |
| [list of cli][cli list] | internal |


# Definition
- a single binary executable
- supplied with the tool chain 
- manage go Projects

# `go get`

1. **Fetches the source code** of the requested module and stores it locally in your module cache (`GOMODCACHE`).
2. **Updates your `go.mod` file** (adding or updating the `require` entry with the version you requested).
3. **Updates your `go.sum` file** (recording cryptographic hashes to ensure the downloaded code hasn't been tampered with).

**What `go get` does NOT do**:

* It **does not compile** your code.
* It **does not build** any binaries.
* It **does not install** executables (that's `go install`).

# `go install`

Woks only with module containing a `main()` function

1. **Resolves and fetches** the module source code into your module cache (`GOMODCACHE`) if it isn't already there.
2. **Compiles** the target source code (which *must* contain `package main` and a `main()` function).
3. **Links** the compiled code into a standalone binary executable.
4. **Places the binary** directly into your **`GOBIN`** directory (which defaults to `~/go/bin`).

**What `go install` does NOT do**:

* It does **not** modify your current project's `go.mod` or `go.sum` files (unlike `go get`).
* It does **not** drop the binary into your current working directory (unlike `go build`, which puts it right where you are standing; `go install` sends it away to `~/go/bin`).


# `go build`

1. **Resolves and checks dependencies:** It verifies that all required modules are present in your module cache (`GOMODCACHE`) based on your `go.mod` file.
2. **Compiles** your source code and dependencies (leveraging `GOCACHE` for fast incremental builds).
3. **Links** the compiled code into a standalone binary executable (assuming your package has `package main` and `main()`).
4. **Places the binary right in your current working directory** (wherever your terminal is currently pointing, or a custom path if you use the `-o` flag).

**What `go build` does NOT do**

* It does **not** install the binary into `~/go/bin` (that's `go install`).
* It does **not** modify your `go.mod` or `go.sum` files (that's `go get` or `go mod tidy`).


# `go run`

`go run .` or `go run main.go` Woks only with module containing a `package main` and a `func main()`

1. **Resolves dependencies:** Checks your `go.mod` and pulls anything missing from `GOMODCACHE`.
1. **Compiles temporarily:** Compiles your code into a **temporary binary** and stores it in `GOCACHE` (build cache)
1. **Executes and cleans up:** It runs the program immediately, and once your program stops or exits, **it deletes the temporary binary**.

