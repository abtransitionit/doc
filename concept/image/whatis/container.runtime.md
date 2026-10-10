[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Image][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[registry list]: ../list/registry.md
[tool whatis]: /concept//tool/whatis/ep.md
[container whatis]: #

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[List of registries][registry list]|

<h1 align="center">What is a Container Runtime</h1>

The concept of Container Runtime

# Definition
- a kind of [Tool][tool whatis] 
- a [Container][container whatis] provider 
- Create and manage [containerss][container whatis]
- Provides isolation of containerss from other containers that share the host OS.

# Container runtime
- Creates and manages containers by using OS-level isolation mechanisms:
  - **namespaces**           → isolate what processes can see
  - **cgroups**              → control resource usage
  - **filesystem isolation** → give the container its own filesystem view
  - **capabilities/security mechanisms** → restrict what processes can do

- Containers can be created directly or be an instance of container image. 
- Containers can simultaneously be seen as **Execution Environment** and **Host** (from the tool's perspective).
