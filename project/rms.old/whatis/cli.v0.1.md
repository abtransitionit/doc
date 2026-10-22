[//]: #(home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[cli whatis]: ../whatis/cli.md

[←][home] 

Related topics

| Topic | Location | Kind |
|-|-|-|
|[whatis cli][cli whatis]|see|



<h1 align="center">rctl CLI v0.1</h1>



# Definition
## Purpose
- Define what is implemented in this version
- Replace the most useful repository-related aliases/scripts with one coherent, versioned CLI.

# Requirements

- The user can run a single command, pass required inputs, and receive a successful output

```
rctl v0.1
│
├── core CLI
├── configuration
├── registry
└── repo
    ├── list
    ├── get
    ├── create
    ├── delete
    ├── clone
    └── reset-history
```

- One resource only (git repository)
- available cde
```sh 
rctl repo list
rctl repo get <name>

rctl repo create <name>
rctl repo clone <name>

rctl repo delete <name>
rctl repo reset-history <name> 
``` 

## cde description

# Flags
- Also called options
```shell
--provider <name>
--output, -o <format>
--yes
--template  <name>
--directory <path>
```
### `list`
```sh 
rctl repo list
```
Maening:
- ✅ List logical repositories known to the registry.
- ❌ List all repositories returned by `GitHub/GitLab`.

### `get`
```sh 
rctl repo get go-tpl-lib
```
Maening:
- ✅ Resolve the logical repository and show its metadata.

Example output:
```yaml
Repository: go-tpl-lib

GitHub: abtransitionit/go-tpl-lib
GitLab:  abtransitionit/go-tpl-lib

Template: true
```

### `create`
```sh 
rctl repo create my-new-repo --template go-tpl-lib
```
Maening:
- clone a templated repository and do replace placeholders

### `clone`
```sh 
# in the current folder
rctl repo clone go-tpl-lib

# in a specific folder
rctl repo clone go-tpl-lib --directory <path>
```
Maening:
- clone the templated repository


### `delete`
```sh 
# interactive confirmation required
rctl repo delete go-tpl-lib

# batch delete
rctl repo delete go-tpl-lib --yes
```
Maening:
- clone the templated repository

### `reset-history`
```sh
rctl repo reset-history go-tpl-lib
```
Maening:
- delete remote repo:history (.git) 


## implementated

```
rctl repo create → call → existing init.sh
```

```
rctl repo reset-history → new Go workflow
```

```
                   rctl
                    │
                 repo
                    │
       ┌────────────┼────────────┐
       ▼            ▼            ▼
     create       clone       reset-history
       │            │            │
    script        git         Go workflow
```

## Not implemented
- other resource 
- the non canonical form (e.g. `rctl get repo/foo`)

## Milestone
- **M1**: I can remove all my repository-related `mx.git.repo.*` aliases and use `rctl repo ...` instead.
- I can actually use those commands in my normal workflow.
```sh
rctl repo list
rctl repo get foo
rctl repo create bar
rctl repo clone bar
rctl repo reset-history bar
rctl repo delete bar
```

# Architecture

**Goal**: create enough structure/code that adding `image` and `container` later is natural.

## 1. The core idea

```text
CLI
 │
 ├── resource: repo
 │      │
 │      └── repo operations
 │
 └── infrastructure
        ├── config
        ├── registry
        ├── output
        └── providers
```

Conceptually:

```text
rctl
│
├── cmd
│    ├── repo
│    └── ...
│
├── resource
│    └── repo
│
├── registry
├── config
├── output
└── provider
```


# 2. Don't start with this

I don't want us to build:

```go
type Resource interface {
    Get()
    List()
    Create()
    Delete()
    Update()
}
```

and then:

```go
type RepoResource struct {...}
type ImageResource struct {...}
type ContainerResource struct {...}
```

This looks elegant, but it's premature.

Why?

Because:

```text
repo
image
container
```

don't necessarily have the same lifecycle.

We've already established that.

Forcing them into CRUD would make the abstraction worse.

---

# 3. Instead: resource-specific packages

Start with:

```text
internal/
├── repo/
├── config/
├── registry/
├── provider/
└── output/
```

`repo` owns repository semantics.

For example, conceptually:

```go
repo.Get(...)
repo.List(...)
repo.Create(...)
repo.Clone(...)
repo.Delete(...)
repo.ResetHistory(...)
```

Then later:

```text
internal/
├── repo/
├── image/
├── container/
├── config/
├── registry/
├── provider/
└── output/
```

Adding `image` doesn't require modifying `repo`.

That's enough abstraction for now.

---

# 4. Where the commonality belongs

The commonality should initially be in **infrastructure**, not in resource semantics.

For example:

```text
repo
 │
 ├── uses config
 ├── uses registry
 ├── uses provider
 └── uses output
```

Later:

```text
image
 │
 ├── uses config
 ├── uses registry
 └── uses provider

container
 │
 ├── uses config
 ├── uses registry
 └── uses provider
```

So the architecture becomes:

```text
             rctl
              │
      ┌───────┼────────┐
      ▼       ▼        ▼
     repo    image   container
      │       │        │
      └───────┼────────┘
              │
       shared infrastructure
       ├── config
       ├── registry
       ├── provider
       └── output
```

That's enough.

---

# 5. Provider abstraction

This is the one abstraction I think is worth defining early.

Because we already know you have:

```text
GitHub
GitLab
```

and potentially:

```text
Docker
Podman
GHCR
GitLab registry
```

later.

But again, **don't create one giant provider interface**.

Not:

```go
type Provider interface {
    RepoCreate()
    RepoDelete()
    ImageBuild()
    ImagePush()
    ContainerRun()
    ...
}
```

That's exactly the kind of abstraction that becomes painful.

Instead, provider capabilities are resource-specific.

Conceptually:

```text
repo
 └── RepoProvider

image
 └── ImageProvider

container
 └── ContainerProvider
```

For v0.1:

```text
RepoProvider
 ├── GitHub
 └── GitLab
```

Later:

```text
ImageProvider
 ├── GHCR
 └── GitLab Registry

ContainerProvider
 ├── Docker
 └── Podman
```

This matches your observation from earlier:

> They're all resources with names and resource-specific actions.

Exactly.

The **resource abstraction is at the CLI/domain level**.

The **provider abstraction is at the implementation level**.

---

# 6. Registry

The registry should also have a very small API.

Conceptually:

```go
registry.GetRepo(name)
registry.ListRepos()
```

That's it for v0.1.

The registry implementation knows whether the data comes from:

```text
doc repository
YAML
JSON
Git
local cache
```

The `repo` package shouldn't care.

---

# 7. The resulting dependency direction

This is the important part:

```text
cmd
 │
 ▼
repo
 │
 ├────► registry
 ├────► provider
 ├────► config
 └────► output
```

Not:

```text
registry → repo
provider → repo
repo → cmd
```

The direction should remain toward the lower-level infrastructure.

---

# 8. Proposed initial tree

I'd start roughly here:

```text
rctl/
├── cmd/
│   └── rctl/
│       └── main.go
│
├── internal/
│   ├── repo/
│   │   ├── repo.go
│   │   ├── create.go
│   │   ├── clone.go
│   │   ├── delete.go
│   │   └── reset_history.go
│   │
│   ├── registry/
│   ├── provider/
│   │   ├── github/
│   │   └── gitlab/
│   │
│   ├── config/
│   └── output/
│
├── go.mod
└── README.md
```

But even this is provisional.

For example, if `create.go` is only 20 lines, we don't need to split it immediately.

**Don't optimize the directory tree before the code exists.**

---

# 9. One more important boundary

The CLI layer should not contain GitHub/GitLab logic.

Bad:

```text
cmd/repo/create
    ├── call GitHub API
    ├── parse JSON
    ├── execute init.sh
    └── print result
```

Instead:

```text
cmd
 ↓
repo.Create()
 ↓
RepoProvider
 ↓
GitHub
```

So the command becomes mostly:

```text
parse arguments
       ↓
call domain operation
       ↓
format result
```

This makes the CLI stable even if the implementation changes.

---

# 10. What we are deliberately NOT designing

At this point, I would stop.

We don't need to define:

* plugin architecture
* dependency injection framework
* event system
* generic resource interface
* generic provider registry
* database
* REST API
* concurrency model
* reconciliation
* graph engine

Those are all potential future solutions to problems we don't have yet.

---

## Architecture milestone

I think we can now state the v0.1 architecture in one sentence:

> **`rctl` has resource-specific domain packages, shared infrastructure for configuration/registry/output, and resource-specific provider implementations.**

And the future evolution is straightforward:

```text
v0.1

repo ──────► GitHub/GitLab


v0.2

repo ──────► GitHub/GitLab
image ─────► GHCR/...
container ─► Docker/...


v0.x

       ┌── repo
rctl ──┼── image
       └── container
              │
        shared infrastructure
```

**Next, I'd make one concrete decision before coding: the actual repository data model.**

In other words, what information does `rctl` need to know about `repo/go-tpl-lib`? That's where your existing `doc` repository becomes important.
