[//]: #(home)
[home]:  ../README.md

[//]: #(functional)
[forge whatis]: whatis/forge.md
[res list]:     list/res.md
[host list]:     list/host.md
[roadmap readme]: roadmap.md

[←][home]

<h1 align="center">List of Forge ADR</h1>

# List

- [ADR-0001 — Resource Model](#adr-0001--resource-model)
- [ADR-0002 — Host Model](#adr-0001--host-model)
- [ADR-0002 — Provider Model](0002-provider-model.md)
- [ADR-0003 — State Management](0003-state-management.md)




# ADR-0001 — Resource Model

## Status

Accepted

## Context

Forge needs a common model for resources that can be provisioned across
different types of hosts.

## Decision

Resources will be represented by a common resource abstraction.

## Consequences

Resource implementations can remain independent from the provisioning engine.
Host-specific behavior can be implemented separately.