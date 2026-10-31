[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: ../whatis/build
[package whatis]: ../whatis/build


<div align="center">

# Langage Go — Howto - Build

[↑ Whatis][topic whatis]

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Related topics

| Kind | Topic | Location |
|-|-|-|
| Whatis | [Package][package whatis]| internal |


# build
## build a package
```sh
## for a specific platform
GOOS="linux" GOARCH="amd64" go build

## for the current platform
go build
```

## build all packages of a module
```sh
# for a specific platform
GOOS="linux" GOARCH="amd64“ go build ./...

# for the current platform
go build ./...
```

# Build a cli from a github source repository
- define the vars about the CLI to build
```sh
# example
lAPP_NAME="sonobuoy"
lCODE_SRC_FOLDER="/tmp/git/${lAPP_NAME}"
lEXE_DST_FOLDER="/tmp"
lTAG="v0.57.3"
lURL="https://github.com/vmware-tanzu/sonobuoy.git"

# example
lAPP_NAME="helm"
lCODE_SRC_FOLDER="/tmp/git/${lAPP_NAME}"
lEXE_DST_FOLDER="/tmp"
lTAG="v3.17.3"
lURL="https://github.com/helm/helm.git"
```

- clone a specific tag not to push/pull only for build purpose
```sh
# CLI
# TODO : rewrite the cli 
git clone --branch $lTAG -C  --depth 1 $lURL
```

- Build the exe from source
```sh
# example : for linux/amd64
lOS_TYPE=linux
lOS_ARCH=amd64

# example : for mac/arm64
lOS_TYPE=darwin
lOS_ARCH=arm64

# Buil the exe
cd $lCODE_SRC_FOLDER
GOOS=$lOS_TYPE GOARCH=$lOS_ARCH go build -o ${lEXE_DST_FOLDER}/${lAPP_NAME}-${lOS_TYPE}-${lOS_ARCH}
```


# Use case: build LUC
This use case is an example workflow to build a go CLI from source for 2 platforms: 
- `darwin/arm64` (mac) 
- `linux/amd64` (rhel, debian, ...)
## define vars

```powershell
# source code conf
lAPP_NAME="lucg"
lTAG="v0.0.1"
lURL="https://github.com/abtransitionit/lucg.git"
lCODE_SRC_FOLDER="/tmp/git/${lAPP_NAME}"

# exe code conf
lEXE_DST_FOLDER="/tmp"
```

## The steps
- Get the source code
```sh
# TODO : rewrite the cli 
git clone --branch $lTAG -C xxx --depth 1 $lURL
```
- Enter the source code local repository
```sh
cd ${lCODE_SRC_FOLDER}
```
- Delete previous build
```sh
rm -rf /tmp/${lAPP_NAME}.* > /dev/null
```
- Build for current platform
```sh
GOOS=$(go env GOOS) GOARCH=$(go env GOARCH) go build -o ${lEXE_DST_FOLDER}/${lAPP_NAME}
```
- Build for another platform
```sh
GOOS=linux GOARCH=amd64 go build -o ${lEXE_DST_FOLDER}/${lAPP_NAME}-${GOOS}-${GOARCH}
```
- Tips : push the CLI to a linux vm
```sh
lVM_NAME=o1u # conf in ~/.ssh/config and ~/.ssh/config.d/ovhvm
scp ${lAPP_NAME}-${GOOS}-${GOARCH} ${VM_NAME}:/tmp/${lAPP_NAME}
```

- Tips : an alias to run it all at once
```sh
# TODO : rewrite the code
alias gob='cd ${SRC_FOLDER} && rm -rf ${OUT_EXES}  &> /dev/null &&  go build -o ${MAC_OUT_EXE} && sudo mv ${MAC_OUT_EXE} ${MAC_DST_FILEPATH} && GOOS=$LINUX_OS GOARCH=$LINUX_ARCH go build -o ${LINUX_OUT_EXE} && cd -'
```

# Todo

## check syntax
```shell
cd folder
# ... = recursively
go vet ./...
```


## build the library
```shell
cd folder
# ... = recursively
go build ./...
```


## to know
- no `main()` no `CLI`. code is build into `go env GOCACHE`

## Use case
```
├── my-projects/
│   ├── gocore/
│   ├── golinux/
│   └── gotask/
```

### Checks all Go packages for compilation errors
go build ./...

### Runs vet on all packages to find potential bugs
go vet ./...