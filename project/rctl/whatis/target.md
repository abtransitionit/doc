
# Target (Where)

| Environment | Characteristics | Examples |
|---|---|---|
| **Local workstation** | Ephemeral, unprivileged, cross-OS | macOS, Linux, Windows, WSL |
| **Remote host** | Persistent, SSH-accessible | VPS, jump host, bastion |
| **Cloud tenant** | API-driven, IAM-scoped, regioned | AWS, GCP, Azure, OVH |
| **Private datacenter** | Network-isolated, hardware-aware | OpenStack, vSphere, bare metal |
| **Container runtime** | Namespaced, cgroup-limited | Docker, Podman, containerd |
| **Edge / IoT** | Intermittent connectivity, constrained | Raspberry Pi, industrial gateways |
| **CI/CD runner** | Short-lived, sandboxed, quota-bound | GitHub Actions, GitLab Runners |
| **Air-gapped** | No internet, mirrored registries | Defense, finance, regulated |

Each environment imposes different **authentication**, **networking**, **state durability**, and **failure semantics**—and often more than one at once (e.g., a CI runner in a cloud tenant provisioning a cluster on a private datacenter).

