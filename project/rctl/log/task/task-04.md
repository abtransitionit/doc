# TASK-04: Define Core Execution Domain Interfaces

* **Status:** In Review
* **Assignee:** Lead Engineer
* **Target Package:** `src/pkg/core`
* **Governing Specs:** [`DOM-01`](../../spec/DOM-01-domain-model.md), [`SPEC-01`](../../spec/SPEC-01-architecture.md)

---

## 1. Scratchpad & Ephemeral Notes

* **Interface Decoupling:** The core domain must remain completely decoupled from specific transport mechanisms (SSH vs Local `os/exec`). Transports implement the `Executor` interface.
* **Streaming & Observability:** Output streams (`stdout`, `stderr`) must support real-time chunked execution results or buffered final returns to accommodate both interactive and `--json` outputs.
* **Context Propagation:** All execution signatures must accept `context.Context` to handle timeouts, cancellation signals, and trace propagation gracefully.

---

## 2. Proposed Interface & Domain Model (`src/pkg/core`)

```go
package core

import (
	"context"
	"io"
	"time"
)

// Command represents an immutable execution payload targeting a host.
type Command struct {
	ID         string            `json:"id"`
	RawCommand string            `json:"command"`
	Env        map[string]string `json:"env,omitempty"`
	Timeout    time.Duration     `json:"timeout"`
}

// Result captures the outcome of a completed or failed command execution.
type Result struct {
	CommandID string        `json:"command_id"`
	Host      string        `json:"host"`
	ExitCode  int           `json:"exit_code"`
	Stdout    string        `json:"stdout"`
	Stderr    string        `json:"stderr"`
	Duration  time.Duration `json:"duration"`
	Error     error         `json:"error,omitempty"`
}

// StreamOptions provides writers for real-time output capture.
type StreamOptions struct {
	StdoutWriter io.Writer
	StderrWriter io.Writer
}

// Executor defines the core contract that all transport engines (SSH, Local) must implement.
type Executor interface {
	// Execute executes a command on a remote or local target synchronously.
	Execute(ctx context.Context, cmd Command) (Result, error)

	// StreamExecute executes a command while streaming output in real time to provided writers.
	StreamExecute(ctx context.Context, cmd Command, opts StreamOptions) (Result, error)
}
```

---

## 3. Progress Checklist

* [x] Draft `Command` value object struct
* [x] Draft `Result` and `StreamOptions` execution models
* [x] Define `Executor` interface signature
* [ ] Implement core interfaces under `src/pkg/core/`


