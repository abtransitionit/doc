<!-- 
Task tracking
-->



# Backlog

## Active Phase: Implementation (Phase 5)

| ID | Task Description | Target Package | Related Specs / ADRs | Execution File | Status |
| :---: | :--- | :--- | :--- | :--- | :---: |
| **TASK-01** | Define core CLI command taxonomy | `src/pkg/cli` | [`REQ-01`](../spec/REQ-01-requirements.md) | [`TASK-01`](./task/TASK-01-cli-taxonomy.md) | In Review |
| **TASK-02** | Draft initial config schema spec | `src/pkg/config` | [`DOM-01`](../spec/DOM-01-domain-model.md) | [`TASK-02`](./task/TASK-02-config-schema.md) | In Review |
| **TASK-03** | Initialize Go module under `src/` | `src/` | [`SPEC-01`](../spec/SPEC-01-architecture.md) | [`TASK-03`](./task/TASK-03-init-go-module.md) | In Review |
| **TASK-04** | Define core execution domain interfaces | `src/pkg/core` | [`DOM-01`](../spec/dom-01-domain-model.md) | [`TASK-04`](./task/task-04.md) | In Review |
| **TASK-05** | Implement local process transport (`os/exec`) with non-root scope | `src/pkg/transport/local` | [`ADR-03`](../adr/ADR-03-statutory-non-root-local-scope.md) | — | Todo |
| **TASK-06** | Implement pure Go SSH transport adapter | `src/pkg/transport/ssh` | [`ADR-01`](../adr/ADR-01-pure-go-ssh-transport.md) | — | Todo |
| **TASK-07** | Build decoupled output formatters (table, raw stream, `--json`) | `src/pkg/cli/format` | [`ADR-02`](../adr/ADR-02-decoupled-output-formatting.md) | — | Todo |
| **TASK-08** | Wire CLI argument parser and inventory loader into main execution flow | `src/cmd/rctl` | [`REQ-01`](../spec/REQ-01-requirements.md), [`SPEC-01`](../spec/SPEC-01-architecture.md) | — | Todo |


---

## Future Phase Backlog

### Phase 6: Validation
* [ ] **VAL-01:** Unit test coverage for local transport stream boundaries.
* [ ] **VAL-02:** Integration test suite against mock SSH server.

### Phase 7: Release
* [ ] **REL-01:** Build cross-platform static binary assets (`v1.0.0`).