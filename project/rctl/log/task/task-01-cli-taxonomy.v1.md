# TASK-01: Define Core CLI Command Taxonomy

**TASK-01** (Taxonomy): Fixes the user interface boundary (rctl exec --host ..., rctl inventory list).



* **Status:** In Progress
* **Assignee:** Lead Engineer
* **Target Package:** `src/pkg/cli`
* **Governing Docs:** [`REQ-01`](../../spec/REQ-01-requirements.md), [`SPEC-01`](../../spec/SPEC-01-architecture.md)

---

## 1. Scratchpad & Ephemeral Notes

* Need subcommands for both execution and inventory management: `rctl exec` and `rctl inventory`.
* Global flags vs. command flags: `--json` and `--verbose` should be global flags accessible on root.
* Target selection syntax: allow passing host alias directly (`--host web01`) or group tags (`--group prod`).

---

## 2. Proposed Interface Draft

```bash
# Ad-hoc execution
rctl exec --host web01 "uptime"
rctl exec --group prod --json "systemctl status nginx"

# Inventory operations
rctl inventory list
rctl inventory validate --config ./inventory.yaml
```

3. Progress Checklist
```
[x] Define root flags (--json, --verbose, --config)
[ ] Draft exec subcommand syntax and flag matrix
[ ] Draft inventory subcommand syntax
[ ] Validate taxonomy against functional requirements in REQ-01
```