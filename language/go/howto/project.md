[//]: #(home)
[home domain]: ../../README.md
[home doc]:    ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Go][home topic] · [↖ Language][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[topic whatis]: ../whatis/project.md
[module howto]: ../howto/module.md
[go.mod howto]: ../howto/go.mod.md
[cli go howto]: ../howto/cli.go.md

<div align="center">

# Langage Go — Howto - Project

[↑ Whatis][topic whatis]

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Related topics

| Kind | Topic | Location |
|-|-|-|
| Howto | [Module][ module howto] . [go.mod][go.mod howto] . [go CLI][cli go howto]| internal |




# Index <a id='index'></a>

1. [Single Executable Project](#create-a-single-executable-project)
1. [Library Project](#create-a-library-project) (reusable code module)
1. [Multi-Executable Project](#create-a-multi-executable-project-the-standard-layout) (multiple binaries in one repo using the standard `cmd/` layout)


# Create a Single Executable Project

[index](#index)

*This creates a project that builds/compiles into one standalone binary.*

```sh
# define variables
lMY_GITHUB="github.com/abtransitionit"
lPRJ_NAME="go-rms"
lPRJ_URI=${lMY_GITHUB}/${lPRJ_NAME}
lPRJ_FOLDER="${HOME}/wkspc/tmp/${lPRJ_NAME}"
lOUT_CUSTOM="/tmp/rms"
lOUT_DEFAULT="${lPRJ_FOLDER}/${lPRJ_NAME}"

# create project folder
mkdir -p "${lPRJ_FOLDER}"

# Initialize module
(cd "$lPRJ_FOLDER" && go mod init "${lPRJ_URI}")

# generate main.go
cat << 'EOF' > "${lPRJ_FOLDER}/main.go"
package main

import "fmt"

func main() {
    fmt.Println("Running kbe-controler-nsconf executable...")
}
EOF

# buil exe
## Default build - outputs the binary named ${lOUT_DEFAULT}
(cd "$lPRJ_FOLDER" && go build)

## Custom build - outputs the binary named ${lOUT_CUSTOM}
(cd "$lPRJ_FOLDER" && go build -o ${lOUT_CUSTOM} .)

## delete output artifact
rm -rf ${lOUT_DEFAULT}
rm -rf ${lOUT_CUSTOM}

```


# Create a Library Project

[index](#index)

*This creates a reusable module with no `main()` function, meant to be imported by other programs. with a package at is root*

```sh
# define variables
lMY_GITHUB="github.com/abtransitionit"
lPRJ_NAME="go-lib"
lPRJ_URI=${lMY_GITHUB}/${lPRJ_NAME}
lPRJ_FOLDER="${HOME}/wkspc/tmp/${lPRJ_NAME}"
lOUT_CUSTOM="/tmp/${lPRJ_NAME}"
lOUT_DEFAULT="${lPRJ_FOLDER}/${lPRJ_NAME}"

# create project folder
mkdir -p "${lPRJ_FOLDER}"

# Initialize module
(cd "$lPRJ_FOLDER" && go mod init "${lPRJ_URI}")

# generate package file math.go
cat << 'EOF' > "${lPRJ_FOLDER}/math.go"
package mathlib

// Add returns the sum of two integers.
func Add(a, b int) int {
    return a + b
}
EOF

# buil exe <=> Library cannot be compiled/built
## check syntax only and/or test
go vet  ./...
go test ./... # if any available

# use it in a project
replace in go.mod

```



# Create a Multi-Executable Project (The Standard Layout)

[index](#index)


*Real-world Go repositories often manage **multiple binaries** (like a CLI client and a background daemon) inside a single module by using a `cmd/` directory.*

```sh
# Define variables
lMY_GITHUB="github.com/abelgacem"
lPRJ_NAME="my-toolkit"
lPRJ_FOLDER="/tmp/${lPRJ_NAME}"
lPRJ_URI=${lMY_GITHUB}/${lPRJ_NAME}
lSRC_CLIENT="cmd/tool-cli"
lSRC_SERVER="cmd/tool-server"
lOUT_CLIENT="/tmp/tool-cli"
lOUT_SERVER="/tmp/tool-server"
lOUT_SERVER

# create project folders
mkdir -p "${lPRJ_FOLDER}/cmd/tool-cli"
mkdir -p "${lPRJ_FOLDER}/cmd/tool-server"


# Initialize the project
(cd "$lPRJ_FOLDER" && go mod init "${lPRJ_URI}")

# Create Entry Point 1
cat << 'EOF' > cmd/tool-cli/main.go
package main

import "fmt"

func main() {
    fmt.Println("Executing Tool CLI...")
}
EOF

# Create Entry Point 2
cat << 'EOF' > cmd/tool-server/main.go
package main

import "fmt"

func main() {
    fmt.Println("Starting Tool Server on port 8080...")
}
EOF

# build must mandatory be explicit because there are multiple main packagesfolders.
( cd "$lPRJ_FOLDER" && go build -o ${lOUT_CLIENT} ./${lSRC_CLIENT} )
( cd "$lPRJ_FOLDER" && go build -o ${lOUT_SERVER} ./${lSRC_SERVER} )

# Test running them:
${lOUT_CLIENT}
${lOUT_SERVER}

# Clean up
rm -rf ${lOUT_CLIENT}
rm -rf ${lOUT_SERVER}

```


# Use a local Module in another project
```sh
# define variables
lMODULE_URI="github.com/abtransitionit/go-lib"


# tag it locally
git tag ${lMODULE_VERSION}

# push it to git
git push origin ${lMODULE_VERSION}

# Use it 
package ${lMODULE_URI}


# solve the dependency
( cd /path/to/other-project && go mod tidy) 

```

