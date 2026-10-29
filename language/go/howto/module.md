[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: ../whatis/module.md
[module howto go]:  https://golang.org/doc/tutorial/create-module
[package howto]: ../howto/package.md
[project howto]: ../howto/project.md
[go.mod howto]: ../howto/go.mod
[cli go howto]: ../howto/cli.go.md
<div align="center">

# Langage Go - Howto - Module


[↑ Whatis][topic whatis]

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Related topics

| Topic | Location | Kind |
|-|-|-|
| [go module howto reference][module howto go] | external |
| [howto for go CLI][cli go howto] | internal |
| [howto for package][package howto] | internal |
| [howto for file go.mod][go.mod howto] | internal |
| [howto for Project][project howto] | internal |


# Create a module
```sh
# define var
lMODULE_PATH="$HOME/wkspc/godev/go-core"
lMODULE_ID="github.com/abtransitionit/go-core"

# create a folder
mkdir ${lMODULE_PATH}

# create the file go.mod
cd ${lMODULE_PATH}
go mod init ${lMODULE_ID}

```

# Create a main module

# where a module is used
```sh
# define vars
lMODULE_NAME="github.com/aws/aws-sdk-go-v2"

# do
go mod why -m $lMODULE_NAME
```

# delete all module
```sh
#delete all module from the cache
go clean -modcache
```


# download imported module
```sh
# define var
lMODULE_NAME=sigs.k8s.io/controller-runtime
lMODULE_VERSION=v0.20.24

lMODULE_NAME=github.com/user/project
lMODULE_VERSION=""

lMODULE_NAME=github.com/user/project/subpkg
lMODULE_VERSION=""

# get module
go get "${lMODULE_NAME}${lMODULE_VERSION:+@${lMODULE_VERSION}}"
```
- `${VAR:+VALUE}` → Expands to `VALUE` only if VAR is not empty.
- `${VAR:+VALUE}` → Expands to `""`    if VAR empty.
- Modules when donwloaded are stored in folder `$(go env GOCACHE)`

# List available versions of a module
List version in the **remote repository**
```shell
# define var
lMODULE_NAME=github.com/spf13/cobra
lMODULE_NAME=github.com/spf13/cobra-cli
lMODULE_NAME=sigs.k8s.io/controller-runtime

# outside the go project
go list -m -versions $lMODULE_NAME

# output
... v0.20.24
```


# List installed versions of a module
List versions in the **local cache**

```shell
# define var
lMODULE_NAME=github.com/spf13/cobra
lMODULE_NAME=github.com/spf13/cobra-cli

find $(go env GOMODCACHE) -type d -path "*${lMODULE_NAME}@*"
# find $(go env GOMODCACHE) -type d -path "*${lMODULE_NAME}*"
```
- `$(go env GOPATH)`=`$HOME/go`
- `$(go env GOMODCACHE)`=`$(go env GOPATH)/pkg/mod`
- `$(go env GOPATH)/bin` = location for go binary


```shell
# define var
lMODULE_NAME=github.com/spf13/cobra
lCLI_NAME=cobra-cli # cf. folder ~/go/bin

# 
go version -m ~/go/bin/$lCLI_NAME | grep dep | grep $lMODULE_NAME
```
# List dependencies
```shell
go list -m all
```
Meaning: 
- display a list of all dependencies (aka. modules) the GO project needs (ie. direct and indirect dependencies)

# doawnload dependencies
```shell
go mod download
```
Meaning: 
- fetches the source code for **all modules** listed in the `go.mod` file
- places them in your local Go module cache (ie. the folder $(go env GOCACHE)).

# doawnload missing dependencies
```shell
go mod tidy
```
Meaning: 
- looks at new `import` statement in the code (an import, reference a **package of a module**)
- if the module that contains this package is not in the `go.mod`
  - it download the modules and place it in the cache

# doawnload specific dependencies
```shell
go get github.com/spf13/cobra@latest
go get github.com/spf13/cobra@@2.0.0
```
meaning: 
- fetches a compatible version of the module from its repository.
- adds or update the `require` directive to the `go.mod`
- adds the checksums for the module to your `go.sum` 
