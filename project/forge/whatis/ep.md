[//]: #(Home)
[HOME]: ../../README.md

[//]: #(archl)
[arch whatis]: ../whatis/arch.md
[adr list]:    ../list/adr.md

[//]: #(functional)
[forge howto]: ../howto/forge.md
[roadmap whatis]: ../whatis/roadmap.md
[res list]:    ../list/res.md
[res whatis]:  ../whatis/res.md
[host list]:   ../list/host.md
[host whatis]: ../whatis/host.md
[usecase list]: ../list/usecase.md
[provision whatis]: ../whatis/provision.md

[←][HOME] Related topics
|||
|-|-|
|[what is a resource][res whatis]|internal
|[what is a host][host whatis]|internal
|[what is a provisioning][provision whatis]|internal
|[list of use case][usecase list]|internal
|[howto for Forge][forge howto]|see



**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Forge</h1>

# Definition

## Purpose
Forge is a tool for [provisioning][provision whatis] any kind of [resources][res whatis] on any kind of [hosts][host whatis].

## Key Points
- the tool may rely on existing [resources][res whatis] and [hosts][host whatis]



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


# Other Documents
- [Roadmap][roadmap whatis]
- [ADRs][adr list]
- [Architecture][arch whatis]
- [Concept](docs/concept.md)
- [Architecture](docs/architecture.md)
- [Requirements](docs/requirements.md)
- [Architecture Decision Records](adr/)



## Risk and protection

- [Threats](threats.md)
- [Prevention](prevention.md)
- [Resilience](resilience.md)

## Governance

- [Governance](governance.md)