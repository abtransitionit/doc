[//]: #(Reference)
[README]:  ../../README.md
[forge howto]: ../howto/forge.md
[res list]:    ../list/res.md
[res whatis]:  ../whatis/res.md
[host list]:   ../list/host.md
[host whatis]: ../whatis/host.md
[arch whatis]: ../whatis/arch.md
[concept list]: ../list/concept.md
[usecase list]: ../list/usecase.md

# [←][README] Forge

## Purpose
Forge is a tool for provisioning any kind of resources on any kind of hosts.

## Key Points
- the tool may rely on existing resources and hosts
- The resource may be physical, virtual or abstract (concept to defined)
- The host may be physical or virtual (concept to defined)
- at first approximation, *provision* means: install, add, create or define

---

# Status

- Early development.
- The project is currently defining its core concepts and architecture.


# Documentation
- [what is a resource][res whatis]
- [what is a host][host whatis]
- [forge architecture][arch whatis]
- [list of concept][concept list]
- [list of use case][usecase list]


---

# Repositories

## Core

- [Organization Core](https://github.com/abtransitionit/go-core)
- [Forge Core](https://github.com/abtransitionit/forge-core)

## Resource provider
- [Forge Res](https://github.com/abtransitionit/forge-res)

## Providers

- [Linux Provider](https://github.com/example/forge-provider-linux)
- [Kubernetes Provider](https://github.com/example/forge-provider-kubernetes)
- [AWS Provider](https://github.com/example/forge-provider-aws)

## Development and API documentation

- Go packages are documented using [`pkgsite`](https://pkg.go.dev/golang.org/x/pkgsite).
- The documentation lives alongside each repo


## Documentation

- [howto for Forge][forge howto]
- [List of resource][res list]
- [List of host][host list]
- [Roadmap][roadmap whatis]
- [ADRs][adr list]
-
- [Concept](docs/concept.md)
- [Architecture](docs/architecture.md)
- [Requirements](docs/requirements.md)
- [Architecture Decision Records](adr/)


## provisioning

- [forge howto][forge howto]
- [list of resource][res list]
- [list of host][host list]

## Risk and protection

- [Threats](threats.md)
- [Prevention](prevention.md)
- [Resilience](resilience.md)

## Governance

- [Governance](governance.md)