[//]: #(Home)
[HOME]:  ../whatis/ep.md  

[//]: #(functional)
[forge whatis]: whatis/forge.md
[res list]:     list/res.md
[host list]:     list/host.md

[←][HOME]

<h1 align="center">rctl Roadmap</h1>

|id|Phase|description|
|-|-|-|
|1||Go + OpenTofu + Ansible|
|2||Identify the 1–10 Ansible capabilities users actually need|
|3||Implement those capabilities natively in Go if eliminating the Ansible dependency becomes valuable|
|4||Identify the 1–10 Terraform capabilities users actually need|
|5||Implement those capabilities natively in Go if eliminating the Ansible dependency becomes valuable|

# [←][README] Roadmap
| Phase                              |        Duration | Milestone                                      |
| ---------------------------------- | --------------: | ---------------------------------------------- |
| 0. Discovery & inventory           |          1 week | We understand what exists                      |
| 1. Architecture & UX               |          1 week | `rctl` design is frozen enough to implement    |
| 2. Core CLI foundation             |       1–2 weeks | `rctl` executable + command framework          |
| 3. Repository resource             |       2–3 weeks | Existing repo operations usable through `rctl` |
| 4. Registry / `doc` integration    |         2 weeks | Repository inventory becomes machine-readable  |
| 5. Distribution & release          |       1–2 weeks | Anyone can install/use a known version         |
| **Milestone: rctl v0.1**           | **~8–11 weeks** | **Useful daily tool**                          |
| 6. Resource abstraction validation |          1 week | Architecture proven against real usage         |
| 7. Image resource                  |         2 weeks | Images manageable through `rctl`               |
| 8. Container resource              |       2–3 weeks | Containers manageable through `rctl`           |
| 9. Relationships / graph           |       1–2 weeks | Resources can describe dependencies            |
| 10. Hardening & documentation      |                 |                                                |
