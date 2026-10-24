
[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../../whatis/ep.md

[↖ rms][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[cli howto]: /concept/tool/howto/ep.md#design-the-grammar-of-a-cli

<div align="center">

# Project RMS — Task01 - CLI - SPECIFICATIOn

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

Follows the [How-to: Design the Grammar of a CLI][cli howto].

# Syntax

```text
rctl [command] [subcommand] [global flags] [args...]

```



# Subcommand


# Inventory specification

## Canonical Inventory Schema Spec 

- filename: `inventory.yaml`

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


## Go Internal Data Model Representation

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


## Schema Validation Rules

1. **Unique Names:** Host and group identifiers must be unique alphanumeric strings (`[a-zA-Z0-9_-]+`).
2. **Transport Types:** `transport` field strictly limited to `ssh` or `local`.
3. **Local Scope Safeguard:** Host named `local` must have `transport: local`. Attempts to pass SSH identity files or custom ports to `local` fail validation.
4. **Group Reference Integrity:** Every host listed under `groups.<name>.hosts` must exist in the root `hosts` mapping.

# Ephemeral Notes


# Task Progression Checklist

* [ ] remove all ansible like section [Inventory specification](#inventory-specification)
* [ ] Implement YAML parser and validator package






<details>
<summary><h1>Document Metadata</h1></summary>

**Information**

| Property | Value |
|:--|:--|
| **Doc-ID**       | TASK-01-CLI-SPEC-RMS    |
| **Project**      | RMS                |
| **Path**         | `cli-01-spec.md` |
| **Last Updated** | 2026-10-20         |

**Revision History**

| Date | Version | Author | Summary |
|:--|:--|:--|:--|
| 2026-10-18 | `v0.1` | amar | Initial draft |

</details>


