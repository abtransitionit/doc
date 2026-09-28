[//]: #(home)
[home]: ../../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Rctl Task</h1>


# TASK-02: Draft Initial Configuration Schema Spec

**TASK-02** (Config Schema): Fixes the inventory data structure (how hosts, IPs, keys, and environments are written in config files).


* **Status:** In Review
* **Assignee:** Lead Engineer
* **Target Package:** `src/pkg/config`
* **Governing Specs:** [`DOM-01`](../../spec/DOM-01-domain-model.md), [`SPEC-01`](../../spec/SPEC-01-architecture.md), [`ADR-01`](../../adr/ADR-01-pure-go-ssh-transport.md), [`ADR-03`](../../adr/ADR-03-statutory-non-root-local-scope.md)

---

## 1. Scratchpad & Ephemeral Notes

* **Format Selection:** Standardize on YAML for human readability and native Go map/struct tag mapping.
* **Scope Isolation:** Local host definition (`local`) must enforce non-root restrictions per `ADR-03`.
* **Transport Defaults:** Global SSH defaults (port `22`, default user, private key location) must be overridable at both group and host levels.
* **Authentication Fallbacks:** Support path-based identity files (`~/.ssh/id_rsa`) and explicit fallback to local SSH Agent sockets (`SSH_AUTH_SOCK`).

---

## 2. Canonical Inventory Schema Spec (`inventory.yaml`)

```yaml
version: "1"

# Global defaults inherited by all groups and hosts unless overridden
defaults:
  port: 22
  user: "deploy"
  identity_file: "~/.ssh/id_ed25519"
  connect_timeout: 10s

# Defined groups for targeted execution (e.g., `rctl exec --group web`)
groups:
  web:
    vars:
      environment: "production"
    hosts:
      - web01
      - web02

  db:
    vars:
      environment: "production"
    hosts:
      - db01

# Host inventory declaration
hosts:
  # Built-in local target (enforces non-root scope per ADR-03)
  local:
    transport: "local"

  # Standard remote targets using Go SSH transport (ADR-01)
  web01:
    hostname: "192.168.1.10"
    transport: "ssh"
    tags: ["prod", "web"]

  web02:
    hostname: "192.168.1.11"
    transport: "ssh"
    tags: ["prod", "web"]

  db01:
    hostname: "192.168.1.20"
    transport: "ssh"
    port: 2222                  # Host-level port override
    user: "postgres"            # Host-level user override
    identity_file: "~/.ssh/db_key"
    tags: ["prod", "db"]

```

---

## 3. Go Internal Data Model Representation (`src/pkg/config`)

```go
package config

import "time"

type Inventory struct {
	Version  string           `yaml:"version"`
	Defaults Defaults         `yaml:"defaults"`
	Groups   map[string]Group `yaml:"groups"`
	Hosts    map[string]Host  `yaml:"hosts"`
}

type Defaults struct {
	Port           int           `yaml:"port"`
	User           string        `yaml:"user"`
	IdentityFile   string        `yaml:"identity_file"`
	ConnectTimeout time.Duration `yaml:"connect_timeout"`
}

type Group struct {
	Vars  map[string]string `yaml:"vars"`
	Hosts []string          `yaml:"hosts"`
}

type Host struct {
	Hostname     string   `yaml:"hostname"`
	Transport    string   `yaml:"transport"` // "ssh" or "local"
	Port         int      `yaml:"port,omitempty"`
	User         string   `yaml:"user,omitempty"`
	IdentityFile string   `yaml:"identity_file,omitempty"`
	Tags         []string `yaml:"tags"`
}

```

---

## 4. Schema Validation Rules

1. **Unique Names:** Host and group identifiers must be unique alphanumeric strings (`[a-zA-Z0-9_-]+`).
2. **Transport Types:** `transport` field strictly limited to `ssh` or `local`.
3. **Local Scope Safeguard:** Host named `local` must have `transport: local`. Attempts to pass SSH identity files or custom ports to `local` fail validation.
4. **Group Reference Integrity:** Every host listed under `groups.<name>.hosts` must exist in the root `hosts` mapping.

---

## 5. Progress Checklist

* [x] Define YAML inventory document layout
* [x] Draft Go struct bindings for parsing
* [x] Establish group-to-host association model
* [x] Set explicit validation rules and safeguards
* [ ] Implement YAML parser and validator package in `src/pkg/config`

