[//]: #(home)
[home]: ../../

[//]: #(doc)

[↖][home]

<h1 align="center">Rctl Task</h1>



# TASK-01: Define Core CLI Command Taxonomy

* **Status:** In Review
* **Assignee:** Lead Engineer
* **Target Package:** `src/pkg/cli`
* **Governing Specs:** [`REQ-01`](../../spec/REQ-01-requirements.md), [`SPEC-01`](../../spec/SPEC-01-architecture.md), [`ADR-02`](../../adr/ADR-02-decoupled-output-formatting.md)

---

## 1. Scratchpad & Ephemeral Notes

* **Parser Selection:** Standardize on `cobra` semantics for command routing and flag inheritance.
* **Global Flags:** `--json`, `--verbose`, `--config` must be root-persistent flags accessible across all subcommands.
* **Target Selection Rules:** Execution targets must accept explicit single host strings (`--host`), group tags (`--group`), or all hosts in inventory (`--all`). Mutually exclusive flag enforcement required.

---

## 2. Command Structure & Syntax Matrix

### Root Command

```text
rctl [global flags] [command] [subcommand] [args...]

```

#### Global Flags

| Flag | Short | Type | Default | Description |
| --- | --- | --- | --- | --- |
| `--config` | `-c` | `string` | `~/.rctl/inventory.yaml` | Path to inventory configuration file |
| `--json` | `-j` | `bool` | `false` | Output structured JSON instead of human-readable text |
| `--verbose` | `-v` | `bool` | `false` | Enable debug logging output to stderr |

---

### Subcommand: `rctl exec`

Executes ad-hoc shell commands across target environments.

```bash
rctl exec [target flags] [execution flags] -- <command_string>

```

#### Flags

| Flag | Short | Type | Description |
| --- | --- | --- | --- |
| `--host` | `-h` | `string` | Target a specific host by name |
| `--group` | `-g` | `string` | Target all hosts matching a group tag |
| `--all` | `-a` | `bool` | Target all hosts in the inventory |
| `--timeout` | `-t` | `duration` | Command execution timeout (e.g., `30s`, `5m`) |
| `--concurrency` | `-C` | `int` | Maximum parallel SSH connections (default: `10`) |

#### Usage Examples

```bash
# Execute command on a single target host
rctl exec --host web01 -- "uptime"

# Execute command across a group with JSON stream output
rctl --json exec --group prod -- "systemctl status nginx"

# Local fallback execution
rctl exec --host local -- "whoami"

```

---

### Subcommand: `rctl inventory`

Inspects and validates inventory configurations.

```bash
rctl inventory [subcommand] [flags]

```

#### Subcommands

| Subcommand | Description |
| --- | --- |
| `list` | Print active hosts and groups |
| `validate` | Perform schema and connectivity sanity checks on the inventory file |

#### Usage Examples

```bash
# List all loaded hosts
rctl inventory list

# Output inventory structure as JSON
rctl --json inventory list

# Validate inventory file syntax
rctl inventory validate --config ./specs/inventory.yaml

```

---

## 3. Exit Code Taxonomy

| Exit Code | Classification | Cause / Description |
| --- | --- | --- |
| **0** | **Success** | All targets executed successfully with exit code 0 |
| **1** | **Execution Failure** | One or more remote commands returned a non-zero exit code |
| **2** | **CLI Argument Error** | Invalid flags, missing required arguments, or mutually exclusive flag violation |
| **3** | **Configuration Error** | Inventory file not found, unparseable YAML/TOML, or schema violation |
| **4** | **Transport Error** | SSH connection refused, authentication failure, or host unreachable |

---

## 4. Progress Checklist

* [x] Draft root flags (`--json`, `--verbose`, `--config`)
* [x] Define `exec` subcommand syntax, target flags, and positional args
* [x] Define `inventory` subcommands (`list`, `validate`)
* [x] Establish exit code taxonomy
* [ ] Review against `REQ-01` functional requirements

