[//]: #(Reference)
[HOME]:        ../../README.md
[forge howto]: ../howto/forge.md
[res list]:    ../list/res.md
[res whatis]:  ../whatis/res.md
[host list]:   ../list/host.md
[host whatis]: ../whatis/host.md
[arch whatis]: ../whatis/arch.md
[concept list]: ../list/concept.md
[usecase list]: ../list/usecase.md
[provision whatis]: ../whatis/provision.md

[←][HOME] Related topics
- [what is a resource][res whatis]
- [what is a host][host whatis]
- [what is a provisioning][provision whatis]
- [forge architecture][arch whatis]
- [list of concept][concept list]
- [list of use case][usecase list]

**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Forge</h1>

# Definition

## Purpose
Forge is a tool for provisioning any kind of [resources][res whatis] on any kind of [hosts][host whatis].

## Key Points
- the tool may rely on existing [resources][res whatis] and [hosts][host whatis]
- according to the context, **provision** often means: install, add, create or define



# Source code
- The tool is written in `golang`
- The following code repositories are involved

**Core**

- [Organization Core](https://github.com/abtransitionit/go-core)
- [Forge Core](https://github.com/abtransitionit/forge-core)

**Resource provider**
- [Forge Res](https://github.com/abtransitionit/forge-res)

**Providers**

- [Linux Provider](https://github.com/example/forge-provider-linux)
- [Kubernetes Provider](https://github.com/example/forge-provider-kubernetes)
- [AWS Provider](https://github.com/example/forge-provider-aws)

## Development and API documentation

- Go packages are documented using [`pkgsite`](https://pkg.go.dev/golang.org/x/pkgsite).
- The documentation lives alongside each code repository


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