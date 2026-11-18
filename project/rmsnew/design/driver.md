[//]: # (home)
[home doc]:    ../../../README.md
[home domain]: ../../README.md
[home topic]:  ../whatis/ep.md

[↖ Project][home topic] · [↖ Projects][home domain] · [↖ Doc][home doc]

[//]: # (doc)

<div align="center">

# Project RMS — Design - The Driver


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# The Path-Based Driver Registry

How the driver registry handles hierarchical paths and fallback (`kind/kind1/kind2/...`)

**Requirement**: If a driver for `file/bin/tgz` isn't found, the system should automatically check for a driver for `file/bin`, then oine for `file`.


## Step 1: 


```go
package registry

import (
	"strings"
)

// Driver represents our standard interface for resource operations
type Driver interface {
	Name() string
	// Operations will be defined next, keeping them separate from resource data
}

type Registry struct {
	drivers map[string]Driver
}

func NewRegistry() *Registry {
	return &Registry{
		drivers: make(map[string]Driver),
	}
}

// Register stores a driver under its path, e.g., "file/bin/tgz" or "kernel/module"
func (r *Registry) Register(path string, driver Driver) {
	r.drivers[path] = driver
}

// Lookup finds the most specific driver, falling back up the tree if necessary.
// e.g., searching for "file/bin/tgz" will check:
// 1. "file/bin/tgz"
// 2. "file/bin"
// 3. "file"
func (r *Registry) Lookup(resourceTypePath string) (Driver, string, bool) {
	segments := strings.Split(resourceTypePath, "/")

	// Walk backwards down the hierarchy
	for i := len(segments); i > 0; i-- {
		currentPath := strings.Join(segments[:i], "/")
		if driver, exists := r.drivers[currentPath]; exists {
			return driver, currentPath, true
		}
	}

	return nil, "", false
}

```

## Step 2: 


Step 2 focuses on **how operations map onto the `Driver` interface** while keeping them strictly separate from the static `Resource` definition—and without forcing every driver to implement verbs that make no sense for it (like trying to `list` a single kernel parameter).


### The Base `Driver` Contract

In Go, the cleanest way to achieve this is a **hybrid capability model**: a tiny required base interface paired with optional, fine-grained operation interfaces (similar to how `io.Reader` and `io.Writer` work in the Go standard library).

Every driver, whether built into the core or loaded as a dynamic plugin, must satisfy a minimal baseline:
- knowing its identity
- exposing which operations it supports.

```go
package driver

import (
	"context"
)

// Operation represents a standardized verb (e.g., "read", "write", "inspect", "load", "unload").
type Operation string

// Resource is the static, state-free definition passed into operations.
type Resource struct {
	Type       string         // e.g., "kernel/module"
	Name       string         // e.g., "overlay-module"
	Attributes map[string]any // Static configuration only
}

// Result captures the outcome of an operation for logging and auditing.
type Result struct {
	Changed bool
	Output  string
	Data    map[string]any
}

// Driver is the minimal contract all core and plugin drivers must implement.
type Driver interface {
	Name() string
	Capabilities() []Operation
	Execute(ctx context.Context, op Operation, res Resource) (Result, error)
}

```

### 2. Optional Standardized Verb Interfaces (For Built-In & Typed Drivers)

To keep shared terms consistent across the codebase (as you noted: `read`, `write`, `inspect`, `list`, etc.) without bloating every driver with stub methods, we define small single-method interfaces in the SDK:

```go
type Inspector interface {
	Inspect(ctx context.Context, res Resource) (Result, error)
}

type Reader interface {
	Read(ctx context.Context, res Resource) (Result, error)
}

type Writer interface {
	Write(ctx context.Context, res Resource) (Result, error)
}

type Lister interface {
	List(ctx context.Context, res Resource) (Result, error)
}

```

### Why this fits your design:

* **Zero State Pollution:** `Resource` stays pure data. The operation (`op Operation`) is passed explicitly alongside it at runtime.
* **Custom + Shared Verbs:** `Execute(ctx, op, res)` accepts *any* operation string (like `"load"` or `"unload"` for `kernel/module`), while standard verbs (`"inspect"`, `"read"`, `"write"`) can be routed cleanly to the typed interfaces (`Inspector`, `Reader`, `Writer`) if the driver implements them.
* **Plugin-Friendly:** Dynamic plugins over RPC or gRPC only need to serialize `(op, res) -> (Result, error)` rather than maintaining dozens of rigid RPC endpoints.
### TODO ???? Why this first step matters:

* **Decoupled Registration:** Core drivers and dynamic plugins can register themselves into this registry using standard path strings.
* **Graceful Fallback:** If a specialized driver isn't loaded yet, it gracefully drops back to a broader category handler instead of crashing.