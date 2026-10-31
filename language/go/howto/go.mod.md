[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: ../whatis/go.mod
[module howto]: ../howto/module

<div align="center">

# Langage Go - Howto - go.mod

[↑ Whatis][topic whatis]

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Howto | [Module][module howto]| internal |



# create the file `go.mod`
```go
go mod init example/hello
```

# update `go.mod`
```sh
# add missing dependencies
go mod tidy
```
