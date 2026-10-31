[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: ../whatis/envar


<div align="center">

# Langage Go — List of Envars

[↑ Whatis][topic whatis]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# List 



| Variable         | Meaning                                             | Example                                               |
| ---------------- | --------------------------------------------------- | ----------------------------------------------------- |
| `GOOS`           | Target operating system                             | `darwin`                                              |
| `GOARCH`         | Target CPU architecture                             | `arm64`                                               |
| `GOHOSTARCH`     | CPU architecture of the machine running Go          | `arm64`                                               |
| `GOHOSTOS`       | OS of the machine running Go                        | `darwin`                                              |
| `GOROOT`         | Go installation/root directory                      | `/Users/max/wkspc/apps/go`                            |
| `GOPATH`         | Go workspace path                                   | `/Users/max/go`                                       |
| `GOCACHE`        | contains compiled/build results**                   | `/Users/max/Library/Caches/go-build`                  |
| `GOMODCACHE`     | contains downloaded module source                   | `/Users/max/go/pkg/mod`                               |
| `GOMOD`          | Path to the current module's `go.mod`               | `/Users/max/wkspc/git/go-core/go.mod`                 |
| `GOARM64`        | ARM64 architecture level                            | `v8.0`                                                |
| `GOBIN`          | Directory where installed Go executables are placed | `''`                                                  |
| `GOTOOLDIR`      | Directory containing Go's compiler/linker/tools     | `/Users/max/wkspc/apps/go/pkg/tool/darwin_arm64`      |
||
| `AR`             | Archive tool used by the toolchain                  | `ar`                                                  |
||
| `CC`             | C compiler                                          | `clang`                                               |
| `CGO_CFLAGS`     | C compiler flags for cgo                            | `-O2 -g`                                              |
| `CGO_CPPFLAGS`   | C preprocessor flags for cgo                        | `''`                                                  |
| `CGO_CXXFLAGS`   | C++ compiler flags for cgo                          | `-O2 -g`                                              |
| `CGO_ENABLED`    | Whether cgo is enabled                              | `1`                                                   |
| `CGO_FFLAGS`     | Fortran compiler flags for cgo                      | `-O2 -g`                                              |
| `CGO_LDFLAGS`    | Linker flags for cgo                                | `-O2 -g`                                              |
| `CXX`            | C++ compiler                                        | `clang++`                                             |
| `GCCGO`          | Alternative Go compiler                             | `gccgo`                                               |
| `GOGCCFLAGS`     | GCC/Clang flags generated for cgo                   | `-fPIC -arch arm64 ...`                               |
||
| `GO111MODULE`    | Legacy Go module mode setting                       | `''`                                                  |
| `GOAUTH`         | Authentication method for module downloads          | `netrc`                                               |
| `GOCACHEPROG`    | External program used for build caching             | `''`                                                  |
| `GODEBUG`        | Go debug settings                                   | `''`                                                  |
| `GOENV`          | Path to Go's environment configuration file         | `/Users/max/Library/Application Support/go/env`       |
| `GOEXE`          | Executable filename suffix                          | `''`                                                  |
| `GOEXPERIMENT`   | Experimental Go features                            | `''`                                                  |
| `GOFIPS140`      | FIPS 140 mode                                       | `off`                                                 |
| `GOFLAGS`        | Default flags for Go commands                       | `''`                                                  |
| `GOINSECURE`     | Module paths allowed to use insecure connections    | `''`                                                  |
| `GONOPROXY`      | Module paths that bypass the module proxy           | `''`                                                  |
| `GONOSUMDB`      | Module paths that bypass the checksum database      | `''`                                                  |
| `GOPRIVATE`      | Module paths considered private                     | `''`                                                  |
| `GOPROXY`        | Module download proxy/direct source configuration   | `https://proxy.golang.org,direct`                     |
| `GOSUMDB`        | Checksum database used to verify modules            | `sum.golang.org`                                      |
| `GOTELEMETRY`    | Go telemetry mode                                   | `local`                                               |
| `GOTELEMETRYDIR` | Directory containing Go telemetry data              | `/Users/max/Library/Application Support/go/telemetry` |
| `GOTMPDIR`       | Temporary directory used by Go                      | `''`                                                  |
| `GOTOOLCHAIN`    | Go toolchain selection mode                         | `auto`                                                |
| `GOVCS`          | Version-control command policy                      | `''`                                                  |
| `GOVERSION`      | Go version                                          | `go1.26.5`                                            |
| `GOWORK`         | Path to the active `go.work` file                   | `''`                                                  |
| `PKG_CONFIG`     | Tool used to obtain C library build flags           | `pkg-config`                                          |


