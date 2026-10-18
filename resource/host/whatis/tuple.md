[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Resource][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[concept host whatis]: /concept/machine/whatis/host.md

<h1 align="center">What is a Host Tuple</h1>

Concept of Host tuple

# Definition

## 1. Kind — what is a host?

A host is a **kind** of execution environments or machines

```
Host
├── ExecutionEnvironment
│   ├── Container
│   └── VM
├── PhysicalMachine
│   └── BareMetal
└── ...
```


## 2. Mechanism — how do we manage the host?

```
Mechanism
├── Local
│   └── Process
├── Remote
│   ├── SSH
│   └── WinRM
├── Agent
│   ├── CLI
│   └── API
├── Hypervisor
│   ├── CLI
│   └── API
├── CloudProvider
│   ├── CLI
│   └── API
└── OutOfBand
    ├── IPMI
    └── Redfish
```

Question:
- `Local` and `Remote` describe the connection context
- `SSH`, `Agent`, and `CloudProvider` describe different access or management mechanisms. 
- We may want to separate those later.

## 3. Capabilities — what can we do with it?

```
HostCapabilities
├── Inspect
├── Connect
├── Execute
├── Copy
├── Start
├── Stop
├── Restart
├── Configure
├── Monitor
└── Delete
```

- These are candidate capabilities
- not mandatory operations for every host. 
- **Example**
  - `Execute` may be available over SSH but not through a cloud provider's management API.

## 4. Test with concrete hosts

| Host                  | Kind      | Mechanism     | Capabilities                        |
| --------------------- | --------- | ------------- | ----------------------------------- |
| Local Linux machine   | BareMetal | Local Process | Inspect, Execute, Copy              |
| Remote Linux server   | BareMetal | SSH           | Inspect, Execute, Copy              |
| Remote Windows server | BareMetal | WinRM         | Inspect, Execute                    |
| Docker container      | Container | Docker API    | Inspect, Execute, Copy, Start, Stop |
| Cloud VM              | VM        | Cloud API     | Inspect, Start, Stop, Configure     |

These examples expose an important distinction: a cloud API can start or stop a VM without being able to execute commands inside its guest OS.

## 5. First model to validate

```
kind: Host
type: VM
mechanism:
  provider: CloudProvider
  interface: API
capabilities:
  - inspect
  - start
  - stop
```

- `kind: Host` identifies the resource category
- `type: VM` identifies its subtype. We could simplify that if `Host` is already the parent type in your type system.

Question:
- Should `Mechanism` represent how we access the host's operating system (SSH, WinRM, agent)
- Or how we manage the host itself (Docker API, hypervisor API, cloud API)?

Those are distinct operations, and a single host may support both. I'd keep that distinction in mind before locking down the model.


# Idea

- wrapping is composable and recursive
- separate mechanism like 
  - SSH + Docker
  - SSH + Kubernetes
  - SSH + bastion + SSH

