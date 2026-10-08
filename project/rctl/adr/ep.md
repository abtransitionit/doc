[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../ep.md

[↖ Project Blue][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[cli howto]: /concept/tool/howto/ep.md#design-the-grammar-of-a-cli
[repo whatis]: /concept/repository/whatis/ep.md

Related topics

| Topic | Location| Kind |
|-|-|-|
|[How-to for CLI][cli howto]|
|[What is a Repository][repo whatis]|


---

[cli howto]: ../howto/cli-grammar.md
[REQ-01]: ../../spec/REQ-01-requirements.md
[SPEC-01]: ../../spec/SPEC-01-architecture.md
[ADR-02]: ../../adr/ADR-02-decoupled-output-formatting.md

**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Project: RCtl — ADR</h1>

This is a formal decision log entry explaining why the system works this way.

# ADR-001: Architecture & Engine Language Selection

|Key|Value|
|-|-|
| Status | Accepted

## Context
The engine must compile into a single portable binary, runnable on local workstations or CI/CD pipelines, with efficient subprocess invocation.

## Decision
Develop the core engine in **Go**.

## Rationale
Static binary with no external runtime dependencies, strong filesystem and subprocess management, and strong typing for data models.

## Consequences
Easy deployment and distribution, while retaining the ability to invoke Python, Bash scripts, or external CLI tools (`gh`, `aws`).

# ADR-002: Plugin & Driver Execution Mechanism

|Key|Value|
|-|-|
| Status | Accepted


## Context
The system must support third-party CLIs (`gh`, `aws`), scripts (`python`, `bash`), and native APIs.

## Decision
Adopt an external driver interface communicating via **Stdio (JSON RPC / stdin-stdout)**.

## Rationale
Avoids locking driver development into a single language. Any tool or script that reads and writes JSON can serve as an `rctl` driver.

## Consequences
Simplifies writing new drivers without recompiling the `rctl` core engine.

# ADR-003: Dual-Dimension Environment Management

|Key|Value|
|-|-|
| Status | Review

## Context
Environment refers to both the lifecycle stage (`dev`, `prod`) and technical substrate (`bare-metal`, `AWS`, `k8s`).

## Decision
Explicitly separate `lifecycle` and `substrate` fields in metadata and context resolution.

## Rationale
Allows reusing the same resource manifest across different substrates depending on the lifecycle phase.

## Consequences
Clearer definitions and elimination of ambiguity during target context resolution.

# ADR-004: CLI Grammar & Command Pattern Specification

|Key|Value|
|-|-|
| Status | Accepted
| Ref | Task01



## Context

The system manages heterogeneous resources 
- files, 
- cloud VMs, 
- Kubernetes clusters, 
- Git/OCI/package repositories

To avoid the fragmentation found in dedicated toolsets (`gh`, `aws`, `kubectl`), The system requires a unified, ergonomic, and predictable Command-Line Interface (CLI) grammar.

Primary requirements for the CLI grammar:

Support both 
  - declarative state management (e.g., manifest application) and 
  - imperative day-2 operations (e.g., repository resets, image pushes, VM reboots).

Offer consistent targeting across 
  - high-level collection resources (e.g., a full repository) and 
  - nested sub-resources (e.g., branches, tags, files, nodes).

Accommodate 
- universal cross-resource verbs alongside 
- domain-specific operational verbs without syntax collision.

## Decision

We adopt a **Target-First, Path-Scoped Grammar Model** (`rctl <target-path> <verb> [flags]`).

**Structure Blueprint**

```text
rctl <type>:<resource-path>[/sub-path] <verb> [options]

```

`<type>` 
- The Target Prefix
- Explicitly identifies the resource provider or domain driver 
- E.g. `git:`, `container:`, `pkg:`, `s3:`, `file:`, `ovh:`, `k8s:`, `manifest:`).

`<resource-path>`
- The Resource Path
- Uniquely addresses the target entity or root collection.
- E.g. 

`/sub-path`
- The Sub-Path Scoping
- Uses standard path segments to drill down into nested child collections **or** specific sub-items (without needing verbose flags).
- E.g. 

`<verb>`
- The Verb
- The operational command appended directly after the target scope


## Detailed Specifications & Rules

**Rule 1: Target-First Ergonomics**
- The subject/target of an operation always precedes the action verb. 
- This establishes a direct subject-verb relationship and allows for natural auto-completion by resource address.

```bash
# Target first, verb second
rctl git:org/repo list
rctl ovh:vm-1029 restart
rctl manifest:env-dev.yaml apply
```

**Rule 2: Path-Style Sub-Resource Navigation**
- Nested entities inside collections 
- composite resources are addressed using URL/POSIX-style path segments.

```bash
# Root entity level
rctl git:my-org/my-app list

# Nested collection level (listing branches)
rctl git:my-org/my-app/branches list

# Nested item level (targeting a specific version/tag)
rctl container:registry.internal/my-app/v1.0.0 inspect
rctl pkg:npm/my-lib/v1.2.0 yank
```

**Rule 3: Dual-Layer Verb Strategy**

**Rule 3.1. Generic Verbs (Cross-Resource Standard):**
Uniform verbs exposed across multiple resource types when semantics are clear and universal:
* `list`: Discovers or enumerates items at the specified target path.
* `inspect`: Displays detailed metadata and live state for a resource.
* `add` / `put`: Inserts an item, file, or artifact into the target scope.
* `apply`: Declaratively reconciles desired state (used heavily with `manifest:` targets).
* `delete` / `remove`: Destroys or unlinks a target resource.


**Rule 3.2. Domain-Specific Verbs (Mechanism-Dependent):**
Actions tied strictly to specific driver capabilities or operational workflows:
* **Git:** `push`, `branch`, `reset-history`
* **Container / OCI:** `push`, `tag`
* **Package Repositories:** `publish`, `yank`
* **Compute / Virtualization:** `reboot`, `snapshot`, `start`, `stop`



**Concrete Syntax Examples**

- Repository Management (Git, OCI, Package)

```bash
# Universal operations across repository types
rctl git:my-org/my-app list
rctl container:registry.internal/my-app list
rctl pkg:npm/my-lib list

# Nested path-based operations
rctl git:my-org/my-app/branches list
rctl git:my-org/my-app/files add --file ./config.json

# Domain-specific operational verbs
rctl git:my-org/my-app reset-history --force
rctl container:registry.internal/my-app:v2.1.0 push
rctl pkg:npm/my-lib/v1.0.0 publish

```

- Infrastructure, Storage & Declarative Manifests

```bash
# File & Object Storage
rctl file:/etc/app/config.json inspect
rctl s3:my-bucket/logs/app.log get

# Compute & Clusters
rctl vm:instance-12345 restart --provider ovh
rctl k8s:prod-cluster/nodes list

# Declarative Application
rctl manifest:infrastructure.yaml apply --env dev

```

## Rationale & Trade-Off Analysis

**Pros**

* **Readability:** Commands read as natural subject-action statements (`rctl <subject> <action>`).
* **Consistency:** Eliminates confusion between flags and positional parameters when managing nested entities (e.g., branches, tags).
* **Unified Model:** Treats declarative manifests (`manifest:dev.yaml apply`) as standard resource targets alongside live infrastructure (`ovh:vm-102 restart`).
* **Driver Isolation:** Target prefixes (`git:`, `container:`, `s3:`) map cleanly to the underlying Stdio mechanism drivers resolved by the engine router.

**Cons & Mitigations**

* **Parsing Complexity:** Demands robust parsing for target prefixes and path segments.
* *Mitigation:* The core Go engine will utilize a dedicated URI-style target parser package early in `PoC-001`.


* **Verb Collision Potential:** Driver authors might introduce conflicting names for generic vs. domain-specific actions.
* *Mitigation:* The engine will maintain a strict registry of reserved generic verbs (`list`, `inspect`, `add`, `apply`, `delete`) that drivers must implement according to contract.

## Consequences

1. `PoC-001` CLI implementation will strictly follow the `rctl <target-path> <verb>` execution pattern.
2. The core router parser will split targets on `:` to resolve driver selection, and on `/` to build target scope parameters.
3. Documentation, help output, and autocomplete scripts will be structured around target resource domains.

# ADR-005: Hybrid Driver Execution Model & Capabilities Manifest & Contract Enforcement

|Key|Value|
|-|-|
| Status | Accepted
| Ref | Task01

## Context
Drivers can execute commands as **opaque scripts**. This causes two problems:
1. A driver can perform destructive actions (deleting history, purging repos) with no warning and no way for the engine to prevent it.
1. Documentation is usually written by hand, so it drifts — help text often doesn't match actual behavior.

## todelete - Context
- Destructive commands (e.g., deleting history, changing repository visibility, purging resources) require 
  - strict runtime safety checks
  - interactive prompts
  - accurate CLI documentation. 
- Core drivers need low latency while external drivers require language flexibility.



### ADR-005: Driver Interface & Capability Manifest

**Status:** Accepted

## Context
Drivers currently execute commands as opaque scripts. This causes two problems:
1. A driver can perform destructive actions (deleting history, purging repos) with no warning and no way for the engine to prevent it.
1. Documentation is written by hand, so it drifts — help text often doesn't match actual behavior.

## Decision

**Driver interface.**
- Adopt a unified Go `Driver` interface.
- The interface supports two execution backends:
  - In-process Go functions (for core drivers like `file:`)
  - Stdio JSON-RPC wrappers (for external drivers like `git:` or `ovh:`)
- Every driver must implement a `capabilities` hook that returns a structured manifest describing each command (see Command Operation  Contract).

**Capability manifest as source of truth.**
- The manifest is the **single source of truth** for command metadata. No behavior may exist that isn't declared in it.
- The engine queries the manifest to:
  - Build dynamic `--help` output
  - Generate documentation
  - Enforce runtime safety pre-checks (e.g., prompt on destructive operations unless `--force` is passed)


## Consequences
- Every driver must implement a `capabilities` hook returning the standardized contract schema.
- Driver authors must learn the manifest schema
- Adding a new command requires updating the manifest first
- External drivers must speak JSON-RPC over stdio
- The core engine automatically enforces `--force` confirmation prompts on destructive operations prior to executing driver logic.

## Rationale
- Eliminates documentation drift between core CLI help and external driver features.
- prevents hidden destructive shell executions
- guarantees predictable terminal safety.
- Docs can't drift — they're generated from the manifest
- Destructive commands can't hide — the engine sees them coming
- Users get predictable, consistent safety behavior across all drivers
- One interface, two backends — core and external drivers stay uniform


# ADR-006: Stdio JSON-RPC Protocol Specification for External Drivers

|Key|Value|
|-|-|
| Status | Accepted



## Context

Per **ADR-005**, `rctl` uses a hybrid driver model:

1. **In-Process Go Drivers:** Compiled into the core binary.
2. **External Stdio Drivers:** Standalone executables invoked as subprocesses.

To communicate with external drivers deterministically accross
- differents operating systems (linux, windows, mac) 
- differents implementation languages (Go, Python, Rust, Bash, C++) 

`rctl` requires a lightweight, stateless IPC protocol over standard I/O streams (`stdin` / `stdout`).


## Protocol Rules & Constraints

1. **Transport Streams:**
* **`stdin` (Engine $\rightarrow$ Driver):** Receives JSON request payloads from `rctl`.
* **`stdout` (Driver $\rightarrow$ Engine):** Returns structured JSON response payloads or newline-delimited event streams. **Must contain ONLY valid JSON.**
* **`stderr` (Driver $\rightarrow$ Engine):** Reserved for unformatted operational logs, panic traces, or debug output. `rctl` captures `stderr` for log aggregation but never parses it as control flow.


2. **Framing & Encoding:** UTF-8 encoded, single-line or length-prefixed JSON messages.
3. **RPC Standard:** Based on JSON-RPC 2.0 primitives (`jsonrpc`, `method`, `params`, `id`, `result`, `error`).


## 1. Request Payload Schema (`stdin`)

Every call initiated by `rctl` sends a single JSON object to the driver's `stdin`.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "RctlDriverRequest",
  "type": "object",
  "required": ["jsonrpc", "id", "method", "params"],
  "properties": {
    "jsonrpc": {
      "type": "string",
      "const": "2.0"
    },
    "id": {
      "type": "string",
      "description": "Unique execution request correlation ID generated by the rctl engine"
    },
    "method": {
      "type": "string",
      "enum": ["capabilities", "inspect", "execute"]
    },
    "params": {
      "type": "object",
      "required": ["target", "context"],
      "properties": {
        "target": {
          "type": "object",
          "required": ["raw", "prefix", "path", "subpath"],
          "properties": {
            "raw": { "type": "string", "example": "git:my-org/my-repo/branches" },
            "prefix": { "type": "string", "example": "git" },
            "path": { "type": "string", "example": "my-org/my-repo" },
            "subpath": { "type": "string", "example": "branches" }
          }
        },
        "verb": {
          "type": "string",
          "description": "The requested operation verb (required for 'execute' method)",
          "example": "reset-history"
        },
        "flags": {
          "type": "object",
          "description": "Parsed flags and options passed by the user",
          "additionalProperties": true,
          "example": { "force": true, "branch": "main" }
        },
        "context": {
          "type": "object",
          "description": "Execution environment context supplied by rctl engine",
          "properties": {
            "env": { "type": "string", "example": "prod" },
            "dry_run": { "type": "boolean", "default": false },
            "interactive": { "type": "boolean", "default": true },
            "env_vars": {
              "type": "object",
              "additionalProperties": { "type": "string" },
              "description": "Whitelisted environment variables required by driver contract"
            }
          }
        }
      }
    }
  }
}

```


## 2. Response Payload Schemas (`stdout`)

Every response returned by a **driver** sends a single JSON object to the `rctl` engine's stdout.

### Method 1: `capabilities` Response

Returned when `rctl` queries the driver for its command safety contract.

```json
{
  "jsonrpc": "2.0",
  "id": "req-001-cap",
  "result": {
    "driver": {
      "name": "rctl-driver-git",
      "version": "1.2.0",
      "domain_prefix": "git"
    },
    "operations": [
      {
        "verb": "reset-history",
        "summary": "Replaces remote branch history with current local state",
        "warning": "DESTRUCTIVE OPERATION: Irreversibly overwrites remote Git commit history.",
        "inputs": {
          "arguments": [
            {
              "name": "target",
              "type": "resource-uri",
              "required": true,
              "description": "Target repository path"
            }
          ],
          "options": [
            {
              "name": "force",
              "type": "boolean",
              "default": false,
              "description": "Bypasses interactive safety confirmation prompt"
            }
          ]
        },
        "environment": {
          "required_vars": ["GITHUB_TOKEN"]
        },
        "safety": {
          "interactive_confirmation": true,
          "side_effects": [
            "Overwrites remote HEAD commit history on target branch."
          ]
        },
        "exit_codes": {
          "0": "Success - Remote history overwritten",
          "1": "Operational failure - Network, auth, or push rejection",
          "2": "Invalid arguments - Target format or flags incorrect"
        }
      }
    ]
  }
}

```

---

### Method 2: `inspect` Response

Returned when `rctl` queries the current live state of a resource.

```json
{
  "jsonrpc": "2.0",
  "id": "req-002-insp",
  "result": {
    "target": "git:my-org/my-repo",
    "exists": true,
    "status": "active",
    "state": {
      "default_branch": "main",
      "visibility": "private",
      "archived": false,
      "size_bytes": 104857600
    },
    "metadata": {
      "last_updated": "2026-10-04T10:15:30Z",
      "provider_id": "repo_99210"
    }
  }
}

```

---

### Method 3: `execute` Streaming & Final Response

During `execute`, drivers can emit zero or more progress events prior to returning the final JSON-RPC completion payload.

#### A. Progress Stream Event (Optional, streamed over `stdout`)

```json
{
  "jsonrpc": "2.0",
  "method": "progress",
  "params": {
    "id": "req-003-exec",
    "step": "Authenticating with remote host",
    "percentage": 25,
    "level": "info"
  }
}

```

#### B. Final Execution Result Payload

```json
{
  "jsonrpc": "2.0",
  "id": "req-003-exec",
  "result": {
    "status": "success",
    "exit_code": 0,
    "summary": "Remote history successfully reset to commit a1b2c3d",
    "changes": [
      {
        "action": "force-push",
        "resource": "git:my-org/my-repo/branches/main",
        "previous_state": "e5f6g7h",
        "new_state": "a1b2c3d"
      }
    ]
  }
}

```

---

## 3. Standardized Error Payload Schema

When a **driver** fails to process a request (or returns an operational failure), it outputs a JSON-RPC error response to the `rctl` Core Engine via the driver's standard output (stdout).

```json
{
  "jsonrpc": "2.0",
  "id": "req-004-err",
  "error": {
    "code": -32001,
    "message": "Operational failure during push execution",
    "data": {
      "exit_code": 1,
      "reason": "AUTHENTICATION_FAILED",
      "details": "Environment variable GITHUB_TOKEN is empty or invalid.",
      "remediation": "Set GITHUB_TOKEN in your local shell or pass --env token config."
    }
  }
}

```


### What the `rctl` Core Engine Does with the Error

When `rctl` receives that error payload from `stdout`, it performs the following distinct actions:

1. **Maps the Exit Code:** Reads `error.data.exit_code` (or maps the JSON-RPC error code) to determine the CLI process exit code returned to the user's terminal or CI/CD runner.
2. **Formats Terminal Output:** Extracts `error.message`, `error.data.details`, and `error.data.remediation` to render a human-readable error message to the end user on `stderr`:
```text
❌ Operational failure during push execution
Details: Environment variable GITHUB_TOKEN is empty or invalid.
Remediation: Set GITHUB_TOKEN in your local shell or pass --env token config.

```


3. **Halts Pipeline Execution:** If `rctl` was executing a batch or declarative manifest, receiving an error payload causes the engine to halt further driver calls and roll back or exit safely.

### Standard Error Code Protocol

| Error Code | Category | Meaning |
| --- | --- | --- |
| `-32700` | JSON Parsing Error | Invalid JSON sent over `stdin` |
| `-32600` | Invalid Request | Payload does not conform to `RctlDriverRequest` schema |
| `-32601` | Method Not Found | Requested method (`capabilities`, `inspect`, `execute`) unhandled |
| `-32602` | Invalid Params | Target URI or flags missing/malformed |
| `-32001` | Operational Failure | Target driver execution failed (maps to CLI Exit Code 1) |
| `-32002` | Precondition Failed | Missing required environment variables or missing permissions |

---