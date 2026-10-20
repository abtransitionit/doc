[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[res whatis]: #
[res kind whatis]: #
[ope whatis]: #
[res cap whatis]: #
[host whatis]: #
[res mechanism whatis]: #
[host wrap whatis]: #
[action whatis]: #
[plan whatis]: #
[intent whatis]: #
[request whatis]: #
[system whatis]: #
[target context whatis]: #
[target composition whatis]: #
[blue whatis]: /project/blueprj/whatis/ep.md



<div align="center">

# Project: RMS — Phase 2: Terminology

**Domain Concepts and Definitions**

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v1.0-blue)

</div>

| Field | Value |
| :--- | :--- |
| **Doc-ID** | PP2-TERM-01-RMS |
| **Project** | RMS |
| **Path** | `phase2-terminology.md` |
| **Last Updated** | 2026-10-19 |




# Index

1. [Purpose](#1-purpose)
2. [Agent Interaction](#2-agent-interaction)
   - [Agent](#21-agent)
   - [Agent Kind](#22-agent-kind)
   - [Interface](#23-interface)
   - [Intent](#24-intent)
   - [Input](#25-input)
   - [Input Kind](#26-input-kind)
   - [Result](#28-result)
3. [Resource Model](#3-resource-model)
   - [Resource](#31-resource)
   - [Resource Kind](#32-resource-kind)
   - [Resource Root Kind](#33-resource-root-kind)
   - [Resource Properties](#34-resource-properties)
   - [Composite Resource](#35-composite-resource)
   - [Physical Resource](#36-physical-resource)
   - [Logical Resource](#37-logical-resource)
   - [Virtual Resource](#38-virtual-resource)
   - [Resource Modeling Principle](#39-resource-modeling-principle)
4. [Capabilities and Mechanisms](#4-capabilities-and-mechanisms)
   - [Resource Capability](#41-resource-capability)
   - [Mechanism](#42-mechanism)
   - [Relationship Between Resource, Capability, and Mechanism](#43-relationship-between-resource-capability-and-mechanism)
5. [System Concepts](#5-system-concepts)
   - [System](#51-system)
   - [Resource Configuration](#52-resource-configuration)
   - [System Input Requirements](#53-system-input-requirements)
   - [System Responsibilities](#54-system-responsibilities)
   - [System Extensibility](#55-system-extensibility)
   - [External Resource](#56-external-resource)
   - [Request](#57-request)
6. [Execution Concepts](#6-execution-concepts)
   - [Execution](#61-execution)
   - [Operation](#62-operation)
7. [Terminology Boundaries](#7-terminology-boundaries)

# 1. Purpose

This document defines the terminology used throughout RMS (Resource Management System).

It establishes a shared vocabulary. These definitions are authoritative for subsequent project documentation. Other phases should reference these terms rather than redefine them.

# 2. Agent Interaction

## 2.1 Agent

An entity that interacts with the System to express an intent, provide input, and receive results.

**Example:** A user requests the installation of a package on an existing remote VM.

## 2.2 Agent Kind

A classification identifying the type of agent interacting with RMS.

**Examples:**
- Human user
- Script
- AI agent
- CI/CD pipeline
- External system or application

## 2.3 Interface

The means through which an Agent interacts with the System.

**Examples:**
- CLI
- API
- Web UI
- SDK.

## 2.4 Intent

- An expression of what an Agent wants the System to achieve.
- Describes the desired outcome without prescribing the implementation mechanism.

**Examples:**

- Install NGINX on an existing remote VM.
- Create a VM in a cloud environment.
- Start an existing VM.
- Retrieve the contents of a file from a remote host.
- Update an installed software package to the latest available version.
- Create a directory on a target host.
- Create a Kubernetes cluster across four VMs.
- Create an OpenStack cluster on a bare-metal server.

## 2.5 Input

Information provided by an Agent or obtained by the System to process an intent and execute the requested operation.

**Examples:**

- **Install NGINX on an existing remote VM.**
  - Target VM identification and connection details.
  - Package name: `nginx`.
  - Authentication credentials or access method, if required.

- **Create a VM in a cloud environment.**
  - Target cloud environment or provider.
  - VM configuration, such as CPU, memory, and disk capacity.
  - Network and image configuration.
  - Authentication details, if required.

- **Start an existing VM.**
  - Target VM identification.
  - Access details for the mechanism responsible for starting the VM, if required.

- **Retrieve the contents of a file from a remote host.**
  - Target host identification and connection details.
  - File path.
  - Authentication details or access method, if required.

- **Update an installed software package to the latest available version.**
  - Target host or environment.
  - Package name.
  - Package source or repository, if required.

- **Create a directory on a target host.**
  - Target host identification and connection details.
  - Directory path.
  - Directory permissions or ownership, if required.

- **Create a Kubernetes cluster across four VMs.**
  - Identification and connection details for the four VMs.
  - Kubernetes version, if specified.
  - Cluster networking configuration.
  - Node roles and cluster configuration.
  - Authentication and privilege requirements, if required.

- **Create an OpenStack cluster on a bare-metal server.**
  - Target server identification and access details.
  - OpenStack version, if specified.
  - Network configuration.
  - Storage and deployment configuration.
  - Authentication and privilege requirements, if required.

The examples illustrate possible inputs, not a fixed list of mandatory fields. Actual requirements depend on the requested capability, target resource, context, and selected mechanism.

## 2.6 Input Kind

- **Initial input:** Information provided to identify and express the requested operation.
- **Capability-dependent input:** Additional information required by the requested capability.
- **Mechanism-dependent input:** Additional information required by the selected mechanism. The Agent may be asked to supply it.
- **Execution-readiness input:** Information whose availability and validity must be verified before execution.



## 2.8 Result

A result is the information returned by the System to the Agent when request processing reaches a terminal status.

It indicates whether the request succeeded or failed and provides relevant output or error information.

**Example:** 
- For a request to install NGINX on a remote VM, the result reports successful installation or provides error information explaining why the operation failed.


# 3. Resource Model

## 3.1 Resource

An identifiable entity of a given kind that can be represented and managed by the System.

A resource may be:

- Physical or virtual.
- Atomic or composite.
- Nested within another resource.

A resource does not need to have been created or provisioned by RMS. An existing external entity can be managed as a resource if the System can identify it, represent it, and operate on it through supported capabilities and mechanisms.

## 3.2 Resource Kind

A classification of resources organized into a hierarchy.

A resource kind identifies the category to which a resource belongs. More specific kinds may extend more general kinds.

For example, `file/txt/json` is more specific than `file/txt`.

## 3.3 Resource Root Kind

The first item in a resource kind hierarchy path.

For example, in `file/txt/json`, the root kind is `file`.

## 3.4 Resource Properties

Attributes describing a resource's characteristics or state.

The properties associated with a resource depend on its kind. Their definition, representation, and management are determined by the System's resource model.

## 3.5 Composite Resource

A resource composed of other resources, potentially belonging to different kinds.

A composite resource allows the System to represent structured entities and relationships between resources.

## 3.6 Physical Resource

A resource representing a tangible physical entity.

**Examples:** CPU, RAM module, disk, physical host.

This is a descriptive classification. RMS does not require physical resources to form a mandatory top-level category in its initial resource model.

## 3.7 Logical Resource

A resource representing an entity defined or organized through software or data.

**Examples:** File, folder, variable, kernel parameter, software package, Git repository.

This is a descriptive classification, not a mandatory top-level category in the initial resource model.

## 3.8 Virtual Resource

A resource representing a software-defined instance of a resource, often abstracting or emulating an underlying resource.

**Examples:** Virtual machine, vCPU, vDisk, vNetwork.

This is a descriptive classification, not a mandatory top-level category in the initial resource model.

## 3.9 Resource Modeling Principle

RMS models resources, their kinds, their properties, and their relationships without imposing a predefined classification into physical, logical, and virtual categories.

Such classifications may be introduced later if required.

# 4. Capabilities and Mechanisms

## 4.1 Resource Capability

A characteristic defining what a resource can provide, support, or allow the System to perform.

The capabilities available for a resource may depend on its kind, configuration, context, state, and operational constraints.

Before determining whether a capability is available, the System may need to check:

- State.
- Dependencies.
- Availability.
- Limits.
- Permissions.
- Access rights.
- Health.
- Operational status.

## 4.2 Mechanism

A mechanism defines how a resource capability is implemented or executed by the System.

A mechanism provides a concrete means of performing an operation on a resource. It may rely on a specific tool, protocol, API, service, or technology.

A mechanism may implement multiple capabilities, and a capability may be supported by multiple mechanisms.

## 4.3 Relationship Between Resource, Capability, and Mechanism

| Concept | Definition | Example |
| :--- | :--- | :--- |
| Resource | The entity being managed | Package |
| Capability | What can be done | Install package |
| Mechanism | How the capability is implemented | APT or DNF |

Additional examples:

| Resource | Capability | Mechanism |
| :--- | :--- | :--- |
| File | Read data | Local filesystem, HTTP |
| Package | Install | APT, DNF |
| Repository | Retrieve artifacts | Git, HTTP, S3 |
| Host | Provision | Terraform, cloud API |

# 5. System Concepts

## 5.1 System

The System refers to RMS and its responsibilities for processing requests and managing resources through supported capabilities and mechanisms.

The System is responsible for defining and validating the inputs required to process requests and for coordinating the execution of requested operations.

## 5.2 Resource Configuration

Resource configuration describes how a resource is configured and may influence the capabilities it can provide.

Resource capabilities may depend on the following factors:

- **Intrinsic:** Inherent to the resource kind. For example, a VM can execute workloads.
- **Configuration-dependent:** Determined by the resource's configuration. For example, a VM may support nested virtualization when enabled.
- **Context-dependent:** Determined by the resource's environment. For example, a VM can access a network when connected to it.
- **State-dependent:** Determined by the resource's current state. For example, a stopped VM cannot execute workloads.

These factors influence capability availability; they do not necessarily define separate resource kinds.

## 5.3 System Input Requirements

The System defines and validates the input required to process a request.

Required inputs may be determined by the requested capability and the mechanism selected to implement it. The System must establish that the necessary information is available and valid before execution.

## 5.4 System Responsibilities

RMS supports two broad categories of resource management.

**Provisioning**

Creating, installing, deploying, or otherwise making a resource available in an environment.

**Lifecycle and state management**

Inspecting, configuring, starting, stopping, updating, or deleting a resource.

**Examples:**

- Managing packages inside an environment: install, upgrade, remove, inspect.
- Managing package artifacts and repositories: build, publish, store, retrieve.
- Provisioning a VM through a cloud API.
- Installing NGINX on an existing remote VM.

## 5.5 System Extensibility

The System can be extended by:

- Defining new resources and their associated kinds.
- Extending the resource kind hierarchy.
- Introducing additional capabilities.
- Integrating mechanisms that implement supported capabilities.

## 5.6 External Resource

An external resource is a resource that exists outside the System's own implementation or management boundary.

RMS may rely on external tools, protocols, APIs, services, and technologies to interact with such resources.

External resources are treated as first-class citizens within the resource model. They can be:

- **Identified:** Distinguished from other resources.
- **Represented:** Described within the System's model.
- **Referenced:** Used as references by other resources or System components.
- **Managed:** Operated on through supported capabilities and mechanisms.
- **Extended:** Supported through additional resource kinds and capabilities when needed.

A resource does not need to have been created or provisioned by RMS to be managed.

**Example:** A user requests the installation of NGINX on an existing remote VM. RMS represents the VM as a `Host` resource, identifies and references it, and uses a suitable mechanism, such as SSH and APT, to perform the installation.

## 5.7 Request

- A request created by the system to track the progress and completion of an intent.
- Built from the intent and its associated inputs.

**Request Lifecycle**

```text
       ┌─────────┐
       │ Created │
       └────┬────┘
            ▼
       ┌───────────┐
       │ Validated │
       └─────┬─────┘
             ▼
       ┌──────────┐
       │ Prepared │
       └────┬─────┘
            ▼
       ┌─────────────┐
       │ In Progress │
       └──────┬──────┘
              ▼
       ┌─────────────────┐
       │ Terminal Status │
       └────────┬────────┘
                │
          ┌─────┴─────┐
          ▼           ▼
     ┌───────────┐ ┌────────┐
     │ Succeeded │ │ Failed │
     └───────────┘ └────────┘
```

A request reaches a terminal status when processing ends, indicating whether the intent was fulfilled.

# 6. Execution Concepts

## 6.1 Execution

Execution is the runtime invocation of a selected mechanism to perform a requested capability.

An execution may operate on an existing resource or create a new resource.

**Existing resource:** A mechanism performs a capability on a resource hosted on a target host.

**Resource creation:** A mechanism performs a capability that creates a resource, which may subsequently be associated with a host.

**Examples:**

- Install the `nginx` package on an existing remote `Host` (VM).
- Create a `Host` resource (VM) using a cloud API mechanism.

## 6.2 Operation

An operation is the requested action performed on or through a resource using a supported capability.

The operation describes the work to be performed, while the mechanism defines how that work is carried out.

The exact relationship between operations, actions, and capabilities may be refined as the System's request and execution models are specified.

# 7. Terminology Boundaries

The following distinctions must remain consistent across RMS documentation.

| Term | Answers the question |
| :--- | :--- |
| Agent | Who interacts with the System? |
| Interface | How does the Agent interact with the System? |
| Intent | What does the Agent want to achieve? |
| Input | What information is provided or required? |
| Request | What structured information does the System process? |
| Resource | Which entity is represented or managed? |
| Resource Kind | What category does the resource belong to? |
| Resource Capability | What can the resource provide or support? |
| Mechanism | How is a capability implemented or executed? |
| Execution | When and how is the selected mechanism invoked at runtime? |
| Result | What outcome is returned to the Agent? |
