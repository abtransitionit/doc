[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Rctl Specification</h1>


# Step 01: The Project's Vision

Build a unified control CLI system (`rctl`) to manage infrastructure, hosts, and operational workloads across local and remote environments.

`rctl` is a lightweight , agentless CLI execution engine designed for ad-hoc remote operations and environment inspection across heterogeneous infrastructure.


## 1. Problem Statement

Managing infrastructure and operational workloads currently suffers from fragmented tooling, inconsistent command semantics, and poor visibility across different host environments.

* **Tooling Fragmentation:** Interacting with local machines, remote hosts over SSH, or cloud environments requires jumping between disparate tools (`ssh`, `curl`, custom shell scripts, provider CLIs).
* **Inconsistent Mental Models:** Executing identical administrative operations (such as status checks, configuration applying, or resource inspection) requires learning different flag patterns and syntax structures per target system.
* **Opaque Execution State:** Running remote administrative tasks lacks structured logging, explicit failure reporting, and repeatable target environment selection.

```text
                     Fragmented Interfaces
                               │
            ┌──────────────────┼──────────────────┐
            ▼                  ▼                  ▼
      Local Scripts       Provider CLIs         SSH / API
            │                  │                  │
            └──────────────────┼──────────────────┘
                               ▼
                       Target Host / Env

```


## 2. Long-Term Vision

The long-term vision for `rctl` is to provide a single, consistent CLI abstraction to inspect, invoke, and control host systems and operational tasks regardless of the underlying execution target.

```text
                           rctl CLI
                              │
                    ┌─────────┴─────────┐
                    ▼                   ▼
               Local Target       Remote Target
                    │                   │
             ┌──────┴──────┐     ┌──────┴──────┐
             ▼             ▼     ▼             ▼
          Filesystem    Process  SSH         Daemon

```

* **Unified Interface:** Standardized command taxonomy (`rctl host`, `rctl config`, `rctl exec`) across all supported environments.
* **Environment Agnostic:** Execute local or remote management commands without altering command flags or output format expectations.
* **Structured System Control:** Return clean, predictable output formats suitable for both human readability and automated scripting.


## 3. Initial Goal & Scope

The initial goal is **not** to support every operational task or cloud provider, but to validate the core CLI framework and control model against a tightly bounded set of targets.

### In Scope (Initial Release)

* **Local Host Execution:** Inspecting host status and applying configuration files locally.
* **Remote Host Execution:** Basic remote execution over SSH using shared host inventory configurations.
* **Core Command Taxonomy:** Establishing the foundational command structure and flag parsing patterns in Go.

### Out of Scope (Deferred)

* Direct cloud provider API orchestrations (e.g., AWS, OVH SDK integration).
* Complex multi-node parallel orchestration engines.
* Interactive terminal GUIs or web dashboards.


## 4. Initial Vision Requirements

| ID | Requirement Statement |
| --- | --- |
| **V01** | Provide a single CLI binary (`rctl`) capable of managing local and remote host operations. |
| **V02** | Establish a deterministic, predictable command taxonomy that scales as new capabilities are added. |
| **V03** | Isolate target environment configuration (host addresses, credentials, SSH keys) from execution logic. |

