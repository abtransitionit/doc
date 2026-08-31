[//]: #(home)
[home]: ../whatis/ep.md  

[//]: #(functional)
[roadmap whatis]: ../whatis/roadmap.md
[outcome phase0]: ../list/res.md#phase-0-outcome
[outcome phase1]: ../whatis/arch.md#cli-grammar
[res list]:       ../list/res.md

[←][home]
| Topic | Location | Kind |
|-|-|-|
|[What is the roadmap][roadmap whatis]|see|functional
|[List of resources][res list]|internal|functional


<h1 align="center">rctl Roadmap Progress Log</h1>



# ✅ [Phase 0](./roadmap.md#-phase-0--inventory) <a id='phase-0'></a>
- [Status](#-p0-status)
- [Log](#-p0-log)
- [outcome](#-p0-outcome)

## [↑](#phase-0) 📍 Status
|||
|-|-|
|Progress|90% complete  
|Started|2026-08-26  
|Est. Completion|2026-08-27


## [↑](#phase-0) 📍 log
### 2026-08-26  
- provide git shell scripts to chaGPT 
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

## [↑](#phase-0)📍 Outcome
cf. [outcome of this phase][outcome phase0]


# 🟡 [Phase 1](./roadmap.md#-phase-1--design) <a id='phase-1'></a>
- [Status](#-p1-status)
- [Log](#-p1-log)
- [outcome](#-p1-outcome)
## [↑](#phase-1) 📍 Status
|||
|-|-|
|Progress|10% complete  
|Started|2026-08-26  
|Est. Completion|2026-08-26
|Completion|2026-08-27

## [↑](#phase-1) 📍 Log

### 1.1 The basic grammar

```text
rctl <resource> <action> [name] [options]
rctl <resource> <action> <name> [options...]
```

Examples:

```bash
rctl repo list
rctl repo get foo
rctl repo create foo
rctl repo clone foo
rctl repo reset-history foo
rctl repo create foo

rctl image build foo
rctl image push foo

rctl container start foo
rctl container exec foo

rctl project ...
```

### 1.2 actions classification
We define 2 [kind of actions](../whatis/action.md#kind )

So:

```bash
rctl repo list
rctl repo get foo
rctl repo delete foo

rctl repo reset-history foo

rctl image build foo
rctl image push foo

rctl container start foo
```



## 1.3 One question before going further

For your resources, do you want the **name to be the primary identifier**, as we've been assuming?

For example:

```bash
rctl repo get go-tpl-lib
rctl image get foo
rctl container get foo-dev
```

Or do you want a more explicit resource identifier:

```bash
rctl get repo/go-tpl-lib
rctl get image/foo
rctl get container/foo-dev
```

I'm leaning toward supporting **both eventually**, but I'd like to decide which is the canonical model before we continue.

## Decision #2: semantic of verb (👮‍♂️)
|verb|semantic|
|-|-|
|`list`|returns a collection of resource
|`get`|returns a specific resource
|`info`|is not needed yet

## Decision #3 : arguments and options (👮‍♂️)
- The resource name is positional; everything that modifies how the action is performed is an option.
```sh
# understandable
rctl repo create --template go-tpl-lib foo

# better
rctl repo create foo --template go-tpl-lib
```

- Options should describe (**functiunal**) intent not implementation or provider (ecxeption exists)
- User shouldn't know that today the implementation happens to use `SHELL`, `jq`, `curl`, ...
```sh
❌ 
--github-repo ...
--curl-url ...
--script ...

✅
# git repo
--template go-tpl-lib 

# container image
--tag 1.2.0
--image foo:1.2
```
**Exception**:
```sh
rctl repo create foo --provider github
rctl repo create foo --provider gitlab
```

**cli without name**
```sh
# list all repo
rctl repo list --all

rctl repo list
```

## Decision #3 : configuration, providers, and  backend (👮‍♂️)
- The user should normally operate on a resource without caring which provider implements it.
```sh
# user enter
rctl repo get go-tpl-lib
```
`rctl` should infer
```
go-tpl-lib
    ↓
registry/configuration
    ↓
GitHub / GitLab
```

from [metadata](../whatis/metadata.md). Example of metadata can be
```yaml
repositories:
  go-tpl-lib:
    providers:
      github: abtransitionit/go-tpl-lib
      gitlab: abtransitionit/go-tpl-lib
    default: github
```
Then
```sh
# use the default provider
rctl repo get go-tpl-lib

# use the provider specify by the flag
rctl repo get go-tpl-lib --provider github
```

### Metadata = a registry
- stored in a git repository
- The git repository is discovered via the local conf file
- contains shared, version metadata
- `yaml` files in the SOT repository (i.e. `doc`). that become a registry
- This file contains:
  - repo definitions
  - relationships
  - provider mappings
  - templates
  - documentation
  - shared resource registry
  - metadata

### Configuration
- simple config file in `~/.config/rctl/config.yaml`
- This file contains
  - registry location
  - local preferences
  - credentials
  - defaults:
    - default providers

```yaml
# content of ~/.config/rctl/config.yaml
defaults:
  git_repo_provider: github
  cim_provider: ghcr
  container_provider: docker

registry:
  url: ...
```
Do not put repository metadats in this file. This is the job of the SOT repository/registry (`doc`)

### Credentials
- `rctl` should reuse the existing provider authentication mechanisms wherever possible.
- Do not put same in a txt file. Use what exists
```sh
# For remote git repo
GitHub CLI: gh auth
Git credential manager
OS keychain

# For remote container [image] repo
Docker credential store
GitLab CLI / credentials
```

**Decision for Provider selection**

**Default**:
- inferred from resource metadata/configuration
**Explicit**:
  ```
  --provider <provider>
  ```
**Credentials**:
- delegated to provider/native credential mechanisms

**Local configuration**:
  ```
  ~/.config/rctl/config.yaml
  ```
**Shared resource metadata**:
- doc repository / registry:


## Decision #4 : Resource Identity (👮‍♂️)

### logical identity vs provider identity
- A resource with 1 **logical identity** can have multiple provider (e.g. `github`, `gitlab`) and so multiple **provider identity**

```sh
# logical identity -> repo/go-tpl-lib
rctl repo get go-tpl-lib
```
meaning:
- ✅ Get the **logical** repository `go-tpl-lib`.
- ❌ Get the GitHub repository whose name (on `github`) is `go-tpl-lib`.

[metada]() accessible by `rctl` can be
```
repositories:
  go-tpl-lib:
    providers:
      github:
        repository: abtransitionit/go-tpl-lib
      gitlab:
        repository: abtransitionit/go-tpl-lib
```
- **Logical identity** same as **provider identity**

or
```
repositories:
  my-project:
    providers:
      github:
        repository: abtransitionit/my-project
      gitlab:
        repository: company/tools/my-project
```
- **Logical identity** not same as **provider identity**

### Resource name vs. Resource Identity vs. Resource version
The Resource name of a resource MUST be unique within their resource kind
```sh
# resource name is repo/foo must be uniq 
rctl repo get foo # later → rctl repo/git get foo 

# resource name is cim/foo must be uniq
rctl cim get foo # later → rctl repo/cim get foo


# resource name is container/foo must be uniq
rctl container get foo # later → rctl repo/container get foo
```

**Resource version** is about the version of a resource
- `tag` for a git repo
- foir a cim. example
```sh
# image nginx:1.2.0
rctl image get nginx --tag 1.2.0

# image nginx:latest
rctl image get nginx
```

**Logical Resource identity**:
  ```
  <kind>/<name>
  ```
**Example**:
  ```
  repo/go-tpl-lib
  cim/nginx
  ```
**Provider identity**:
  ```
  stored separately
  ```
**Provider selection**:
- explicit using `--provider <name>`
- inferred by using **default** stored in **metadata** or **configuration**
**Name uniqueness**:
    unique within resource kind

### Decision #6: output
- explicit: JSON
- default: human-readable (maybe a json with conversion for human)
  - JSON becomes the scripting interface of `rctl`.
  - We should therefore treat its schema as an API and avoid casually changing it.
- explicit: JSON
  - Maybe implement it later


Default could be
```sh
# for
rctl repo get go-tpl-lib
```

Output could be
```yaml
Repository: go-tpl-lib

GitHub:
  abtransitionit/go-tpl-lib

GitLab:
  abtransitionit/go-tpl-lib

Template:
  yes

Visibility:
  public
```

JSON could be
```sh
# for
rctl repo get go-tpl-lib --output json
rctl repo get go-tpl-lib --o.     json
```
Output could be
```json
{
  "kind": "repo",
  "name": "go-tpl-lib",
  "providers": {
    "github": "abtransitionit/go-tpl-lib",
    "gitlab": "abtransitionit/go-tpl-lib"
  },
  "template": true,
  "visibility": "public"
}
```

YAML could be
```sh
# for
rctl  --output yaml
rctl  --o      yaml
```

#### Exit code
**contract**
```
0  operation success
1  operation failed
2  invalid command/arguments
```

**Example**
```sh
if rctl repo get foo >/dev/null; then
    echo "exists"
fi
```

#### Errors
**Human mode**
```
Error: repository "foo" not found
```

**Json mode**
```
{
  "error": {
    "code": "not_found",
    "message": "repository \"foo\" not found"
  }
}
```


**default output**:
- human-readable
   ```
   -o, --output:
       human
       json
   ```    
**JSON**:
- stable machine-readable interface

**Exit codes**:
   ```
    0 success
    1 operation failure
    2 usage/argument error
   ``` 

**Errors**:
- human-readable by default
- structured with JSON output
```
             rctl
              │
       ┌──────┴──────┐
       ▼             ▼
     human        automation
       │             │
   pretty text      JSON
```
### Decision #7: registry discovery
**question**: how does `rctl` find the **SOT** registry (e.g. `doc`)?

**response**: The home config file with a default
```yaml
# ~/.config/rctl/config.yaml

registry:
  repo: abtransitionit/doc
  provider: github
```

With this:
```
rctl repo list
```
Meaning:
1. read local config
2. locate SOT repository
3. read registry


**Idea**
- The registry is not mandatory for every operation.
  ```sh
  # might eventually work without the registry.
  rctl repo clone https://github.com/foo/bar.git
  ```
- and
   ```sh
   # requires the registry because go-tpl-lib is a logical name that must be resolved.
   rctl repo get go-tpl-lib
   ```
## [↑](#phase-1) 📍 Outcome
cf. [outcome of this phase][outcome phase1]

# 🟡 [Phase 2](./roadmap.md#-phase-1--design) <a id='phase-2'></a>
- [Status](#-p2-status)
- [Log](#-p2-log)
- [outcome](#-p2-outcome)
## [↑](#phase-1) 📍 Status
|||
|-|-|
|Progress|10% complete  
|Started|2026-08-26  
|Est. Completion|2026-08-26
|Completion|2026-08-27

## [↑](#phase-1) 📍 Log
## [↑](#phase-1) 📍 Outcome
