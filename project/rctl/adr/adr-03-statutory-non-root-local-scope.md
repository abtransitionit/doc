[//]: #(home)
[home]: ./README.md

[//]: #(doc)

[←][home]

<h1 align="center">Rctl ADR 03: Statutory Non-Root Local Scope</h1>


* **Status:** Accepted
* **Date:** 2026-09-17
* **Deciders:** Core Engineering Team
* **Relates To:** [`C02`](../spec/REQ-01-requirements.md), [`SPEC-01-architecture.md`](../spec/SPEC-01-architecture.md)

---

## Context & Problem Statement

`rctl` executes ad-hoc commands on local environments as well as remote targets. We need to decide whether local execution can attempt privilege escalation (e.g., auto-invoking `sudo`) or strictly operate within the invoking user's local security context.

---

## Decision Drivers

* **C02 (Least Privilege):** Prevent accidental system manipulation or security degradation on the operator's machine.
* **Predictable Execution:** Local execution behavior must match standard non-interactive user shell execution.
* **Auditability:** Command outcomes should reflect exact user permissions without silent elevation.

---

## Considered Options

1. **Option 1:** Built-in privilege escalation logic (`sudo` fallback) inside the local transport.
2. **Option 2:** Enforce statutory non-root scope for local operations; user-driven elevation must be explicit in command strings if needed.

---

## Decision Outcome

**Chosen Option:** Option 2 (Statutory Non-Root Local Scope).

### Positive Consequences

* **Security Isolation:** Guarantees `rctl` cannot unintentionally alter system state outside the calling user's OS permissions.
* **Transport Simplicity:** The local adapter directly wraps OS process execution (`os/exec`) without managing password prompts or credential caches.

### Negative Consequences

* Operations requiring elevated permissions must be explicitly passed in the execution string by the user (e.g., `rctl exec local "sudo systemctl restart service"`).