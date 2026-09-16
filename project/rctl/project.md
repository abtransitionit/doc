# Build the tool `rctl` <a id='home'></a>
- document a [cde](#cde)
- code the [cli](#code)
- version of the [cli](#version)
- the [resource](#res)
- the yaml [manifest](#manifest)

# [↑](#home) The doc <a id='cde'></a>
every cde should have the following properties defined
```yaml
command:
purpose:
arguments:
options:
environment:
side effects:
exit codes:
version:
examples:
```

**Example**:

```sh
mx repo reset-history --help
```

```yaml
# should ouptut something like
WARNING: destructive operation

Input:
    repository name

Effect:
    replaces remote history with the current working tree

Requires:
    confirmation unless --force is specified

Exit codes:
    0 success
    1 operational failure
    2 invalid arguments
```


# [↑](#home) Version the cli <a id='version'></a>
```
mx v1.0.0
mx v1.1.0
mx v2.0.0
mx v2.7.0

```
# How-to install/upgrade the cli
```sh
# version 1
curl ... | sh
# Better - if go toolchain is installed on host
go install xxxx
```

# [↑](#home) The code of the cli <a id='code'></a>

- Go own the orchestration and public CLI.
- The CLI becomes the contract, not the implementation language.
```
mx
 ├── Go implementation
 ├── shell implementation
 ├── git commands
 ├── GitHub API
 └── GitLab API
```

```sh
# it is ok to call go code
mx repo create
   └── internal/template/create.go

# it is ok to call shell script
mx repo reset-history
   └── scripts/reset-history.sh
```
# [↑](#home) The Resources <a id='res'></a>

a resource has a **kind**

```yaml
# example for kind:repo
repo/git
repo/docker
repo/pkg
```


**Example**
```
mx repo list
mx repo info go-tpl-lib
mx repo clone go-tpl-lib
mx repo graph
```

**Create a git repository from a template**
```sh
# convert this into a cli
alias mx.git.repo.create='curl -fsSL "https://api.github.com/repos/abtransitionit/go-tpl-lib/contents/bin/init.sh?ref=${lVERSION:-v1.0.0}" | jq -r '.content' | base64 -d | cat | sh -s'
```

```sh
# Use version 1.5.0 of the go-tpl-lib template on github to create the local repo git foo
mx repo/git create foo --template github/go-tpl-lib@v1.5.0

# same bur but used the default version
mx repo/git create foo --template github/go-tpl-lib
```

```yaml
# the yaml define the default version for the template
templates:
  go-tpl-lib:
    repository: github.com/abtransitionit/go-tpl-lib
    version:
      default: v1.4.0
```

# doctor
This cde can be used to check the **eco**system
```sh
# example
mx doctor
```

```yaml
# could output
Repository inventory
────────────────────────────
✓ 47 repositories found
✓ 47 documented
✓ 46 GitHub links valid
✓ 45 GitLab links valid
⚠ project-x missing template metadata
⚠ project-y has stale documentation

Templates      version
────────────────────────────
✓ go-tpl-lib   v1.4.0
✓ go-service   v2.1.0
⚠ shell-tool   v0.8.0 → v0.9.0 available
```
# Todo


# The Yaml manifest
a yaml like this one can act as a 
  - repository registry
  

```yaml
name: my-project

hosting:
  github: abtransitionit/my-project
  gitlab: abtransitionit/my-project

template:
  name: go-service
  version: v2.1.0

dependencies:
  - go-tpl-lib
  - common-ci

documentation:
  - architecture
  - deployment
```

mx can

```sh
mx repo/git dependents github/go-tpl-lib
mx repo/git children github/go-service
mx repo/git graph
mx repo/git template update github/go-service
```

# To understand what it means
```

                  ┌─────────────────┐
                  │   mx-toolbox    │
                  │                 │
                  │ stable CLI/API  │
                  └────────┬────────┘
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
      GitHub API       GitLab API       local git
          │                │                │
          └────────────────┼────────────────┘
                           │
                           ▼
                    ┌──────────────┐
                    │ doc registry  │
                    │              │
                    │ repo graph   │
                    │ templates    │
                    │ metadata     │
                    └──────────────┘
                           │
             ┌─────────────┼─────────────┐
             ▼             ▼             ▼
          repo A         repo B        repo C
```          