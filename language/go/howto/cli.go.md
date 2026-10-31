[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: ../whatis/cli.go.md
[go whatis]:     ../whatis/go
[module howto]: ../howto/module
[go dl ext]:     https://go.dev/dl/
[cli whatis]: ../whatis/cli.md
[cli list]: ../list/cli
[go howto]: ../howto/go

<div align="center">

# Langage Go — Howto - go CLI

[↑ Whatis][topic whatis]

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [CLI][cli whatis]| internal |
| Howto | [Module][module howto]| internal |
| List | [CLI][cli list]| internal |




# Install on linux
**download the distribution (for your [os/processor][go dl ext])**
```sh
# define vars
lVM="linux-amd64"
lVM="darwin-arm64"
lVERSION_TOOLCHAIN="1.24.2"
lVERSION_TOOLCHAIN="1.26.5"
lDISTRIB_NAME="go${lVERSION_TOOLCHAIN}.${lVM}.tar.gz"
lSRC_PATH="https://go.dev/dl/${lDISTRIB_NAME}"
lDST_PATH="/tmp/${lDISTRIB_NAME}"

# do
curl -L -o $lDST_PATH $lSRC_PATH
```

**untar the file**
```sh
# define vars
lHOME_APPS="$HOME/max/apps"
lHOME_APP="${lHOME_APPS}/go"
lAPP_ARTIFACT="/tmp/${lDISTRIB_NAME}"

# do
rm -rf ${lHOME_APP} && tar -C "${lHOME_APPS}" -xzf "${lAPP_ARTIFACT}"
```


**update `PATH` in rc file**
```sh
# do manually
export PATH=$PATH:${HOME}/max/apps/go/bin
```


**test install**
```sh
go version
```

 

# install a dependency manually
Use case: you want to use a `Go` module in a `Go` project
```go
// in the code: import the needed module
import "github.com/gin-gonic/gin"

// in a shell session: define var
lGO_DEPMOD="github.com/gin-gonic/gin"

// do
go get ${lGO_DEPMOD}
```
meaning
* looks at the **package/module** you asked for.
* downloads, for the **package/module**, the module and its dependencies (if not already in cache).
* updates the project's [`go.mod`][go.mod whatis] (if needed adds/changes the dependencies and its version)
* updates [`go.sum`][go.sum whatis]
* NO executable is normally create
* the code can now import that dependency

# go `build`
# go `run`


# Get Help
```sh
go help 
go help mod
go help mod edit
``` 

# Test code without generating binary
```sh
# without generating binary
go run main.go 
go run main.go kbe
go run main.go kbe init
go run -C /var/tmp/luc main.go
```


# install a go cli
Use case: you need a `Go` program as a command-line executable.
```go
// define var
lGO_CLI="golang.org/x/pkgsite/cmd/pkgsite@latest"
lGO_CLI="golang.org/x/exp/cmd/modgraphviz@latest"

// do
go install ${lGO_CLI}

```
meaning
* downloads the source code ad its dependencies (if not already in the module/download cache.)
* compiles (aka. build) the code into a single binary executable.
* install it in the Go bin directory (`$GOBIN` if set eles `$GOPATH/bin`).

> the current project isn't modified when you install an external tool this way.


# Test a go CLI
- test a `go` CLI from a go project without building it