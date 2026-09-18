[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[↖][home]

<h1 align="center">Rctl Task</h1>

# TASK-03: Initialize Go Module and Package Structure

**TASK-03** & **TASK-04** (Module & Core Interfaces): Establishes the Go packages to back those exact commands and schemas.

# TASK-03: Initialize Go Module and Package Structure

* **Status:** In Review
* **Assignee:** Lead Engineer
* **Target Directory:** `project/rctl/src/`
* **Governing Specs:** [`SPEC-01`](../../spec/SPEC-01-architecture.md), [`ADR-01`](../../adr/ADR-01-pure-go-ssh-transport.md), [`ADR-02`](../../adr/ADR-02-decoupled-output-formatting.md)

---

## 1. Scratchpad & Ephemeral Notes

* **Module Naming:** `github.com/org/rctl` (or local module root `rctl`).
* **Standard Go Layout:** Enforce standard Go layout (`cmd/` for entrypoints, `pkg/` for internal domain packages).
* **Dependency Boundary:** Minimal core dependencies (`golang.org/x/crypto/ssh` for SSH, `gopkg.in/yaml.v3` for inventory parsing, `github.com/spf13/cobra` for CLI routing).

---

## 2. Go Source Layout (`project/rctl/src/`)

```text
project/rctl/src/
├── go.mod
├── go.sum
├── main.go
├── cmd/
│   ├── root.go
│   ├── exec.go
│   └── inventory.go
└── pkg/
    ├── cli/
    │   └── format/
    │       ├── formatter.go        # Interface (ADR-02)
    │       ├── json.go             # JSON output implementation
    │       └── table.go            # Text table implementation
    ├── config/
    │   ├── schema.go           # Struct bindings (TASK-02)
    │   └── loader.go           # YAML file parsing
    ├── core/
    │   ├── executor.go         # Domain interfaces
    │   ├── command.go          # Command value object
    │   └── result.go           # Execution result streams
    └── transport/
        ├── local/
        │   └── local.go        # os/exec non-root transport (ADR-03)
        └── ssh/
            └── ssh.go          # Pure Go SSH client adapter (ADR-01)

```

---

## 3. Initial `go.mod` Specification

```go
module rctl

go 1.22

require (
	[github.com/spf13/cobra](https://github.com/spf13/cobra) v1.8.0
	golang.org/x/crypto v0.21.0
	gopkg.in/yaml.v3 v3.0.1
)

```

---

## 4. Entrypoint Boilerplate (`src/main.go`)

```go
package main

import (
	"fmt"
	"os"

	"rctl/cmd"
)

func main() {
	if err := cmd.Execute(); err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
}

```

---

## 5. Progress Checklist

* [x] Define package tree hierarchy matching domain boundaries
* [x] Draft `go.mod` module setup and dependencies
* [x] Scaffold entrypoint file (`main.go`)
* [ ] Commit initial code skeleton to `src/` directory

