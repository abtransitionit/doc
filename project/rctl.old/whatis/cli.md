[//]: #(home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[cli howto]:        ../howto/cli.md
[cli v0.1 whatis]:  ../whatis/cli.v0.1.md
[res list]:         ../list/res.md
[res whatis]:       ../whatis/res.md
[manage howto]:     ../howto/manage.md

[←][home] 

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a resource][res whatis]|internal
|[How-to for cli][cli howto]|see
|[How-to manage][manage howto]|internal
|[cli v0.1][cli v0.1 whatis]|see




<h1 align="center">rctl CLI</h1>



# Definition
- a tool written in **Golang** that build a single binary
- may rely on existing tool. Example
  - to manage container image for a container runtime

# The Model
Every cde should have
- command
- purpose
- arguments
- options
- environment
- side effects
- exit codes
- version
- examples

Example
```
mx repogit reset-history foo
```
should produce
```
WARNING: destructive operation

Input:
    repository name

Purpose:
    removes history of the remote repo

Effect:
    removes the remote history

Requires:
    confirmation unless --force is specified

Exit codes:
    0 success
    1 operational failure
    2 invalid arguments
```
> 🚧 choose between Purpose/Effect or keep both

# The Model
```
                  rctl CLI
                     │
             stable command API
                     │
              resource layer
                     │
        ┌────────────┼────────────┐
        ▼            ▼            ▼
      repo          image      container
        │            │            │
        ▼            ▼            ▼
    providers      engines     runtimes
```

```
repo
 ├── GitHub
 └── GitLab

image
 ├── Docker
 └── Podman/buildkit/etc.

container
 ├── Docker
 └── Podman
```
This means resource semantics stay stable while implementations/providers can evolve.

# The Model
```
                   rctl
                    │
       ┌────────────┼─────────────┐
       │            │             │
      repo       container      image
       │            │             │
       ▼            ▼             ▼
     Git        Docker/Podman   Registry
       │                          │
       ├── GitHub                 ├── GHCR
       └── GitLab                 ├── GitLab Registry
                                  └── ...
````
> 💡 1 resource => N providers
# The Model
```sh
rctl <resource> <action> [name] [options]
rctl <resource> --help
```

# Examples
cf. [List of resource][res list]
```sh
rctl repo git create foo --template go-lib
rctl repo git clone foo
rctl repo git reset-history foo
rctl repo git archive foo
rctl repo git list
rctl repo git info foo
```
> 💡 Underneath, the implementation can still be Go, shell, Python, etc.
```
                  stable interface
                        │
                        ▼
                  ┌───────────┐
                  │    rctl   │
                  └─────┬─────┘
                        │
             ┌──────────┼──────────┐
             ▼          ▼          ▼
          GitHub      GitLab      local git
             │          │          │
             └──────────┼──────────┘
                        ▼
                 implementation
```
Go should own the orchestration and public CLI only.
```
rctl
 ├── Go implementation
 ├── shell implementation
 ├── git commands
 ├── GitHub API
 └── GitLab API                 
``` 
**Example**
```
mx repo create
   └── internal/template/create.go

mx repo reset-history
   └── scripts/reset-history.sh 
```
> 🌟 The CLI becomes the contract, not the implementation language.

> 🌟 The CLI should become the API.

# Example
```sh
rctl repo list
rctl repo info go-tpl-lib
rctl repo clone go-tpl-lib
rctl repo graph
```
# Example
```sh
# the cli
mx repo info foo
```
may return something like:
```yaml
GitRepo:
  GitHub: github.com/abtransitionit/foo
  GitLab: gitlab.com/abtransitionit/foo
  Template: go-service@v2.1.0
CimRepo:
  - ghcr.io/abtransitionit/foo:1.4.0
  - ghcr.io/abtransitionit/foo:latest
ContRepo:
  - foo-dev       running
  - foo-test      stopped
```
# Example
```sh
rctl mx upgarde
```
Meaning:
- Upgrade the tool itself.

# The Implementation
```
type GitProvider interface {
    CreateRepository(...)
    DeleteRepository(...)
    Clone(...)
}

type ContainerRegistryRuntimeProvider interface {
    CreateRepository(...)
    DeleteRepository(...)
    Clone(...)
}

type ContainerRuntime interface {
    Run(...)
    Stop(...)
    Exec(...)
}

type ContainerImageRegistry interface {
    Push(...)
    Pull(...)
    Tags(...)
}
```
allow
```
GitProvider (GitRepositoryProvider) ... too restrictive
 ├── GitHub
 └── GitLab

ContainerRuntime (ContainerProvider)
 ├── Docker
 └── Podman

ImageRegistry (ContainerImageProvider)
 ├── GHCR
 ├── GitLab Registry
 └── Docker Hub
```


# The grammar model
- some cde needs confirmation other don't
```sh
# need confirmation
rctl repo reset-history foo

# bypass confirmation if automation - possible synatx
rctl repo reset-history foo --yes
rctl repo reset-history foo --confirmation no
rctl repo reset-history foo --confirmation yes

# no confirmation needed
rctl repo info foo
```

# The flags
like [action](../whatis/action.md#kind). There should be  
- common flags
- specific flags

**Example of common flag**
```
rctl cim push foo --provider ghcr
rctl cim push foo --provider gitlab

rctl repo get go-tpl-lib --provider gitlab

rctl container start foo --provider docker
rctl container start foo --provider podman
```