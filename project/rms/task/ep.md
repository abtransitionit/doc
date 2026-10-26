
[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ RMS][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]


[//]: # (doc)

<div align="center">

# Project RMS — Task

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>



# 📚 Index of Task
1. CLI
    1. [Specification](../task/task01-cli-spec.md)
    1. [User guide](../task/task01-cli-guide.md)
    1. [Implementation](../task/task01-cli-impl.md)
1. Model
    1. [Host](../task/task02-model-host.md)
    1. [Resource](../task/task02-model-resource.md)
    1. [Provider](../task/task02-model-provider.md)
    1. Backend, Provisioner, Driver, Mechanism
1. Architecture
    1. [CLI](../task/task03-arch-cli.md)
    1. [Principe](../task/task03-arch-principe.md)
    1. [Application](../task/task03-arch-app.md)
1. Todo
     
    1. [todo-01](/project/rms.old/whatis2/phasex-model.md)
    1. [todo-02](/project/rms.old/whatis2/phase2-term.md)
    1. [declarative](/concept/other/whatis/declarative.md)


# Model

## Transport
- The "road" the command travels on to reach the target.
- local, ssh, https
- imagine as a replaceable, configurable connection channel.
- verify: when the target is the same but the transport is different, 
    - can the core logic of your CLI remain completely unchanged and still route the command to the correct executio location.

## Transport Kind

- WinRM (for Windows targets)
- container as target: docker, podman
    - `rms file/file:/etc/nginx/nginx.conf read my-nginx-container`
    — here `my-nginx-container` triggers `transport: docker`, and the provider might be `exec` (running `docker exec cat`).

**3. Raw TCP / Agentless Push**
Puppet Bolt's selling point is agentless: it connects to targets via SSH/WinRM, executes, and disconnects, without requiring any persistent agent on the target. This is essentially the same as your ssh transport, but it reminds you: **transport can be a one-shot connection**, not a persistent session. Stress test: after the same command is executed, the transport layer should cleanly close without leaving any state. Also, Bolt defaults to 100 threads for parallel connections — your transport layer needs to support connection reuse (SSH multiplexing) or at least not be overwhelmed by parallel stress tests.

**4. gRPC over TLS (modern API channel)**
Some tools (such as `syfrah-cli`) communicate with a remote API gateway via gRPC over TLS, rather than traditional REST/HTTP. If your `rms` might connect to a control plane or agent service in the future instead of directly connecting to the target, this is a transport worth considering. Stress test: the target is an API endpoint (not a host), transport is `grpc`, provider is an RPC method name.

**5. ZeroMQ / Message Bus (agent-based)**
Salt's default transport is not ssh, but ZeroMQ: master and minion communicate through a message bus, requiring the minion agent to be installed on the target. Salt SSH is an "alternative" that bypasses ZeroMQ and uses ssh directly, and it's noticeably slower. Stress test: your model should be able to distinguish between `transport: zmq` (with agent) and `transport: ssh` (agentless), and even if the provider for both is the same `service` module, the underlying implementation paths should be completely different.

### A Stress-Test Checklist (in Your Grammar)

| Stress Scenario | Target Example | Transport | What to Verify |
|---|---|---|---|
| Same target, different transport | `o1u` | `ssh` vs `local` | Same provider, but one runs locally and one goes through a remote tunnel; results should be consistent |
| Windows target | `win-host` | `winrm` | Does the provider automatically switch to powershell/sc? |
| Container target | `my-container` | `docker` | Does the address still represent the resource path inside the container? |
| Message bus target | `salt-minion-01` | `zmq` (or `salt`) | Does the model allow "agent-based" transport as an optional mode? |
| Parallel pressure | 100 targets | `ssh` | Will the transport layer explode? Is connection multiplexing needed? |
| Connection failure | Unreachable host | Any | Is the error attributed to transport, not provider? |

### One Sentence to Remember

Your transport abstraction should answer the question: **"How do I get to that place?"** — not "What do I do once I'm there?" As long as you can swap `ssh` → `winrm` → `docker` → `grpc` without changing the command syntax, your model is sound. Existing examples only cover the first three; the stress test should add at least `winrm`, `docker`, and `zmq` to see if the model holds up.

