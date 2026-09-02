[//]: #(home)
[home]: ../../README.md

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
[provision whatis]: ../../../whatis/provision.md

[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a resource][res whatis]|internal
|[What is a host][host whatis]|internal
|[What is a provisioning][provision whatis]|internal
|[List of use case][usecase list]|internal
|[How-to for Forge][forge howto]|see



**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">RPro</h1>

# Definition


- A [system](#) for [provisioning][provision whatis] any kind of [resources][res whatis] on any kind of [hosts][host whatis].
- The [code name](../../../tool/metadoc/whatis/ep.md) of the [system](../whatis/system.md) that emerged from that project.
- The system/tool may rely on existing [resources][res whatis]



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