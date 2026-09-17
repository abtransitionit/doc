[//]: #(home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[forge howto]: ../howto/forge.md
[res list]:    ../list/res.md
[res whatis]:  ../whatis/res.md
[host list]:   ../list/host.md
[host whatis]: ../whatis/host.md
[arch whatis]: ../whatis/arch.md

[←][home]

<h1 align="center">Forge Architecture</h1>
 

---

# Host Access

`Forge` may provision a host through different access mechanisms:

- SSH
- Agent
- WinRM
- Host-specific APIs
- Other mechanisms as required

The access mechanism is independent from the resource being provisioned.

---
 
# Repository Architecture

Forge is implemented across multiple Go repositories.

|go repo|description|
|-|-|
|`go-core`| <li>provides common Go components shared by Go projects across the organization.<li>Not specific to `Forge`.|
|`forge-core`| <li>provides common components shared by Go projects that are part of the `Forge` ecosystem.<li>It contains `Forge`-specific functionality that should not be duplicated across `Forge`-related Go projects.|

## Forge components

Other Go repositories implement specific Forge components and depend on `forge-core` and, where required, `go-core`.
```
        go-core
        ↑
        │
    forge-core
    ↑    ↑    ↑
    │    │    │
forge-a forge-b forge-c
```          