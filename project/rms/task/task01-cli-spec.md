
[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./ep.md

[↖ Task][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[cli howto]: /concept/tool/howto/ep.md#design-the-grammar-of-a-cli
[res model whatis]: ../../whatis/pp1.model.md

<div align="center">

# Project RMS — Task01 - CLI - Specification

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>



# Overview
This discovery section follows the [How-to: Design the Grammar of a CLI][cli howto].

RMS provides different command syntax.
- [Operational commands](#operational-commands) to perform CLI-level operations:
- [Resource commands](#resource-commands) to operate on a resources:

## Global Flags

- These flags applies to all syntax of the CLI

| Flag | Short | Type | Default | Description |
|---|---|---|---|---|
| `--config` | `-c` | `string` | `~/.rms/inventory.yaml` | Path to the inventory configuration file (YAML, JSON, or TOML). |
| `--json` | `-j` | `bool` | `false` | Output structured JSON instead of human-readable text. |
| `--yaml` | `-y` | `bool` | `false` | Output structured YAML instead of human-readable text. |
| `--verbose` | `-v` | `bool` | `false` | Enable debug logging on stderr. |

## Global Intent exit Codes

- These exit codes are returned by all syntax of the CLI
- The code is returned by RMS to the calling agent that invoke the it.

| Exit code | Classification |Status| Description |
|---|---|---|---|
| `0` | Success |success| All requested execution on targets executed successfully|
| `1` | Execution failure |failed| <li>A command runs on a target and returns a non-zero status<li>At least one target execution fails with no connection or transport failures|
| `2` | CLI error || <li>A CLI error **prevented execution from starting** <li>Bad usage, Invalid flags, missing required arguments, or mutually exclusive flags|
| `3` | <li>Configuration error |conf_error| <li>A configuration error **prevented execution from starting**.<li>Inventory file is missing or cannot be loaded due to inconsistent or invaled schema|
| `4` | Connection/Transport error |unreachable| <li>At least one target encountered a connection or transport failure<li>Host unreachable, SSH connection refused, or authentication failure. <li>connection fails during execution |




# Operational Commands


```sh
rms <command> [subcommand] [flags] [args...]

## Examples
rms exec --host web01 -- "uptime"
rms inventory list
```

## `rms inventory`

Inspect and validate inventory configurations.

```sh
rms inventory <subcommand> [flags]
```

| Subcommand | Description |
|---|---|
| `list` | Display inventory. |
| `validate` | Check inventory syntax, schema|

Examples:

```sh
rms inventory list
rms inventory list --json
rms inventory validate --config ./specs/inventory.yaml
```

**Examples**

1. **Inventory configuration is invalid**

```sh
$ rms exec --host @all -- "uptime"

Error: inventory configuration is invalid
```

> Overall exit code: `3`. Execution does not start.




## `rms exec`

Execute shell commands across target environments.

```sh
rms exec [target flags] [execution flags] -- <command_string>
```

| Flag | Short | Type | Default | Description |
|---|---|---|---|---|
| `--host` | `-h` | `string` |`local`| Target host selector. |
| `--timeout` | `-t` | `duration` || Command execution timeout, e.g. `30s` or `5m`. |
| `--concurrency` | `-C` | `int` || Maximum number of parallel SSH connections. Default: `10`. |

The `--host` flag accepts the following selectors:

| Selector      | Description                             |
|---|---|
| `local`       | localhost                           |
| `web01`       | A single host                           |
| `web01,web02` | Multiple hosts, separated by commas     |
| `@prod`       | All hosts belonging to the `prod` group |
| `@all`         | All hosts in the inventory              |

**Rules**
- Unknown hosts or groups return an `error` before any command executes.
- `--host` defaulted to `local` when omitted. 

**standard mechanism**
- RMS passes the command string to the target's command interpreter. 
- Shell operators in **command** such as `;`, `||` and `&&` follow the interpreter's semantics and impact it exit code.
    - `;`  -> the final command's exit status determines the shell's exit status
    - `&&` -> the first failed cde determines the shell's exit status
    - `||` -> 
- RMS reports the status and exit code for each target.
- RMS continues execution on other targets when one target fails.
- RMS selects concurrency automatically by default. `--concurrency` overrides the automatic value.




**Examples**:

```sh
# localhost
rms exec --json --host local -- "whoami"   # host:localhost, output:JSON, 
rms exec --json -- "whoami"                # host:FALLBACK to localhost, output:JSON, 
rms exec -- "whoami"                       # FALLBACK to (host:localhost, output:human)

# single host
rms exec --host web01 -- "uptime"

# several hosts
rms exec --host web01,web02,local -- "uptime; ls -ial"

# a set of hosts
rms exec --json --host @prod,web2 -- "systemctl status nginx" 
rms exec        --host @prod,local -- "systemctl status nginx"

# all hosts
rms exec --host @all -- "uptime"
```

## Execution behavior


### 1 target → 1 cmd


```sh
# example
rms exec --host web01 -- "uptime; ls -ial"
```

**Examples**

1. **CLI arguments are invalid**

```sh
$ rms exec --invalid-option -- "uptime"

Error: unknown option '--invalid-option'
```

> Overall exit code: `2`. Execution does not start.


### N target → 1 cmd
- RMS automatically set concurrency unless overridden with `--concurrency`.
- RMS return an  exit code for the overall **intent**, but also exit code per **target**


**Target exit code**

This is the exit code returned by the command (interpreter) when executed on the target

| Status        | Meaning                                                           | Exit code                      |
| ------------- | ----------------------------------------------------------------- | ------------------------------ |
| `success`     | The command completed successfully.                               | `0`                            |
| `failed`      | The command ran but returned a non-zero exit code.                | The command's actual exit code |
| `unreachable` | RMS could not establish or maintain the connection to the target. | `—`                            |
| `not_run`     | Execution did not start on the target.                            | `—`                            |

- A dash (`—`) means the command did not produce an exit code.

**Intent exit code**

This is the exit code returned by RMS to the calling process concerning the intent (that concerns multiple host)

When multiple conditions occur, RMS applies this precedence:

| Precedence | Exit code | Description|
| -- | -- | -- |
| 1 | `2` | CLI argument or usage error.
| 2 | `3` | configuration error.
| 3 | `4` | one or more connection or transport failures.
| 4 | `1` | one or more command failures.
| 5 | `0` | all commands succeeded.

> Errors that prevent execution from starting, take precedence over target execution results.


#### Examples

```sh
# suppose this command 
rms exec --host @all -- "uptime"
```


1. **All targets succeed**


```yaml
TARGET   STATUS   EXIT CODE
web01    success  0
web02    success  0
web03    success  0

Result: 3 succeeded, 0 failed, 0 unreachable
```

> Intent exit code: `0`.

2. **One command fails**

```yaml
TARGET   STATUS   EXIT CODE
web01    success  0
web02    failed   1
web03    success  0

Result: 2 succeeded, 1 failed, 0 unreachable
```

> Intent exit code: `1`.

3. **One target is unreachable**

```yaml
TARGET   STATUS       EXIT CODE
web01    success      0
web02    unreachable  —
web03    success      0

Result: 2 succeeded, 0 failed, 1 unreachable
```

> Intent exit code: `4`.

4. **Command failures and connection failures occur together**

```yaml
TARGET   STATUS       EXIT CODE
web01    success      0
web02    failed       1
web03    unreachable  —

Result: 1 succeeded, 1 failed, 1 unreachable
```
5. **Concurency**

```sh
# RMS choose an appropriate concurrency level - idea: one per host
rms exec --host all -- "uptime"

# User override the default concurency level
rms exec --host all --concurrency 5 -- "uptime"
```



> Intent exit code: `4`, because connection or transport failures take precedence over command failures.


## Execution rules

- RMS validates the request and configuration before starting execution.
    requested targets
    requested resource
    requested resource's capability
- RMS Continue executing on other targets when one target fails. unless all must succed ....
    - A command failure on one target does not prevent execution on other targets.
- RMS collects and reports/displays a result (including status and code) for every target.
- The final summary reports the number of successful, failed, and unreachable targets.
- RMS Return one **overall process exit code** to the calling shell/process.



# Resource Command

- Uses the [string representation][res model whatis] of a resource
- Provision or operate one or more resource across environments

```sh
rms <resource-kind>:<resource-adress> <operation> [flags] [args...]
```
**Rules**
- `<resource-adress>` can be used to select more than one resource of the same kind.
- `<resource-selector>` can be used if supported by the resource provider.



**Examples**:

```sh
# single resource
rms service/linux:sshd inspect
rms file/s3://my-bucket/config/ list


# Several resources
rms service:sshd,cron inspect

# Set of resources - wildcars is the selector
rms linux/service:* list

# Set of resources - wildcars is the selector - must be supported by the provider
rms file/fs:/etc/*.conf list
```



## Example
rms repo/git:my-org/my-app inspect
```

Resource management uses the following syntax:

```sh
rms <resource-kind>:<resource-location> <verb> [flags] [args...]
```





Subpaths can identify collections or items within a resource.

Examples:

```sh
rms repo/git:my-org/my-app list
rms repo/git:my-org/my-app inspect
rms repo/git:my-org/my-app/branches list
rms repo/git:my-org/my-app push --branch main
rms os:linux upgrade
rms kernel/module:br_netfilter load
rms file:/etc/app/config.json inspect
```

### Resource types


### Verbs

| Resource scope | Verbs |
|---|---|
| Cross-resource | `get`, `inspect` |
| Repository | `list`, `add` |
| Git repository | `push`, `commit`, `pull`, `branch`, `reset-history` |
| Container image repository | `push`, `commit`, `pull`, `instantiate` |
| OS package repository | `upgrade`, `update` |
| OS package | `add`, `install` |
| OS | `upgrade`, `update` |
| Kernel module | `load` |
| Kernel parameter | `set` |
| File | `read`, `write` |

The supported verbs depend on the resource type.


**Rules**

---


# Outpout example
```sh
$ rms inventory list

# output is human readable
HOST     GROUP   STATUS
web01    prod    ready
web02    prod    ready
```
```sh
$ rms inventory --json list

# JSON output
{
  "hosts": [
    {"host": "web01", "group": "prod", "status": "ready"},
    {"host": "web02", "group": "prod", "status": "ready"}
  ]
}
```


# Open question
- which **rules** apply to both
- which **rules** apply only one.
- decide where global flags such as `--config`, `--json`, and `--verbose` can appear
- if a target runs a command that itself exits with code `4`, RMS should classify that as an execution failure (`1` overall). Not a transport failure. The distinction depends on why the operation failed, not just the command's returned number.
