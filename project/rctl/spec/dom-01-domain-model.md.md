[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[↖][home]

<h1 align="center">Rctl Specification</h1>

# Step 03: Domain Model


This document defines the core concepts, business rules, entity models, and relationships that govern the `rctl` problem space. It establishes a vocabulary and conceptual framework independent of specific CLI flags, Go packages, or database schemas.

---

## 1. Domain Concepts

* **Host:** A target computing instance (physical machine, virtual machine, or container) where operations are performed.
* **Environment:** The execution context and transport boundary of a Host (e.g., Local, SSH Remote).
* **Inventory:** A structured collection of Hosts grouped by environment, role, or administrative domain.
* **Command:** An ad-hoc binary execution or shell instruction dispatched to a Host within an Environment.
* **Result:** The execution outcome returned from a Host, including standard output (`stdout`), standard error (`stderr`), and exit code status.

---

## 2. Entity Models

```text
Inventory
  └── Host
        ├── Name
        ├── Environment (Type: Local | SSH)
        ├── Connection Parameters (Address, Port, User, Key)
        └── Metadata (Tags, Roles)

Execution Request
  ├── Host Reference
  └── Command
        ├── Working Directory
        └── Shell Arguments

Execution Result
  ├── Exit Code
  ├── Stdout Stream
  ├── Stderr Stream
  └── Duration

```

---

## 3. Entity Relationships

| Subject | Relationship | Object | Rule |
| --- | --- | --- | --- |
| **Inventory** | contains | **Host** | An inventory contains zero or more Hosts. |
| **Host** | bound to | **Environment** | Every Host belongs to exactly one Environment context. |
| **Command** | executed on | **Host** | A Command targets one or more Hosts simultaneously. |
| **Execution Request** | produces | **Execution Result** | Every execution attempt generates exactly one Execution Result per Host. |

---

## 4. Domain Rules

* **Environment Isolation:** Host address resolution and transport mechanisms belong strictly to the Environment layer; Commands remain transport-agnostic.
* **Result Immutability:** Once an Execution Result is captured, its streams and exit codes cannot be altered or re-executed.
* **Credential Decoupling:** Host definitions describe *how* to connect, but do not store hardcoded secrets directly in command definitions.

---

*Paused as requested. Update `lifecycle.log.md` when ready to proceed to Step 04 (Architecture).*