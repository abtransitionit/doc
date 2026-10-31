[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ./ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic list]:  ../list/envar.md
[cli go howto]: ../howto/cli.go.md

<div align="center">

# Langage Go - Whatis - envar

[↑ List][topic list]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Howto | [go CLI][cli go howto]| internal |



# Definition
- buil-in environment variables accessible via `go env [VarName]`
# OS target

|system|GOOS|GOARCH|uname -m|
|-|-|-|-|
|apple silicon|darwin|arm64|arm64|
|all linux|linux|amd64|x86_64|


# `GOROOT` vs `GOPATH`
`$GOROOT` and `$GOPATH` does not exist. What exists is
* `$(go env GOROOT)`: Home of `GO` distrib
* `$(go env GOPATH)`: Home of `GO` WKSPC

```go
GOROOT.            ← HOME of GO distrib
└── ~/wkspc/apps/go. ←   (eg. /Users/max/kspc/apps/go oddefault to /usr/local/go)
    ├── bin/       ← Go commands
    ├── src/       ← Go standard library source
    └── pkg/       ← Go installation data


GOPATH.            ← HOME of GO WKSPC
└── ~/go.          ← (default to ~/go)
    ├── bin/       ← executables installed with `go install`
    ├── pkg/       ← caches
    └── ...
```

# `GOCACHE` vs `GOMODCACHE`

cf. [`go get` and `go install`][cli go howto]
