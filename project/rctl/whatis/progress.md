[//]: #(home)
[home]: ../whatis/ep.md  

[//]: #(functional)
[roadmap whatis]: ../whatis/roadmap.md
[outcome phase0]: ../list/res.md#phase-0-outcome
[phase 0]:        #phase-0

[←][home]
|||
|-|-|
|[What is the roadmap][roadmap whatis]|see|


<h1 align="center">rctl Roadmap Progress Log</h1>



# 🟡 [Phase 0](./roadmap.md#-phase-0--inventory) <a id='phase-0'></a>
- [Status](#-p0-status)
- [Log](#-p0-log)
- [outcome](#-p0-outcome)

## [↑][phase 0] 📍 P0 Status
|||
|-|-|
|Progress|90% complete  
|Started|2026-08-26  
|Est. Completion|2026-08-27

  - provide git shell scripts to chaGPT 

## [↑][phase 0] 📍 P0 log
### list the resource types to manage
```yaml
- repo
- image
- container
- cli
```

### Identify existing scripts and tools

| Resource  | Example               | Where it lives  |
| --------- | --------------------- | --------------- |
| repo      | `go-tpl-lib`          | GitHub + GitLab |
| image     | `ghcr.io/foo/bar:1.2` | GHCR            |
| container | `foo-dev`             | Docker          |

**Alaises become**
```yaml
Resource: repo
Action:   create
Input:    template + name
Provider: GitHub
Implementation: remote shell script
```

### Build something like

| Resource  | Action        | Example               | Implementation | Provider      |
| --------- | ------------- | --------------------- | -------------- | ------------- |
| repo      | create        | create from template  | shell          | GitHub        |
| repo      | clone         | clone repo            | git            | GitHub/GitLab |
| repo      | reset-history | remove remote history | shell          | GitHub/GitLab |
| repo      | ...           | ...                   | Go             | ...           |
| image     | build         | ...                   | shell          | Docker        |
| container | run           | ...                   | shell          | Docker        |
| Shell/history | list      | list shell/history    | shell          |               |
| cli/vscode | start        | ...                   | shell          | Docker        |
| cli/vscode | welcome      | ...                   | shell          | Docker        |

Don't decide yet whether something should be called `reset-history`, `history-reset`, or `purge-history`.

### Identify duplicates and variants
```
repo clone
 ├── GitHub version
 ├── GitLab version
 └── local version

 repo create
 ├── Go template
 ├── Shell template
 └── special project template
```

### Identify dangerous operations

This will later influence the rctl UX.
```sh
❗ delete repository
❗ reset history
❗ delete image
❗ remove container
```

For example, we may decide:

```bash
rctl repo reset-history foo
```

requires confirmation, while:

```bash
rctl repo info foo
```

doesn't.


### Identify dependencies

This will later help us decide what `rctl` should abstract away.

```text
repo create
 ├── curl
 ├── jq
 ├── git
 ├── GitHub token
 └── template repository
```

```text
repo clone
 ├── git
 └── SSH credentials
```

### Estimated delivarable
**File 01**
```
RESOURCE: repo

  create
    - template-based
    - GitHub
    - GitLab

  clone
    - GitHub
    - GitLab

  reset-history
    - GitHub
    - GitLab

  delete
    - GitHub
    - GitLab

RESOURCE: image

  build
  tag
  push
  pull

RESOURCE: container

  create
  run
  exec
  stop
  remove
```

**File 02**
```
Providers:
  GitHub
  GitLab
  Git
  Docker
  ...

Common dependencies:
  git
  curl
  jq
  docker
  ...
```

## [↑][phase 0]📍 P0 Outcome
cf. [outcome of this phase][outcome phase0]


