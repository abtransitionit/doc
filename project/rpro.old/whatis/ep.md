[//]: #(home)
[home]: ../../README.md

[//]: #(doc)
[lfc whatis]:       ../../../concept/lifecycle/whatis/ep.md
[prj roadmap whatis]:    ../../../concept/lifecycle/whatis/roadmap.md
[prj lfc whatis]:   ../../../concept/lifecycle/whatis/ep.md#sproject
[operate whatis]:   ../../../concept/lifecycle/whatis/ep.md#sproject
[res whatis]:       ../whatis/res.md
[env whatis]:      ../whatis/host.md
[provider whatis]:  ../whatis/provider.md
[provision whatis]: ../whatis/provision.md

[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Lifecycle][lfc whatis]|internal



<h1 align="center">Project: forge</h1>




# Step 00: Project's lifecycle

we adopt [this lifecycle][prj lfc whatis] for the project:


```
vision → requirements → domain → architecture → implementation → validation → release → operation
```

- This lifecycle describes the major stages through which the project is expected to evolve.
- It is not assumed that the project will progress through these stages strictly once and in a linear manner.
- Documentation is not only a description of the project; it is also an instrument for discovering the project.
- Therefore, the project allows and expects iteration and reverse engineering.

we adopt [this roadmap][prj roadmap whatis] for the project:

| id  | Milestone              | Lifecycle phase | Goal                                                   |
| --- | ---------------------- | --------------- | ------------------------------------------------------ |
| M01 | Core concept           | Validation      | Validate the provisioning model with a minimal POC.    |
| M02 | Minimal implementation | Implementation  | Implement the core domain model and provisioning flow. |
| M03 | Local resources        | Implementation  | Support File and Directory resources on a Local Host.  |
| M04 | Remote resources       | Implementation  | Support provisioning on a Remote Host.                 |
| M05 | First release          | Release         | Provide the first usable version of RPro.              |
| M06 | Extended providers     | Implementation  | Add additional providers and supported environments.   |
| M07 | Kubernetes             | Implementation  | Support provisioning resources in Kubernetes.          |

**Yet**. no dates are added. At this stage, the roadmap is about sequencing and scope, not scheduling.

# Step 01: The Project's Vision

- Build a system that can [provision][provision whatis] and [operate][operate whatis] [resources][res whatis] in [environment][env whatis] through a common model.
- The system should eventually be able to work with different kinds of [resources][res whatis] and different kinds of [environments][env whatis], including resources that already exist.

The long-term vision is therefore:
- Describe what resources are required
- where and how resources should exist
- Let the system provision and operate resources regardless of the underlying environment.

The system may rely on existing [resources][res whatis] rather than requiring everything to be created by the system itself.


## The problem
Provisioning resources usually requires different systems, tools, commands, configurations, and procedures for each environment.

**Files**: may need to be created:

* on a local filesystem;
* on a remote filesystem;
* in an object-storage system such as S3.

**Virtual machines**: may need to be created through different cloud or virtualization systems:

* OVH;
* AWS;
* other cloud providers;
* local virtualization systems.

**Clusters**: may be created or operated in very different ways:

* OpenStack on bare metal;
* Kubernetes on virtual machines;
* Kubernetes in containers;
* other cluster technologies.

**Git repositories**: may be managed through different mechanisms:

* GitHub;
* GitLab;
* SSH;
* local repositories.

**Other operations** may include, for example:

* resetting the history of a repository hosted on GitHub or GitLab;
* creating a fresh repository from a template on GitHub or GitLab;

These examples all involve resources and deffierent mechanisms to create and operate them. For example:

* one resource may be managed through a script written in Go, Python, or Shell;
* another may be managed through a command-line interface such as `gh`;
* another may be managed through an API such as the GitHub API.

The project aims to provide a **common way** to **provision** and **operate** resources, independently of the environment in which they exist **and** the mechanism used to manage them.

```

                    Common model
                         │
                         ▼
                     Resource
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
       Script           CLI            API
          │              │              │
          └──────────────┼──────────────┘
                         ▼
                  Actual environment
```

```
                    Common model
                         │
              ┌──────────┴──────────┐
              │                     │
          Resource              Environment
              │                     │
              └──────────┬──────────┘
                         │
                  common operations
                         │
              ┌──────────┼──────────┐
              ▼          ▼          ▼
           Script       CLI        API
           Go/Python    gh         GitHub API
              │          │          │
              └──────────┴──────────┘
                         │
                  actual resource
```

## Initial goal

- Is **not** to support every resource and every environment.
- Is to prove that a common/unified model can provision a small set of resources in more than one environment.

## Initial vision

- 

```
                 Provisioning System
                         │
              ┌──────────┴─────────────────┐
              ↓                            ↓
          Resources                   Environments
              │                            │
       ┌──────┴──────┐              ┌──────┴──────┐
       ↓             ↓              ↓             ↓
   Filesystem     Git repository   Local       Remote
```

This gives us a concrete starting point without prematurely deciding the architecture or implementation.

# Step 02: Iniital Requirements
- This section answers: What must the system actually be able to do for the initial goal to be considered successful?




| ID  | Requirement                                                                         |
| --- | ----------------------------------------------------------------------------------- |
| R01 | Describe a resource to be provisioned or operated on.                               |
| R02 | Identify the target environment for a resource.                                     |
| R03 | Identify a provider capable of operating on the resource in the target environment. |
| R04 | Provision a resource in the target environment using the provider.                  |
| R05 | Operate on an existing resource using the provider.                                 |
| R06 | Operate on resources that were not originally provisioned by the system.            |
| R07 | Support different mechanisms for performing operations through a provider.          |
| R08 | Report the result of an operation.                                                  |




|id|req||
|-|-|-|
| R01 | Describe a resource |
| R01 | Allow a user to describe/select the resource to be provisioned|
| R02 | Allow a user to identify the environment where the resource must be provisioned |
| R02 | Identify an environment |
| R03 | Provision a resource.
| R03 | Select a provider capable of provisioning the requested resource in the target environment
| R04 | <li>Operate on an existing resource. <li> perform operation on an existing resource
| R04 | Use the selected provider to provision the resource in the target environment.
| R06 | Work with resources that were not originally created by the system.
| R05 | Use different mechanisms to perform an operation on a resource.
| R07 | Report whether an operation succeeded or failed.
| R07 | rely on .
RPro must be able to perform operations on an existing resource.
RPro must be able to operate on resources that were not originally provisioned by RPro.
RPro must be able to provision a resource in an environment.
RPro must be able to represent a resource that can be provisioned or operated on.
RPro must be able to represent the environment in which a resource exists.


### Different mechanisms

RPro must allow the same conceptual operation to be performed through different underlying mechanisms.

For example, an operation may be implemented using:

* a script;
* a CLI;
* an API;
* another mechanism discovered later.



## Initial scope

- This section defines the scope of the first working implementation.
- It aims to prove that the model and implementation support a small, concrete subset of resources and environments.

For example:

```text
Resources
├── File
├── git repository
└── Directory

Environments
├── Local Host
└── Remote Host
```

This gives us enough scope to validate the core idea without trying to solve every provisioning problem at once.

# Step 03: Define the Domain

## Concepts of the domain<a id='domain'></a>

This section identifies and defines the concepts involved in that project.
- A [Resource][res whatis] is something that the system can provision.
- An [environment][env whatis] is where a resource is provisioned.
- A [Provider][provider whatis] knows how to [Provision][provision whatis] a resource in a particular environment.
- [Provisioning][provision whatis] is the action of creating and configuring a resource in an environment using a provider.


## Relationships

|subject|Relation|object|
|-|-|-|
|Resource|is provisioned in|Environment
|Provider|provisions|Resource
|Provisioning operation|specifies|<li>Resource <li>Environment <li>Provider

**Example**:

```text
Resource
  └── Directory: /data

Environment
  └── Local Host

Provider
  └── Local Provider

Provisioning
  ├── resource     → Directory: /data
  ├── environment  → Local Host
  └── provider     → Local Provider
```

This model gives us the basic structure needed to design the system architecture.


## Models of the domain

This section models each concept of the domain.

### Model for Resource

- Represents something that can be provisioned.

```
Resource
├── type
├── name
└── configuration
```

Examples: directory, file, git repository, VM, container, Kubernetes Deployment


## Model for Environment

- Represents where a resource (lives, exists or) is provisioned.

```
Environment
├── type
├── name
└── configuration
```

Examples: Local Host, Remote Host, Docker Engine, Kubernetes Cluster, Cloud, Infrastructure


## Model for Provider

- Knows how to provision a **resource** in a particular **environment**.
- **configuration** may describe/change how the provider should access or operate on an environment.

```
Provider
├── name
├── supported resources
├── supported environments
└── configuration
```


**Examples**: 

```
Provider
│
├── Docker Provider
│     ├── name → Docker
│     ├── supported resources    → Container, Volume, Network
│     ├── supported environments → Docker Engine
│     └── configuration → ...
│
├── Local Provider
│     ├── name → Local
│     ├── supported resources    → File, Directory
│     ├── supported environments → Local Host
│     └── configuration → ...
│
└── SSH Provider
      ├── name → ssh
      ├── supported resources    → ...
      ├── supported environments → ...
      └── configuration
            ├── host → ...
            ├── port → ...
            ├── user → ...
            └── credentials → ...
```

## Model for the Provisioning operation

- Specifies the resource to provision, the environment in which to provision it, and the provider used to perform the provisioning.
- **configuration** may may describe/change how this particular operation should be performed.

```
Provisioning
  ├── resource
  ├── environment
  ├── provider
  └── configuration
```

**Example**:

```
Provisioning
    ├── resource     → Directory: /data
    ├── environment  → Remote Host
    ├── provider     → SSH Provider
    └── configuration
          └── permissions  → 0755

```

**todo**:
- Question for later: how to launch that provisioning


# Step 04: Define the architecture

This phase defines how `RPro` will satisfy the requirements using the domain model.

## identify the system boundary

- This section attempts to define the scope of responsibility of `RPro` itself.
- It tries to answer the question: What is the responsibility of RPro, and what is delegated to providers?

For the initial architecture, the following architectural **decisions** should be recorded as **ADRs**:
- `Resource` is the thing being managed.
- `Provider` performs the environment-specific provisioning
- `RPro` 
  - **orchestrates** the provisioning.
  - **delegates** environment-specific provisioning to `Provider`.
- `Environment` is external to RPro; `RPro` operates on it through a provider.

**Yet**, We do not choose CLI vs API, language, plugin mechanism, process model, etc.




# Step 05: Implementation
# Step 06: Validation
# Step 07: Release
# Step 08: Operation



# Todo #####################



# Step 03: Define the model




## The overall model
```
Resource + Environment + Provider + Configuration 
     ↓
Provisioning
     ↓
Resource is provisioned in the Environment
```

# Step 04: Define the prototype
This sections aims to prove that the model works with the smallest possible working example.

# Todo
- through/use a common model and interface.
- Build a  [system](#) for [provisioning][provision whatis] any kind of [resources][res whatis] on any environment /kind of [hosts][host whatis].
- The [code name](../../../tool/metadoc/whatis/ep.md) of the [system](../whatis/system.md) that emerged from that project.
- The system/tool may rely on existing [resources][res whatis]

# Todo

```text
Local machine
    ├── filesystem
    └── process

Remote host
    ├── filesystem
    └── service

Virtual machine
    ├── VM
    └── network

Container environment
    ├── container
    └── network

Kubernetes
    ├── pod
    ├── service
    └── volume
```

```
                 Provisioning System
                         │
              ┌──────────┴──────────┐
              ↓                     ↓
          Resources            Environments
              │                     │
       ┌──────┴──────┐       ┌──────┴──────┐
       ↓             ↓       ↓             ↓
   Filesystem     Process   Local       Remote
```

# Todo

- **The Logic is Stable:** The sequence of questions (Why? → What? → When/Who? → How? → Check → Run → Measure → Adapt) remains the same for any project.
- **Separate the "What" from the "How":** Your **Requirements** (Phase 2) should describe the problem and needs, not the specific technology or solution. This makes your project more flexible and resilient to change.


# Todo
This tutorial:
  - uses a [lifecycle][lfc whatis] to structure the software lifecycle 
  - uses a [roadmap][roadmap whats] to plan what will be delivered.
  - explain how to build a software project from an initial idea to its first usable release, then continue with subsequent releases.

The idea: follow tvhis steps: `Ìdea → Lifecycle → Roadmap → Implementation → Release → Next release`


# Todo
# Example
A provisioning system might interact with or rely on:
- Hypervisor: e.g. VMware, KVM, Hyper-V
- cloud provider: e.g. AWS, OVH

for example when provisioning a VM, the provisioner doesn't necessarily create the VM. It may ask the underlying infrastructure system to create it.


# Todo

Conceptually:

```text
Resource + Environment + Configuration
                  ↓
             Provisioning
                  ↓
              Resource
```


## Provider


For example:

```text
Filesystem Provider → Local filesystem

Container Provider
        ↓
Container runtime

Kubernetes Provider
        ↓
Kubernetes cluster
```


## Other copncepts
- [Configuration](#)
- [Provider](#)

## Initial domain

We can therefore describe the domain as:

```text
                    Provisioning
                         │
             ┌───────────┼───────────┐
             ↓           ↓           ↓
          Resource   Environment   Provider
             │           │           │
             └───────────┴───────────┘
                         ↓
                    Configuration
```

# Todo : old likfecycle
```
vision → domain → model → prototype → implementation → validation → release → operation
```


# Todo : how the system is operated and who/what invokes
```

                    is actioned by
Provisioning system    ────>        Agent

       is actioned by
Agent    ────>        Human, bot, script


```

- Whether Agent is actually a useful abstraction is itself an **architectural decision**. 

```
User
  ↓
RPro CLI/API
  ↓
Provisioning Engine
  ↓
Provider
  ↓
Environment
```


# Todo


This section defines how the requirements will be satisfied and contains the following subsections
- [Domain](#domain)
- [Prototype](#prototype)
- [ADR](#adr)
- [Model](#model)


# Todo

```
vision → requirements → domain  → design → implementation → validation → release → operation
```

```
vision → requirements → domain → design → implementation → validation → release → operation
```

# Todo : old req

|id|req||
|-|-|-|
| R01 | Describe a resource | Allow a user to describe a resource to be provisioned.
| R02 | Describe an environment | Allow a user to identify the environment where the resource must be provisioned.
| R03 | Select a provider | Select a provider capable of provisioning the requested resource in the target environment.
| R04 | Provision a resource | Use the selected provider to provision the resource in the target environment.
| R05 | Report the result | Report whether the provisioning operation succeeded or failed.
