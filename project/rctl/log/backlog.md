<!-- 
Task tracking
-->



# Backlog

## Active Phase: Implementation (Phase 5)


# Backlog

## Active Phase: Implementation (Phase 5)

| ID | Task Description | Target Package | Related Specs / ADRs | Status |
| :---: | :--- | :--- | :--- | :---: |
| **task-01** | Define core CLI command taxonomy | `src/pkg/cli` | [`REQ-01`](../spec/REQ-01-requirements.md) | [`task-01`](./task/task-01-cli-taxonomy.md) | In Progress |
| **task-02** | Draft initial config schema spec | `src/pkg/config` | [`DOM-01`](../spec/DOM-01-domain-model.md) | [`task-02`](./task/task-02-config-schema.md) | Todo |
| **task-03** | Initialize Go module under `src/` | `src/` | [`SPEC-01`](../spec/SPEC-01-architecture.md) | — | Todo |
| **task-04** | Define core execution interfaces | `src/pkg/core` | [`DOM-01`](../spec/DOM-01-domain-model.md) | — | Todo |
| **task-05** | Implement local process transport (`os/exec`) | `src/pkg/transport/local` | [`ADR-03`](../adr/ADR-03-statutory-non-root-local-scope.md) | Todo |
| **task-06** | Implement pure Go SSH transport adapter | `src/pkg/transport/ssh` | [`ADR-01`](../adr/ADR-01-pure-go-ssh-transport.md) | Todo |
| **task-07** | Build decoupled output formatters (table, raw stream, `--json`) | `src/pkg/cli/format` | [`ADR-02`](../adr/ADR-02-decoupled-output-formatting.md) | Todo |
| **task-08** | Wire CLI argument parser and inventory loader into main execution flow | `src/cmd/rctl` | [`REQ-01`](../spec/REQ-01-requirements.md) | Todo |


---
---
---
---


| ID | Task Description | Target Package | Related Specs / ADRs | Status |
| :---: | :--- | :--- | :--- | :---: |
| **task-01** | Define core CLI command taxonomy (commands, flags, subcommands) | `src/pkg/cli` | [`REQ-01`](../spec/REQ-01-requirements.md), [`SPEC-01`](../spec/SPEC-01-architecture.md) | Todo |
| **task-02** | Draft initial configuration schema spec (inventory YAML/TOML parser) | `src/pkg/config` | [`DOM-01`](../spec/DOM-01-domain-model.md), [`SPEC-01`](../spec/SPEC-01-architecture.md) | Todo |
| **task-03** | Initialize Go module and package structure under `src/` | `src/` | [`SPEC-01`](../spec/SPEC-01-architecture.md) | Todo |
| **task-04** | Define core execution domain interfaces (`Executor`, `Command`, `Result`) | `src/pkg/core` | [`DOM-01`](../spec/DOM-01-domain-model.md) | Todo |





## Future Phase Backlog

### Phase 6: Validation
* [ ] **VAL-01:** Unit test coverage for local transport stream boundaries.
* [ ] **VAL-02:** Integration test suite against mock SSH server.

### Phase 7: Release
* [ ] **REL-01:** Build cross-platform static binary assets (`v1.0.0`).



----
----
----
----
----
----
----


# rctl Task Backlog

- [ ] Define core CLI command taxonomy
- [ ] Draft initial configuration schema spec
- [ ] Implement initial Go CLI stub



# Task Backlog

## Phase 5: Implementation Tasks

| ID | Task Description | Target Package | Related Specs / ADRs | Status |
| :---: | :--- | :--- | :--- | :---: |
| **task-01** | Initialize Go module and package structure under `src/` | `src/` | [`SPEC-01`](../spec/SPEC-01-architecture.md) | Todo |
| **task-02** | Define core execution domain interfaces (`Executor`, `Command`, `Result`) | `src/pkg/core` | [`DOM-01`](../spec/DOM-01-domain-model.md), [`SPEC-01`](../spec/SPEC-01-architecture.md) | Todo |
| **task-03** | Implement local process transport (`os/exec`) with non-root scope | `src/pkg/transport/local` | [`ADR-03`](../adr/ADR-03-statutory-non-root-local-scope.md) | Todo |
| **task-04** | Implement pure Go SSH transport adapter | `src/pkg/transport/ssh` | [`ADR-01`](../adr/ADR-01-pure-go-ssh-transport.md) | Todo |
| **task-05** | Build decoupled output formatters (table, raw stream, `--json`) | `src/pkg/cli/format` | [`ADR-02`](../adr/ADR-02-decoupled-output-formatting.md) | Todo |
| **task-06** | Wire CLI argument parser and inventory loader into main execution flow | `src/cmd/rctl` | [`REQ-01`](../spec/REQ-01-requirements.md), [`SPEC-01`](../spec/SPEC-01-architecture.md) | Todo |