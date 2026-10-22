[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ The System][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[blue whatis]: /project/blueprj/whatis/ep.md
[agent whatis]: ../whatis/pp1.term.md#agent

<div align="center">

# Project RMS — Phase1: Overview

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>






# Problem Statement

**Statement**

Provisioning and operating resources across projects, teams, and environments involves different:
- **Tools**: Software used to manage or operate resources.
- **Protocols**: Communication protocols used to access or manage resources..
- **Interfaces**: How capabilities of resource are exposed to manage them.
- **Procedures**:  Sequences of actions required to perform an operation.
- **Abstractions**: how resources and operations are represented through a common model.

**Examples**:

- Files: created on a local filesystem, a remote filesystem, or object storage such as `S3`.
- Virtual machines: provisioned through cloud providers such as `OVH`, `AWS`, and `GCP`, or through local virtualization systems.
- Clusters: built using `OpenStack` on bare metal or `Kubernetes` on virtual machines or in containers.
- Git repositories: managed through `GitHub`, `GitLab`, `SSH`, or local Git operations.
- Operations: implemented using scripts written in `Go`, `Python`, or `Shell`, command-line tools such as `gh`, `aws`, and `openstack`, or provider APIs.

These examples illustrate how resource management varies across resource types and environments, requiring different implementation approaches.

**The problems**:

- Learning overhead: understanding multiple tools, interfaces, and procedures.
- Maintenance overhead: implementing and maintaining resource-specific integrations.
- Integration complexity: combining heterogeneous operations into reusable, higher-level workflows.

These challenges highlight the need for a common approach that abstracts the differences between resources and their underlying management mechanisms.

# The solution

The project addresses these problems. It provides a common model to define, provision, and operate resources, independently of their:
- Type
- Environment
- Underlying management mechanism

Projects, teams, and environments use the same interface to:
- Reduce operational complexity
- Simplify implementation and maintenance
- Enable operations to be reused and composed across different **projects**, **teams**, and **environments**

Concretely, RMS simplifies resource management for the agent by hiding the complexity of the underlying tools, protocols, interfaces, and procedures:

Example of **Tools**:

- `gh` — manage GitHub repositories.
- `aws` — manage AWS resources.
- `openstack` — manage OpenStack resources.
- `kubectl` — manage Kubernetes resources.
- `terraform` — provision infrastructure.
- `ansible` — configure and operate hosts.

Example of **Protocols**:

- `SSH` — execute commands on remote hosts.
- `WinRM` — remotely manage Windows hosts.
- `HTTP/HTTPS` — communicate with web services and APIs.
- `SFTP` — transfer files between systems.
- `S3 API` — interact with object storage.
- `gRPC` — communicate with services through remote procedure calls.

Example of **Interfaces**:

- Filesystem API — create, read, update, and delete files.
- Git CLI — perform Git operations on repositories.
- GitHub REST API — manage repositories, branches, and pull requests.
- AWS EC2 API — manage virtual machines and related resources.
- Kubernetes API — manage workloads and cluster resources.
- Linux sysfs/procfs — inspect or interact with kernel and system parameters.

Example of **Procedures**:

- Create a file: create directories, write content, set permissions.
- Provision a VM: select an image, configure resources, create the instance, verify its status.
- Install a package remotely: transfer artifacts if necessary, invoke the package manager, verify installation.
- Deploy an application: build an artifact, publish it, deploy it, check its health.
- Create a Git repository: create the repository, initialize or push content, configure access.
- Provision a Kubernetes cluster: provision nodes, configure networking, initialize or install Kubernetes, verify cluster health.

Example of **Abstractions**:
- `Resource` — represent a VM, file, package, or repository through a common resource model.
- `Host` — represent a VM, container, or bare-metal server as an execution target.
- `Capability` — represent supported actions such as `read`, `write`, `start`, and `stop`.
- `Operation` — represent actions such as creating a file, starting a VM, or installing a package independently of their implementation.
- `Execution Environment` — represent targets such as hosts, containers, and clusters.
- `Deployment Stage` — represent contexts such as `dev`, `test`, `staging`, and `prod`.
- `Composite Resource` — represent a cluster as a logical resource composed of multiple VMs, networks, and other resources.


# How it works

1. The [Agent][agent whatis] supplies its intent and inputs to the system.
1. The System builds a request following a standard process (parse, create, normalize, validate).
1. The System executes the request.
1. The System returns the result to the Agent.




<details>
<summary><h1>Document Metadata</h1></summary>

**Information**

| Property | Value |
|:--|:--|
| **Doc-ID** | `PP1-VIEW-01-RMS` |
| **Project** | `RMS` |
| **Path** | `pp1.vision.md` |
| **Last Updated** | 2026-10-20 |

**Revision History**

| Date | Version | Author | Summary |
|:--|:--|:--|:--|
| 2026-10-18 | `v0.1` | amar | Initial draft |

</details>
