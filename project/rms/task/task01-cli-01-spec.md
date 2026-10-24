
[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./ep.md

[↖ Task CLI][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[blue whatis]: /project/blueprj/whatis/ep.md
[agent whatis]: ../whatis/pp1.term.md#agent
[cli howto]: /concept/tool/howto/ep.md#design-the-grammar-of-a-cli
[repo whatis]: /concept/repository/whatis/ep.md

<div align="center">

# Project RMS — Task - CLI - Specification

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

Follows the [How-to: Design the Grammar of a CLI][cli howto] to find how the best grammar for the CLI.

# Execution Syntax

```sh
rms [command] [subcommand] [global flags] [args...]
```

The system is able to operate directly on resource

**Global Flags**

| Flag | Short | Type | Default | Description |
| --- | --- | --- | --- | --- |
| `--config` | `-c` | `string` | `~/.rctl/inventory.yaml` | Path to inventory configuration file (YAML/JSON/TOML)|
| `--json` | `-j` | `bool` | `false` | Output structured JSON instead of human-readable text |
| `--verbose` | `-v` | `bool` | `false` | Enable debug logging output to stderr |

**Global Exit Code**

| Exit Code | Classification | Cause / Description |
| --- | --- | --- |
| **0** | **Success** | All targets executed successfully with exit code 0 |
| **1** | **Execution Failure** | One or more commands returned a non-zero exit code |
| **2** | **CLI Argument Error** | Invalid flags, missing required arguments, or mutually exclusive flag violation |
| **3** | **Configuration Error** | Inventory file not found, unparseable or schema violation |
| **4** | **Transport Error** | host unreachable, SSH connection refused, authentication failure  |

## `rctl exec`

Executes ad-hoc `shell` commands across target environments.

```bash
rctl exec [target flags] [execution flags] -- <command_string>

```

**Flags**

| Flag | Short | Type | Description |
| --- | --- | --- | --- |
| `--host` | `-h` | `string` | Target a specific host by name |
| `--group` | `-g` | `string` | Target all hosts matching a group tag |
| `--all` | `-a` | `bool` | Target all hosts in the inventory |
| `--timeout` | `-t` | `duration` | Command execution timeout (e.g., `30s`, `5m`) |
| `--concurrency` | `-C` | `int` | Maximum parallel SSH connections (default: `10`) |

**Notes**
- Rules: `--host`, `--group`, `--all` are mutually exclusive.
    - 🚧 instead support `--host <group|single|all|local>`
- Rules: hosts are defined in an inventory.
    - Ideas: hosts are defined in an inventory.

**Usage Examples**

```bash
```sh
# Execute commands on a single target host - DEFAULT output
rctl exec --host web01 -- "uptime;ls -ial"

# Execute a single command on a set of host - JSON output
rctl exec --json --group prod -- "systemctl status nginx"

# Execute a single command - DEFAULT (host, output)
rctl exec -- "whoami"
rctl exec --host local -- "whoami"

```



## `rctl inventory`

Inspects and validates inventory configurations.

```bash
rctl inventory [subcommand] [flags]

```

**Subcommands**

| Subcommand | Description |
| --- | --- |
| `list` | Print active hosts and groups |
| `validate` | Perform schema and connectivity sanity checks on the inventory file |

**Usage Examples**

```bash
# List all hosts - DEFAULT output
rctl inventory list

# List all hosts - JSON output
rctl inventory list --json

# Validate inventory file syntax
rctl inventory validate --config ./specs/inventory.yaml
```

# Resource Management Syntax

```sh
rms <resource kind>:<resource adress> [global flags] [args...] [host]
```

# Examples

**Local target**

| Field | Value |
| ----- | ----- |
| Kind | `service/linux` |
| Address | `sshd` |
| Target | `local` |
| Provider | `tool` |

> RMS manages the service through a local (system) `tool`.

| Field | Value |
| ----- | ----- |
| Kind | `file/file` |
| Address | `/etc/hosts` |
| Target | `local` |
| Provider | `fs` |

> RMS accesses the file through local `filesystem` operations.

| Field | Value |
| ----- | ----- |
| Kind | `os/kernel/module` |
| Address | `br_netfilter` |
| Target | `local` |
| Provider | `tool` |

| Field | Value |
| ----- | ----- |
| Kind | `os/kernel/module` |
| Address | `br_netfilter` |
| Target | `local` |
| Provider | `fs` |

| Field | Value |
| ----- | ----- |
| Kind | `repo/git` |
| Address | `/home/workspace/my-app` |
| Target | `local` |
| Provider | `git` |



**Remote Target via SSH**

> RMS uses `SSH` to reach the target

| Field | Value |
| ----- | ----- |
| Kind | `service/linux` |
| Address | `sshd` |
| Target | `o1u` |
| Provider | `tool` / `tool+ssh` |

 > RMS manages the service through a local (system) `tool`

| Field | Value |
| ----- | ----- |
| Kind | `file/folder` |
| Address | `/home/mx/workspace/` |
| Target | `o1u` |
| Provider | `fs` |

> RMS accesses the folder through `filesystem` operations.

| Field | Value |
| ----- | ----- |
| Resource | `os/kernel/module` |
| Address | `br_netfilter` |
| Target | `o1u` |
| Provider | `fs` |



**Remote Target via HTTP**

| Field | Value |
| ----- | ----- |
| Resource | `file/file` |
| Address | `/etc/hosts` |
| Target | `https://ip` |
| Provider | `http` |

| Field | Value |
| ----- | ----- |
| Resource | `repo/git` |
| Address | `my-org/my-app` |
| Target | `github`(`https://ip`) |
| Provider | `http` |

**To Classify**

> **HOW** RMS reach the target ?
> **HOW** RMS reach the target ?

| Field | Value |
| ----- | ----- |
| Kind | `file/file` |
| Address | `/config/app.yaml` |
| Target | `aws-prod` (conf) | `my-bucket` ()|
| Provider | `s3` |

> **TODO** — `aws-prod` supplies the execution context (credentials, connection settings).
> **TODO** — The bucket does not need to be the target itself.




## Examples summary

| Kind | Address | Target | Provider(s) |
| ---- | ------- | ------ | ----------- |
| `service/linux` | `sshd` | `local` | `tool` |
| `service/linux` | `sshd` | remote VM (SSH) | `tool`, `tool+ssh` |
| `file/file` | `/etc/hosts` | `local` | `fs` |
| `file/file` | `/etc/hosts` | `https://ip` | `http` |
| `file/file` | `my-bucket/config/app.yaml` | `aws-prod` (conf) | `s3` |
| `file/folder` | `/home/mx/workspace/` | `o1u` | `ssh+fs` |
| `os/kernel/module` | `br_netfilter` | `local` | `tool` |
| `os/kernel/module` | `br_netfilter` | `local` | `fs` |
| `os/kernel/module` | `br_netfilter` | `o1u` | `ssh+fs` |
| `repo/git` | `my-org/my-app` | `local` | `git` |



## managed resources

`rms` should manage [repositories][repo whatis] resource kind:

- `repo/git`
- `repo/container/image` (container images)
- `repo/pkg/os` (dnf, apt, npm, …)

`rms` should manage the following resource kind:

- Vm, container, cluster, infra 
- Os
- Linux/Kernel/Module, - Linux/Kernel/Parameter
- Linux/Service
- File, Folder
- Package/Os, Package/Go


## Cross-resource verbs

Generic verbs that should apply to resource kind `repository`

| Verb | Apply to| Meaning | 
|---|---|---|
| `get/inspect` | all | get the resource state/properties|
| `list` | repo | List items inside a repo |
| `add` | repo| Insert an item into a repository |

### Resource-specific verbs

Verbs that should apply to, only, some specific resource `kind`

| Resource | Verbs |
|---|---|
| `repo/git`, `repo/image/container` | `push`, `commit`, `pull` |
| `repo/git`| `branch`, `reset-history` |
| `repo/pkg/os` | `upgarde`, `update` |
| `pkg/os` | `add`, `install` |
| `repo/image/container` | `instanciate` |
| `os` | `upgrade`, `update` |
| `kernel/module` | `load` |
| `kernel/parameter` | `set` |
| `file` | `read`, `write` |


# Stress-Test against supported resource kind

**Syntax**

```sh
rms [command] [subcommand] [global flags] [args...]
```

## repository operation
```bash
# Resource-level generic operations
rms repo/image/container:registry.internal/my-app list
rms repo/image/container:my-image:latest          push 
rms repo/git:go-luc                               create 
rms repo/image/container:my-image inspect
rms repo/git:my-org/my-app            list
rms pkg/npm:my-lib                    list

# Sub-resource level (collection) operations
rms repo/git/branch:my-org/my-app          list
rms repo/cim:registry.internal/my-app/tags list


# Item-level operations
rms repo/git:my-org/my-app       inspect
rms repo/git:my-org/my-app/files add --file ./config.json
rms pkg/npm:my-lib/v1.2.0        add --file ./dist/bundle.tgz
rms repo/image/container:registry.internal/my-app inspect
```
## non repository resource operation

# resoure level


# item level
```
rctl repo/git:my-app list content 
rctl repo/container/image:my-image push item     --file image.tar
```




## Step 3 — 

Validates that the pattern generalizes beyond repositories (resources defined in Phase 01).

| Resource Type | Command | Action |
|---|---|---|
| Files | `rctl file/json:/etc/app/config.json inspect` | Inspect local file properties |
| Files (S3) | `rctl file/s3:my-bucket/logs/app.log get` | Retrieve S3 object |
| VMs | `rctl vm:instance-12345 restart` | Reboot a cloud VM |
| Clusters | `rctl cluster/k8s:prod-cluster/nodes list` | List nodes in a K8s cluster |
| Manifests | `rctl workflow/yaml:dev-env.yaml apply` | Apply a declarative manifest |

**Result:** the grammar holds across all resource classes without modification.



<details>
<summary>TODO</summary>

## Step 2 — Evaluate Grammar Archetypes

Three candidates were evaluated.

### Option A — `<subject> <verb>`
```sh
# <verb> <resource-target>
rctl list repo/git:my-repo
rctl push repo/image/container:my-image

# <res> <verb>
rctl repo/git:my-repo list
rctl repo/image/container:my-image push

```

### Option B — `<verb> <subject>`

```bash
# resoure level
rctl create repo --type git       --name my-app
rctl list   repo --type image/container

# item level
rctl list content --repo git:my-app
rctl push item    --repo container/image:my-image --file image.tar
```

- ✅ Intuitive for general actions.
- ❌ Flags become verbose when scoping into a repository (`--repo …`).

### Option C — `<noun> <sub-noun> <verb>`

```bash
# resoure level
rctl repo create --type git --name my-app
rctl repo list   --type container/image

# item level
rctl repo content list my-app
rctl repo content add my-app --file artifact.tar
```

- ✅ Clean auto-completion, good scoping.
- ❌ Deeper and more verbose for quick actions.

### Option D — `<verb> <resource-address>`

```bash
# resoure level
rctl list git:my-org/my-repo # remote repo
rctl list git:my-repo        # local repo
rctl list container:registry.internal/my-image # docker, podaman, ...

# item level
rctl add git:my-org/my-repo --file main.go
```

- ✅ Concise and fast for power users.
- ❌ Requires strict, unambiguous resource-address parsing.


### Option E — Sub-item Scope
```sh
# Path style
rctl list git:my-repo/branches
rctl list container:my-image/tags

# Flag/Sub-command style
rctl list git:my-repo         --items // list branches
rctl list container:my-image  --items // list tags

```
**Decision:** 
- **Option D**
- use Cross-resource verbs
- use resource-specific verbs
- **Option E**: path-style:

```bash
# Resource-level generic operations
rctl repo/cim:registry.internal/my-app list
rctl repo/git:my-org/my-app list
rctl pkg/npm:/my-lib    list

# Sub-resource level (collection) operations
rctl repo/git:my-org/my-app/branches              list
rctl repo/cim:registry.internal/my-app/tags list


# Item-level operations
rctl repo/git:my-org/my-app       inspect
rctl repo/git:my-org/my-app/files add --file ./config.json
rctl pkg/npm:my-lib/v1.2.0        add --file ./dist/bundle.tgz
rctl repo/image/container:registry.internal/my-app inspect
```

When an operation only makes sense for a specific resource kind, the (domain-specific) verb is appended directly to the target.

```sh
# resource level operation - Git-specific operation
rctl repo/git:my-org/my-app push          --branch main
rctl repo/git:my-org/my-app reset-history --force

# resource level operation - Container-specific operation
rctl repo/image/container:registry.internal/my-app:v1.0.0 push

# resource level operation - Package-specific operation
rctl pkg/npm:my-lib/v1.0.0 publish
rctl pkg/npm:my-lib/v1.0.0 yank
```

**Rationale:** target-first ordering makes the *object of the operation* the primary mental anchor, unifies resource and sub-resource addressing under one path grammar, and leaves room for domain-specific verbs without special-casing.


## Step 4 — Deliverable: Draft ADR-004

Write **ADR-004 — CLI Grammar Specification** recording:

1. The chosen pattern (target-first, `resource-address [sub-path] verb [flags]`).
2. Resource-address syntax (`type:path[:version]`).
3. Cross-resource vs. domain-specific verb placement.
4. The stress-test table above as validation evidence.


</details>
