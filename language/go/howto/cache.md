[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md


[↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]:   ../whatis/cache.md


<div align="center">

# Langage Go — Howto - Cache

[↑ Whatis][topic whatis]


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Clean the Build Cache
```sh
go env GOMODCACHE
go env GOCACHE
go clean -cache -modcache

// run from worspace - with no cache
go run -a ./go-tutorial/cmd/tuto

// vet/test from worspace
go -C ./go-tutorial vet  ./...
go -C ./go-tutorial test ./...

// build from worspace
go -C ./go-tutorial build -o ./bin/tuto ./cmd/tuto
```

