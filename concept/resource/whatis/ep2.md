[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[model whatis]:     /concept/model/whatis/ep.md
[res list]:         ../list/ep.md
[res hard whatis]:  ../whatis/hardware.md
[host whatis]:      ../whatis/host.md
[repo whatis]:      /concept/repository/whatis/ep.md
[provision whatis]: ../whatis/provision.md
[ope whatis]: ../whatis/operation.md
[env whatis]:       ../whatis/env.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Model][model whatis]|see|
|[What is a Env][env whatis]|see|
|[What is a Host][host whatis]|see|
|[What is an Operation][ope whatis]|see|
|[What is a Hardware Resource][res hard whatis]|see|
|[List of Resources][res list]|see|


<h1 align="center">What is a Resource</h1>

The concept of resource




# <h1 align="center">What Is a Resource</h1>

The concept of resource

# Definition

- Anything that can **achieve a** purpose, **satisfy a need**, or **perform an activity**.
- Can be classified into the following categories:
  - **Natural** resources (water, air, minerals, forests, etc.)
  - **Human** resources (people, skills, knowledge, etc.)
  - **Financial** resources (money, capital, credit, etc.)
  - **Material** resources (equipment, tools, buildings, etc.)
  - ...

- can also, be arbitrarily classified into two categories: 
  - **Physical resources** — resources that exist as tangible entities.
  - **Non-physical resources** — resources that exist as intangible entities.

# Kind
- **Atomic** — Treated as a whole.
- **Composite** — Made of component resources.
    - **Flat** — component resources are organized at a single level, without nested containment.
    - **Hierarchical** — component resources may contain other resources, forming nested levels.
    - **Networked** — component resources are connected through relationships that are not limited to a hierarchy.

# Physical resources

**Examples:**
- Natural resources (water, oil, minerals, forests, etc.)
- Human resources (people, skills embodied in human activity, etc.)
- Material resources (machines, buildings, tools, etc.)

# Non-physical resources

**Examples:**
- Informational resources (documents, data, knowledge, etc.)
- Financial resources (credit, contractual rights, etc.)
- Intellectual resources (ideas, methods, intellectual property, etc.)
- Digital resources (software, databases, digital files, etc.)

# IT Resource
In IT domain, resources can be categorized as
- **Physical resources** — resources that exist as tangible entities.
- **Virtual resources** — a modelization of a **Physical resources** or phenomeon
- **Digital resources** — resources that is virtual by essence (a file, a database)
- **Modeled resources** — resources that exist as intangible entities.


# Todo
- In computer science, the concept is used to describe entities that can be accessed, allocated, consumed, manipulated, or managed by a system.
  - Technological resources (hardware, software, networks, etc.)
  - Informational resources (documents, data, knowledge, etc.)


# Todo
- identify ambiguities, distinguish concepts that overlap, and build a consistent model.
- manage contradiction
    - semantic contracdiction
    - syntaxic contradiction



Resource Kind -> The functional or conceptual category -> what is it?
- A processor
- Memory
- Storage (Disk)
- Network (NIC)
- Interface
- Service
- File
- Db
- ...

Resource Implementation -> The mechanism that provides its functionality  -> what realizes it?
- Physical components
- hardware-assisted virtualization
- firmware
- software
- software emulation, 
- a combination


Resource exposed -> What a consumer or operating system sees -> how is it exposed?
- A physical device
- a virtual device, 
- a logical resource, 
- or an API abstraction.
- Directly
- Virtually
- Through an abstraction.


Resource backend -> The resources or mechanisms it relies on. -> what supports it?
- Physical devices
- Other virtual resources
- Software implementations
- A combination.

Resource Role
- Computing
- Storage
- Networking
- ...


# Example
- Resource = vCPU
    - implementation = software
    - , virtual by representation, and backed by physical CPU capacity.


The clearest way to classify your examples is to separate the kind of resource from where it runs, what it represents, and how it is implemented.

For now, I'll use one primary `kind/subkind` classification for every resource, and keep the other dimensions separate. That prevents a file on a VM from becoming a different kind of resource merely because it lives on a VM rather than on bare metal.

# Definition


## Resource

An entity that can be **identified**, **described**, used, **accessed**, managed, or **operated on** for a purpose.

- Has properties.
- May participate in relationships with other entities.
- May be part of, contain, or depend on other resources.

## component resource 
- a resource
- is part of another resource.

## Resource primary Classification



## System

- An organized set of interacting or interdependent elements that collectively perform one or more functions or achieve a purpose.
- Can be classified into categories such as:
  - Physical systems (a computer, a network of machines, etc.)
  - Software systems (an operating system, an application, etc.)
  - Information systems (a database system, an information management system, etc.)
  - Distributed systems (a cluster, a distributed application, etc.)

**Examples**:

- A bare-metal computer is a physical system.
- An operating system is a software system.
- A virtual machine can be considered a virtual computing system.
- A container is an isolated execution environment, generally sharing the host operating system's kernel.

## Resource

Definition

- An entity or capability that can be identified, described, used, allocated, accessed, or managed for a purpose.
- Can be a whole system, a component of a system, a collection of entities, or an abstract entity.
- May have properties, members, dependencies, and relationships with other resources.

Examples in IT:

- A computer can be modeled as a resource.
- A CPU can be modeled as a resource within a computer.
- A file can be modeled as a resource within a filesystem.
- A software service can be modeled as a resource within an application.

## The relationship between them

The key distinction is that system describes organization and behavior, whereas resource describes how an entity is treated in a particular context.

A system can be a resource, and a resource can be part of a system. These terms are not mutually exclusive categories.

For your IT tool, I would therefore avoid defining Compute as “a system or resource.” Instead:

> Compute resource: A resource that provides or represents the capability to execute instructions or run workloads.

This definition covers physical computers, virtual machines, and containers without confusing the concepts of system, resource, and implementation.

# The classification scheme

| Kind        | Meaning                                                              |
| ----------- | -------------------------------------------------------------------- |
| Compute     | A system or resource that executes instructions or runs workloads.   |
| Storage     | A resource that stores or organizes data.                            |
| Network     | A resource that enables network communication.                       |
| Software    | A software artifact, component, configuration, or executable entity. |
| Data        | A data entity or structured information managed by software.         |
| Environment | A context in which resources are installed, executed, or managed.    |

These are practical categories for your IT model, not a universal taxonomy. In particular, a software artifact can also be data, and a VM can be modeled both as a compute resource and as an environment for its guest OS.

## 2. Classification of your resources

### A. Files, machines, VMs, and containers

| Resource              | Kind    | Subkind                                 |
| --------------------- | ------- | --------------------------------------- |
| A file on a VM        | Data    | File                                    |
| A file in a container | Data    | File                                    |
| A file on bare metal  | Data    | File                                    |
| A bare-metal machine  | Compute | Physical machine                        |
| A VM                  | Compute | Virtual machine                         |
| A container           | Compute | OS-level isolated execution environment |

Why?

- A file remains a file regardless of whether it is stored on a VM, a container's filesystem, or a bare-metal machine.
- A bare-metal machine is a physical computing system.
- A VM is a virtual computing system exposing virtualized hardware to a guest OS.
- A container is an isolated execution environment that shares the host kernel in the usual container model. It is not a VM and does not ordinarily have its own guest kernel.

The location or hosting relationship is separate from the resource's kind.

For example:

Bare-metal machine

Compute / Physical machine

VM

Compute / Virtual machine

File

Data / File

Illustrative containment/hosting hierarchy. A file can instead be stored directly on the host or in a container's filesystem.

### B. Repositories and registries

| Resource                   | Kind     | Subkind                       |
| -------------------------- | -------- | ----------------------------- |
| Git repository             | Storage  | Version-controlled repository |
| Package repository         | Storage  | Software package collection   |
| Container image repository | Storage  | Container image collection    |
| VM disk image repository   | Storage  | Virtual disk image collection |
| Container registry         | Software | Artifact distribution service |

The distinction here is between the repository containing artifacts and the service that manages or distributes them.

- A Git repository stores versioned files and their history.
- A package repository organizes software packages for discovery and distribution.
- A container image repository organizes container images, commonly by name and tag.
- A VM disk image repository stores or distributes VM disk images.
- A container registry is the service through which container images are stored, published, retrieved, and managed. It typically contains many image repositories.

One correction to your example: `podman container list` (or `podman ps`) lists containers, not container registries. To inspect images, use `podman images`; registry interaction involves commands such as `podman search` and `podman pull`.

A registry might also expose storage, APIs, authentication, and metadata. If your tool models the entire registry platform, you could classify it as a composite software service rather than merely as a repository.

### C. Kernel modules and kernel parameters

| Resource         | Kind     | Subkind                 |
| ---------------- | -------- | ----------------------- |
| Kernel module    | Software | Kernel component        |
| Kernel parameter | Data     | Configuration parameter |

The distinction is between executable functionality and a value that configures that functionality.

- A kernel module is software that extends or provides functionality to the operating-system kernel, such as a device driver or filesystem module.
- A kernel parameter is a configuration value that influences kernel behavior. For example, `vm.swappiness` is a kernel parameter exposed through Linux's `sysctl` interface.

A parameter may be persistent or runtime-only. Its persistence mechanism does not change its kind.

### D. Shell variables and `.bashrc`

| Resource                           | Kind | Subkind                   |
| ---------------------------------- | ---- | ------------------------- |
| A variable assignment in `.bashrc` | Data | Configuration declaration |
| A shell variable                   | Data | Runtime variable          |

For example:

```
# ~/.bashrc
MY_APP_HOME="/opt/myapp"
```

Here, `MY_APP_HOME="/opt/myapp"` is a configuration declaration in a file.

After the shell executes that assignment, `MY_APP_HOME` is a runtime variable holding a value in the shell's execution context.

They are related, but they are not the same resource:

- The file is a file resource.
- The assignment is a configuration declaration contained in that file.
- The shell variable is a runtime data entity created or modified when the assignment is executed.

An exported shell variable is also placed in the environment passed to child processes. This use of the word environment is distinct from an IT environment such as development, staging, or production.

### E. A `File` model and a `User` model in software

I'm interpreting model here as a software data model, such as an ORM model or application entity class.

| Resource                   | Kind     | Subkind                  |
| -------------------------- | -------- | ------------------------ |
| A `File` model in software | Software | Data model / entity type |
| A `User` model in software | Software | Data model / entity type |

For example:

```
class User:    id: int    username: str
```

The `User` class is a software definition of a data model. An individual user record created from that model is a different resource.

This gives you three distinct levels:

| Entity                             | Kind     | Subkind         |
| ---------------------------------- | -------- | --------------- |
| `User` class                       | Software | Data model      |
| A particular user object in memory | Data     | Runtime object  |
| A user record stored in a database | Data     | Database record |

Likewise, a `File` model does not automatically represent a physical file. It may represent metadata about a file, a database record, or an application-level abstraction.

## 3. The consolidated classification

Here is the complete proposed mapping.

| Resource                             | Kind     | Subkind                                 |
| ------------------------------------ | -------- | --------------------------------------- |
| File on VM, container, or bare metal | Data     | File                                    |
| Bare-metal machine                   | Compute  | Physical machine                        |
| VM                                   | Compute  | Virtual machine                         |
| Container                            | Compute  | OS-level isolated execution environment |
| Git repository                       | Storage  | Version-controlled repository           |
| Package repository                   | Storage  | Software package collection             |
| Container image repository           | Storage  | Container image collection              |
| VM disk image repository             | Storage  | Virtual disk image collection           |
| Container registry                   | Software | Artifact distribution service           |
| Kernel module                        | Software | Kernel component                        |
| Kernel parameter                     | Data     | Configuration parameter                 |
| Variable assignment in `.bashrc`     | Data     | Configuration declaration               |
| Shell variable                       | Data     | Runtime variable                        |
| `File` model in software             | Software | Data model / entity type                |
| `User` model in software             | Software | Data model / entity type                |

## 4. One important caveat for your tool

Some of these resources could legitimately be classified differently depending on the question your taxonomy is answering.

For instance, a Git repository can be viewed as:

- Storage, when you focus on its role as a collection of versioned data.
- Software, when you focus on the Git repository as a software artifact or on the repository-management service.
- A collection, when you focus on its composition of files and other repository objects.

These are not necessarily contradictions. They are different classification dimensions.

My recommendation is to make `kind` and `subkind` describe what the resource is in your model, while keeping properties such as `implementation`, `representation`, `location`, `backing_resource`, and `lifecycle` separate.

That way, you could describe a VM as a virtual compute resource running on a physical machine, containing a filesystem, which contains files, without changing the classification of a file based on where it happens to reside.    



# Definition


### System

- A set of interacting or interdependent elements organized to perform one or more functions or achieve a purpose.
- A system may contain resources, and its elements may themselves be systems.
- A system may itself be modeled as a resource.

### Component

- An element that forms part of a larger entity or system.
- A component may itself be a resource or a system.

### Environment

- The context in which entities exist, interact, or operate.
- An environment may contain or provide access to resources and systems.
- An environment may itself be modeled as a resource or system.

## 2. Establish the relationships

| Subject  | Predicate             | Object            |
| -------- | --------------------- | ----------------- |
| System   | consists of           | Components        |
| System   | interacts with        | System / Resource |
| System   | may be modeled as     | Resource          |
| Resource | may be a component of | System            |
| Resource | may contain           | Resource          |
| Resource | may exist in          | Environment       |
| Resource | may depend on         | Resource          |

These relationships allow recursion without forcing system, component, and resource into mutually exclusive categories.

## 3. Only now introduce the classification scheme

Once those foundational concepts are established, we can define the dimensions used to classify IT resources:

- Kind: What the resource is or what role it serves.
- Composition: Whether it is modeled as atomic, composite, or a collection.
- Nature or representation: Whether it is physical, virtual, or abstract.
- Implementation: Whether its functionality is realized through hardware, software, firmware, or a combination.
- Context: The environment in which it exists or operates.

These are separate dimensions, not competing categories in one hierarchy.

For example, a virtual machine can be a compute resource, a composite resource, a virtual resource, and a resource implemented through a combination of software and physical hardware.

The important correction is methodological: define the vocabulary first, establish the relationships second, and construct the classification scheme third. That is the order we should follow throughout your IT conceptual model.