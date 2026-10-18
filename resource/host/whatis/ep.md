[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Resource][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[concept host whatis]: /concept/machine/whatis/host.md

<h1 align="center">What is a Host</h1>


# Definition
cf. the concept of [Host][concept host whatis]

# Distinguis
- Access the OS: to provision things inside
- Manage the host (lifecycle) by create, stop, start it

# Concept

- remote execution
- layered abstractions
- composability
- execution contexts
- infrastructure orchestration
- command dispatching

# Model
- where an **operation** on a resource should happen separately from how to reach the place where it should happen.

# Example
```ini
# Generic
Action → Mechanism → Execution Target → Transport / wrapperetc. 
```
```yaml
# Example: Load kernel module
Action:    Load kernel module
Mechanism: modprobe
Target:    OS
Transport: , container exec, Kubernetes exec, etc.
 - Local machine: modprobe foo
 - SSH Remote VM: ssh host modprobe foo
 - Container on SSH Remote VM: ssh host docker exec container modprobe foo
 - Pod on SSH Remote VM: ssh host kubectl exec pod -- modprobe foo
```

> 🔆 Discover all possible transport for specific resource. xample file => git, S3, http, ...

> 🔆 Idea choose the best mechanism for the target => the one who simplified ??


# Kind
```
Host                         → capabilities → inspect, configure, start, stop
├── Virtual                  → inherited
│   ├── VM                   → inherited + snapshot, clone, migrate
│   └── Container            → inherited + exec, attach, image-based-deploy
│       ├── Docker           → inherited + docker-specific
│       ├── OCI              → inherited + OCI-specific
│       └── ...
├── Physical                 → inherited
│   └── BareMetal            → inherited + power-control, firmware-config,
│                              hardware-inventory
├── Cluster                  → inherited + schedule, scale, orchestrate
│   ├── Kubernetes           → inherited + deploy, rollout, manage-pods
│   ├── DockerSwarm          → inherited + service-management
│   └── ...
├── Cloud                    → inherited + provision, tag, resize
│   ├── ComputeInstance      → inherited + instance-specific
│   ├── ManagedContainer     → inherited + service-specific
│   └── ...
└── ...
```

```
Host
├── Location
│   ├── Local
│   └── Remote
│
├── Access
│   ├── Shell
│   │   ├── SSH
│   │   ├── LocalShell
│   │   ├── WinRM
│   │   └── SerialConsole
│   ├── Agent
│   │   ├── HostAgent
│   │   └── ManagementAgent
│   ├── API
│   │   ├── REST
│   │   ├── gRPC
│   │   └── ProviderAPI
│   └── OutOfBand
│       ├── IPMI
│       ├── Redfish
│       └── HypervisorAPI
│
├── Connectivity
│   ├── Direct
│   ├── ViaProxy
│   ├── ViaBastion
│   ├── ViaVPN
│   └── ViaTunnel
│
└── Authentication
    ├── SSHKey
    ├── Password
    ├── Certificate
    ├── Token
    └── FederatedIdentity
```    


```
Host
├── Location
│   ├── Local
│   └── Remote
│
├── Access
│   ├── Shell
│   │   ├── SSH
│   │   ├── LocalShell
│   │   ├── WinRM
│   │   └── SerialConsole
│   ├── Agent
│   │   ├── HostAgent
│   │   └── ManagementAgent
│   ├── API
│   │   ├── REST
│   │   ├── gRPC
│   │   └── ProviderAPI
│   └── OutOfBand
│       ├── IPMI
│       ├── Redfish
│       └── HypervisorAPI
│
├── Connectivity
│   ├── Direct
│   ├── ViaProxy
│   ├── ViaBastion
│   ├── ViaVPN
│   └── ViaTunnel
│
└── Authentication
    ├── SSHKey
    ├── Password
    ├── Certificate
    ├── Token
    └── FederatedIdentity
```

```
Host
  → capabilities
      ├── inspect
      ├── configure
      ├── start
      ├── stop
      ├── restart
      └── access

ExecutionEnvironment
├── Container
│   ├── DockerContainer
│   └── OCIContainer
├── VirtualMachine
│   ├── KVM
│   ├── HyperV
│   └── VMwareVM
└── BareMetal
    ├── PhysicalServer
    └── Workstation

HostGroup
├── Cluster
├── Fleet
└── NodePool
```

Then add capabilities according to what each concrete type actually supports:

| Kind             | Additional capabilities                                  |
| ---------------- | -------------------------------------------------------- |
| `Container`      | `exec`, `attach`, `inspect-logs`, `manage-resources`     |
| `VirtualMachine` | `snapshot`, `clone`, `resize`, `migrate`                 |
| `BareMetal`      | `hardware-inventory`, `firmware-config`, `power-control` |
| `Cluster`        | `schedule`, `orchestrate`, `scale`, `manage-members`     |
| `CloudInstance`  | `provision`, `resize`, `tag`, `terminate`                |

I'd also distinguish capabilities from lifecycle operations: `stop` may be available on a VM but not on a physical host unless you have out-of-band management such as `IPMI` or `Redfish`.


I'd model this as a taxonomy of host location, access mechanisms, and connectivity, separate from the `Host → Container / VM / BareMetal` kind hierarchy.

```
Host
├── Location
│   ├── Local
│   └── Remote
│
├── Access
│   ├── Shell
│   │   ├── SSH
│   │   ├── LocalShell
│   │   ├── WinRM
│   │   └── SerialConsole
│   ├── Agent
│   │   ├── HostAgent
│   │   └── ManagementAgent
│   ├── API
│   │   ├── REST
│   │   ├── gRPC
│   │   └── ProviderAPI
│   └── OutOfBand
│       ├── IPMI
│       ├── Redfish
│       └── HypervisorAPI
│
├── Connectivity
│   ├── Direct
│   ├── ViaProxy
│   ├── ViaBastion
│   ├── ViaVPN
│   └── ViaTunnel
│
└── Authentication
    ├── SSHKey
    ├── Password
    ├── Certificate
    ├── Token
    └── FederatedIdentity
```

## Suggested capability-oriented model

Rather than treating these as strict inheritance branches, I'd represent them as independent dimensions:

| Dimension        | Examples                                      |
| ---------------- | --------------------------------------------- |
| `Kind`           | `Container`, `VM`, `BareMetal`                |
| `Location`       | `Local`, `Remote`                             |
| `AccessProtocol` | `SSH`, `WinRM`, `HTTP`, `gRPC`, `Serial`      |
| `ConnectionPath` | `Direct`, `Proxy`, `Bastion`, `VPN`, `Tunnel` |
| `Authentication` | `SSHKey`, `Password`, `Certificate`, `Token`  |
| `Management`     | `Agent`, `Agentless`, `ProviderManaged`       |
| `Reachability`   | `Online`, `Offline`, `Unknown`                |
| `Privilege`      | `User`, `Administrator`, `Root`, `Restricted` |

For example, a remote Linux VM might be described as:

```yaml
kind: VM
location: Remote
access:
  protocol: SSH
  connection: Bastion
  authentication: SSHKey
management: Agentless
reachability: Online
privilege: Root
```

A local container might be:

```yaml
kind: Container
location: Local
access:
  protocol: DockerAPI
  connection: Direct
management: Agent
reachability: Online
privilege: Restricted
```

- `Local` does not necessarily mean `Direct`
- `Remote` does not necessarily mean `SSH`. 
- A **remote** host might be managed through an API or agent
- A **local** VM might be accessed through a hypervisor API.
- therefore `Kind`, `Location`, and `Access` are orthogonal
- and capabilities is used to determine which **operations** are available.


# Model Idea

- where the host **runs** from how you manage or access it. 
- In your case, `Local` / `Remote` may be less useful than 
- a taxonomy based on the management interface, such as an `agent`, `CLI`, or `API`.

## 1. Host management / access taxonomy

```
Access
├── Local
│   ├── Process       → execute commands directly
│   └── Socket        → Unix socket, named pipe
│
├── Agent
│   ├── CLI           → agent-specific command interface
│   ├── API           → HTTP, gRPC
│   └── Protocol      → custom RPC, message channel
│
├── Remote
│   ├── Shell
│   │   ├── SSH
│   │   └── WinRM
│   ├── CLI           → remote command execution
│   └── API           → REST, gRPC
│
├── Hypervisor
│   ├── CLI           → virsh, govc
│   └── API           → libvirt, vSphere
│
├── CloudProvider
│   ├── CLI           → provider CLI
│   └── API           → provider API
│
└── OutOfBand
    ├── IPMI
    ├── Redfish
    └── SerialConsole
```

## 2. Where does physical location belong?

I'd make physical location a separate, optional property rather than a subtype of access:

```
Host
├── Kind
│   ├── Container
│   ├── VM
│   └── BareMetal
│
├── Placement
│   ├── LocalMachine
│   ├── DataCenter
│   ├── Edge
│   └── CloudRegion
│
└── Management
    ├── Agent
    ├── SSH
    ├── WinRM
    ├── HypervisorAPI
    ├── CloudAPI
    └── OutOfBand
```

Here, `Placement` describes where it runs, while `Management` describes how you control it.

## 3. My recommendation: model the access mechanism as a strategy

If your goal is to provide a **common interface** for operations such as `inspect`, `execute`, `start`, `stop`, and `copy`, I'd use a model like this:

```
Host
├── Identity
├── Kind
├── Placement
└── AccessStrategy
    ├── LocalProcess
    ├── SSH
    ├── WinRM
    ├── AgentCLI
    ├── AgentAPI
    ├── HypervisorAPI
    ├── CloudAPI
    └── OutOfBandAPI
```

Each strategy exposes the capabilities it actually supports:

```
SSH
  → execute, copy, inspect

AgentAPI
  → execute, inspect, stream-logs

HypervisorAPI
  → inspect, start, stop, snapshot

CloudAPI
  → inspect, start, stop, provision, delete
```

One important nuance: 
- CLI and API are interface styles, not necessarily access mechanisms. 
- An **agent** can expose both a `CLI` and an `API`
- SSH can provide shell execution and file transfer
- a cloud provider API can manage a VM without providing shell access to that VM.

I'd therefore use `AccessStrategy` (or `ManagementInterface`) as the abstraction and let each implementation declare its **supported capabilities**. This avoids conflating the host's physical location, its runtime kind, and the way it is managed.


## 2. Not every wrapper is a transport

Your examples reveal a useful distinction.

| Wrapper category          | Examples                     | What it does                               |
| ------------------------- | ---------------------------- | ------------------------------------------ |
| Remote connection         | SSH, WinRM                   | Connects to another machine                |
| Jump / routing            | SSH bastion, proxy           | Routes access through an intermediary      |
| Container entry           | `docker exec`, `podman exec` | Enters a container's execution context     |
| Orchestration entry       | `kubectl exec`               | Executes a command inside a pod            |
| Virtualization management | Hypervisor API               | Controls a VM through its management layer |
| Privilege escalation      | `sudo`, `doas`               | Changes the execution privilege context    |

These mechanisms aren't all transports in the strict networking sense. `sudo`, for example, doesn't transport you anywhere.

I'd therefore consider using `TargetWrapper` as the general concept, with `Transport` as one possible category.

```
TargetWrapper
├── Transport
│   ├── SSH
│   └── WinRM
├── Routing
│   └── Bastion
├── ExecutionContext
│   ├── DockerExec
│   └── KubernetesExec
└── PrivilegeContext
    └── Sudo
```

This is a provisional classification; some mechanisms can serve multiple roles depending on how they're used.
