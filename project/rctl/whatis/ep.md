[//]: #(home)
[home]: ../../README.md
[NEXT_TOPIC]: ../whatis/cli.md

[//]: #(doc)
[system whatis]: ../../../about/whatis/system.md

[//]: #(archl)
[acro list]:      ../list/acro.md
[arch whatis]:    ../whatis/arch.md
[adr list]:       ../list/adr.md
[roadmap whatis]: ../whatis/roadmap.md
[operate whatis]:  ../whatis/operate.md
[res whatis]:     ../whatis/res.md
[cli whatis]:     ../whatis/cli.md

[//]: #(functional)

[↖][home]

Related topics

| Topic | Location| Kind |
|-|-|-|
|[What is a resource][res whatis]|internal|functional|
|[what mean operating][operate whatis]|internal|functional|
|[What is cli][cli whatis]|internal|functional|
|[roadmap][roadmap whatis]|internal|planing|
|[architecture][arch whatis]|internal|design|



**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">rctl</h1>

<a id='system'></a>

# Definition

- A project concerning a tool for [operating][operate whatis] on named [resources][res whatis]
- The [code name](../../../tool/rctl/whatis/ep.md) of the [system][system whatis] that emerged from that project.
- The system/tool may rely on existing [resources][res whatis]


## Requirements
- coherent:
- extensible:
- unified CLI:




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


# All Documents
- [Roadmap][roadmap whatis]
- [ADRs][adr list]
- [Architecture][arch whatis]
- [Acronyms][acro list]
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