[//]: #(Home)
[HOME]:  ../whatis/ep.md

[//]: #(functional)
[cli howto]:        ../howto/cli.md
[res list]:         ../list/res.md
[res whatis]:       ../whatis/res.md
[host concept]:     ../list/concept.md#
[rctl whatis]:      ../whatis/ep.md
[provision whatis]: ../whatis/provision.md
[resource list]:    ../list/res.md
[manage howto]:     ../howto/manage.md

[←][HOME] 

Related topics
|||
|-|-|
|[what is rctl][rctl whatis]|internal|
|[what is a resource][res whatis]|internal
|[howto for cli][cli howto]|see
|[howto manage][manage howto]|internal




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
```

# Examples
cf. [list of resource][res list]
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
                  │    mx     │
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

# Example
