[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[container runtime whatis]: ../whatis/container.runtime.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a Container Runtime][container runtime whatis]|

<h1 align="center">List of Container Runtime</h1>

The concept of Container Runtime


# List of Container Runtime <a id='runtime'></a>

Well-known container runtime


| Runtime | Daemon? | Rootless? | Made by | Typical use |
|---------|---------|-----------|---------|-------------|
| **Docker Engine** | ✅ `dockerd` | partial | Docker Inc | dev, small prod |
| **Podman** | ❌ daemonless | ✅ first-class | Red Hat | rootless, systemd, RHEL |
| **containerd** | ✅ | ✅ | CNCF | k8s, Docker's engine |
| **CRI-O** | ✅ | ✅ | Red Hat/CNCF | Kubernetes only |
| **runc / crun / youki** | ❌ | — | OCI community | low-level, used by all above |
| **Kata Containers** | ✅ | — | OpenInfra | VM-grade isolation |
| **gVisor** | ✅ | — | Google | syscall interception |


```
🐧 LINUX KERNEL (namespaces + cgroups + security)
 │
 ├── 🔧 LOW-LEVEL RUNTIMES   (actually spawn the container process)
 │    ├── runc          ← reference implementation (OCI)
 │    ├── crun          ← faster, C-written runc
 │    ├── youki         ← Rust
 │    └── kata-runtime  ← runs containers inside a lightweight VM
 │
 ├── 🎛️  HIGH-LEVEL RUNTIMES  (manage images, lifecycle) - all speak OCI
 │    ├── containerd    ← used BY Docker, k8s, etc.
 │    ├── CRI-O         ← Kubernetes-native
 │    ├── Podman        ← daemonless, rootless-first
 │    └── Docker Engine ← containerd + CLI + extras
 │
 └── 🚀 ORCHESTRATORS / CLIs
      ├── Kubernetes     ← talks to containerd / CRI-O
      ├── Docker Compose
      ├── Podman + podman-compose
      └── Nomad, ECS, etc.
```

**OCI** (Open Container Initiative) is the standard that lets these mix — image format + runtime spec.

