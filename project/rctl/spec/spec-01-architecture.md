[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Rctl Specification</h1>

# Step 04: Architecture Specification


This document defines the high-level technical architecture, module boundaries, transport abstractions, and CLI layout for `rctl`. It translates the domain entities from `DOM-01-domain-model.md` into Go packages and concrete software components.

---

## 1. System Topology & Boundaries

`rctl` operates as a standalone CLI application. It parses commands, loads target inventory configurations, dispatches execution through transport adapters, and streams structured results.

```text
┌────────────────────────────────────────────────────────┐
│                        rctl CLI                        │
│                                                        │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────┐  │
│  │  CLI / Flag  │ ──►│  Engine /    │ ──►│ Inventory│  │
│  │  App Parser  │    │  Dispatcher  │    │ Loader   │  │
│  └──────────────┘    └──────────────┘    └──────────┘  │
└──────────────────────────┬─────────────────────────────┘
                           │
            ┌──────────────┴──────────────┐
            ▼                             ▼
   ┌─────────────────┐           ┌─────────────────┐
   │ Local Transport │           │  SSH Transport  │
   └────────┬────────┘           └────────┬────────┘
            │                             │
            ▼                             ▼
       Local Host                    Remote Host

```

---

## 2. Go Package Layout

```text
pkg/
├── cli/          # Command parsing, flag handling, and output formatters
├── config/       # Inventory file loading, parsing (YAML/TOML), and validation
├── core/         # Domain interfaces (Host, Command, Result, Executor)
└── transport/    # Transport implementations
    ├── local/    # Local OS command execution adapter
    └── ssh/      # Remote SSH client connection adapter

```

---

## 3. Core Component Contracts

### Transport Abstraction (`pkg/core`)

```go
type Command struct {
    Path string
    Args []string
    Env  map[string]string
    Dir  string
}

type Result struct {
    ExitCode int
    Stdout   io.Reader
    Stderr   io.Reader
}

type Executor interface {
    Execute(ctx context.Context, cmd Command) (*Result, error)
}

```


## 4. Architectural Decision Records (ADRs)

All immutable technical trade-offs, transport selections, and security boundaries established during Phase 4 are documented in standalone records under the `adr/` directory.

* **ADR Index & Governance:** See [`../adr/README.md`](../adr/README.md) for the complete index and lifecycle traceability process.

