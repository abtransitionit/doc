[//]: #(Home)
[home]: ../../README.md
[NEXT_TOPIC]: ../whatis/cli.md
[//]: #(archl)
[acro list]:      ../list/acro.md
[arch whatis]:    ../whatis/arch.md
[adr list]:       ../list/adr.md
[roadmap whatis]: ../whatis/roadmap.md
[manage whatis]:  ../whatis/manage.md
[res whatis]:     ../whatis/res.md
[cli whatis]:     ../whatis/cli.md

[//]: #(functional)

[↖][home]

Related topics

|Topic / Artifact|Location|Kind|
|-|-|-|
|[what is a resource][res whatis]|internal|functional|
|[what mean managing][manage whatis]|internal|functional|
|[what is cli][cli whatis]|internal|functional|
|[roadmap][roadmap whatis]|internal|planing|
|[architecture][arch whatis]|internal|design|



**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">rctl</h1>

# Definition

## Purpose
A unified [CLI][cli whatis] for [managing][manage whatis] named [resources][res whatis] and their relationships across development ecosystem (repositories, images, containers, and more).


A coherent, extensible [CLI][cli whatis] for operating on a given ecosystem of named resources

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