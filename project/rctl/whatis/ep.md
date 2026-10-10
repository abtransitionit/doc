[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Project Blue][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[project software howto]: /project/blueprj/howto/boostrap.md
[res whatis]:             /concept/resource//whatis/ep.md
[provision whatis]:             /concept/resource/whatis/provision.md
[ope whatis]:             /concept/resource/whatis/operation.md
[tool whatis]:            /concept/tool/whatis/ep.md
[adr list]:   ../adr/ep.md

Related topics

| Topic | Location| Kind |
|-|-|-|
|[What is a resource][res whatis]|
|[How-to for Software Project][project software howto]|


**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Project</h1>

# Todo
- The  system exposes **operations/capabilities** that a resource supports.
- a resource supports `restart`, The system exposes that operation to a **caller**. 
- The **execution** is an **invocation** of that operation.
- The  system must be able to expose a **subset** of all resource's capabilities.
  - allow some role only to have access to specific subset.

# Todo
- a System to provision and control Resources
- System Code Name: RCtl, RPro, ROpe
# Todo
- define: backend, provider, drviver, provisioner, operator, controller

# Todo


The system might interact with or rely on:
- Container Runtime: e.g; CRI-o, containerd, Docker
- Hypervisor: e.g; VMware, KVM, Hyper-V
- platform: e.g. OpenStack, AWS, OVHcloud, Kubernetes
- Any CLIs or APIs.


# Phase 01 — Vision

## Problem

[Provisioning][provision whatis] and [operating][ope whatis] [resources][res whatis] usually requires different [tools][tool whatis], commands, systems, configurations, and procedures because resources, mechanisms, and targets each vary in both **kind** and **granularity**. This complexity can be broken down into a few key dimensions:

| Dimension | Question it answers | Example
|---|---| ---|
| **Resource type** | *What* is being provisioned? | files, container, VMs, clusters, repos |
| **Target environment** | *Where* does it live? | local, remote, cloud|
| **Access mechanism** | *How* is it reached? | CLI, API, SSH, SDK, native protocol |
| **Lifecycle phase** | *When* in the lifecycle? | create, configure, operate, reset, destroy |
| **Operational concern** | *Which* transversal aspect matters? | auth, state, idempotency, observability |



## Core vision

Build a system that can **provision** and **operate** different kinds of **resources** in different kinds of **targets**, through a **common model**.

## Strategy

The system's strategy should be based on the following principles:
* **Expose / Adopt** resources provisioned outside the system, making them **first-class citizens**.
* **Rely** on existing tooling (tools, platforms, APIs) as system **building blocks** to handle specialized capabilities.
* **Compose** resources, tools, and capabilities into complete workflows.
* **Serve** as a unifying layer over external tooling rather than a replacement.

## Target Outcome

Provide a **common way** to **provision** and **operate** resources, regardless of:
- The **target** where they reside.
- The **mechanism** used to manage them.

Here are two ways to integrate those two ideas directly into your **Vision (User Experience)** section, depending on how detailed you want it to be.

## User Experience

An agent (human or tool) should express **what** should be provisioned or operated, and **where**, without having to encode **how**.

* **Intent-Based Execution:** Shifts the experience:
  * From **imperative scripting** (*doing step A, then step B via tool X*)
  * To **declarative intent** (*defining the desired state*)
  * Where the system provides the operational intelligence for **how** by 
    * removing the exponential complexity `complexity = resource × environment × tool`
    * determining the execution plan from the desired state
    * selecting the right resources, tools, and workflows for the target environment
    * resolving dependencies and ordering operations automatically
    * handling environment-specific constraints and configuration
    * executing, validating, and reconciling the resulting state
    * adapting the execution as resources, environments, or constraints change


# Phase 02 - Terminology and concepts

## Resource
- cf. [Resource][res whatis] 
- **Contrast**: 
  - A **Target** hosts a resource. 
  - A **Mechanism** acts on it
  - An **Operation** is what you do to it.

- **Answers**: *What is being acted upon?*
- **May be**:
  - a directory, a Kubernetes cluster, a Git repository
  - a file (e.g., on a local or remote filesystem, or on S3)
  - an item in a collection (e.g., a record, a field, a value)
  - a package, a library, a tool, or an application
  - a container, a VM
  - a cloud service (e.g., a database, a queue, a bucket)
  - a cluster (e.g., OpenStack on bare metal, Kubernetes on VMs or containers)
  - pre-existing, **but** brought under the system's control and operational scope


## Mechanism

The underlying tool, client, driver, or API used to execute operations on a resource.

- **Answers**: *How is the action carried out?*
- **May be**:
  - custom scripts (Go, Python, Shell, Ansible playbook)
  - dedicated CLI tools (e.g., `gh`, `aws`, `terraform`, `ansible`)
  - direct API calls (e.g., GitHub REST/GraphQL API, OpenStack API, AWS SDK)
- **Contrast**: A **Resource** is what gets acted upon. A **Target** is where it lives. A **Mechanism** is *how* the operation is executed.

## Target

The underlying platform or system hosting a resource.

- **Answers**: *Where does it live?*
- **May be**:
  - a standalone container, VM, bare-metal host, or a set/cluster of them
  - a cloud (e.g., AWS, OVH, Azure, GCP)
  - a local filesystem or an S3 bucket
  - a CI/CD runner or a sandbox
  - a cloud region or a multi-cloud setup
  - an edge device or an IoT node
  - local or remote, public or private
- **Contrast**: A **Resource** is what is hosted. A **Mechanism** is how it's acted upon. A **Target** is the execution context — the *where*.


## Granularity

The scale and composition of a resource — how atomic or how composite it is.

- **Answers**: *How big or how composed is the thing?*
- **May range from**:
  - atomic primitives — a single file on a filesystem or on S3
  - to complex multi-node platforms:
    - an OpenStack cluster (deployed over several bare-metal hosts)
    - a Kubernetes cluster (deployed over several VMs or containers)
- **Contrast**: **Kind** is *what* a resource is (a VM, a cluster). **Granularity** is *how large or how composed* it is.

## Operation

an action performed on or against a resource.

- **Answers**: *What is being done to it?*
- **May be**:
  - alter its state
  - trigger a workflow
  - inspect its status
- **May be** (named): `provision`, `destroy`, `reset-history`, `get-status`
- **Contrast**: A **Mechanism** is *how* the operation is executed. An **Operation** is *what* is done.
- **Example**:
  - **Reset** repository history.
  - **Instantiate** fresh repos from templates.
  - **Rebuild** VMs from images.
  - **Recreate** clusters from manifests.
  - **Destroy** and **rehydrate** any of the above.
  - **Import / adopt** existing resources into the model.



## Model

The abstract schema or declarative structure used to represent resources, targets, and their relationships uniformly.

- **Answers**: *How are things represented in a common way?*
- **May be**: 
  - a schema
  - a declarative structure
  - a type system
  - anything that lets the same terms describe any resource in any target.
- **Contrast**: The **Model** is the *representation*. **Mechanisms** and **Targets** are the *reality* it describes. The model is common; the underlying things vary in **kind** and **granularity**.

## Provisioning

A workflow stage that creates or sets up a resource.

- **Answers**: *How is a resource brought into existence and made ready?*
- **Structure**:
  - A provisioning operation is broken down into ordered **stages**.
  - Each stage contains one or more **tasks**.
  - Tasks within the same stage can run in **parallel** when independent.
  - Stages execute in a defined order, because **later stages may depend on earlier ones**.
  - This graph is defined **per provisioning operation**, not globally for the whole system.
- **Example**:
  ```
  Stage 1: Create network + create IAM resources (parallel)
  ↓
  Stage 2: Create cluster
  ↓
  Stage 3: Configure cluster + install components (parallel)
  ↓
  Stage 4: Deploy workloads
  ```
- **Contrast**: **Provisioning** is one operation (create). **Operating** covers everything after (alter, inspect, trigger). Both run through the same **Model**.

## Composing

Build a complete workflow by chaining resources, operations, and mechanisms under one model.

- **Answers**: *How do separate pieces become one process?*
- **Example** — "deploy a new service":
  1. Provision a DB (a resource)
  2. Create a repo (a resource)
  3. Run a migration via Terraform (a mechanism)
  4. Apply Kubernetes manifests via `kubectl` (a mechanism)
  5. Set up CI via `gh` (a mechanism)
  6. Configure secrets (an operation)
- **Contrast**: **Composing** is the *act of joining*. The pieces stay distinct — the system is the **glue** that orchestrates them, not their replacement.


## Expose / Adopt / Import

Bring a pre-existing resource under the system's model.

- **Answers**: *How does the system gain control of something it didn't create?*
- **Context**: The resource already exists outside the system (e.g., an AWS-created DB, a pre-existing remote repo).
- **Initial State**: The system does not own, provision, or manage it yet.
- **By Exposing It**: The system makes it discoverable, addressable, and inspectable within its model.
- **Result**: Any agent can reference, query, and interact with it just like a native resource created by the system.
- **Contrast**: Provision creates a resource. **Adopt** takes an existing one and makes it a first-class citizen — the system can manage it as if it had created it.

# Phase 03 - Discovery

## Domain Analysis

* The domain focuses on **declarative resource lifecycle management** across heterogeneous infrastructure layers.
* It sits at the intersection of **Infrastructure-as-Code (IaC), configuration management, and developer platform orchestration**.
* Unlike traditional IaC tools such as **Terraform**, this system goes beyond infrastructure provisioning.
* Unlike configuration management tools such as **Ansible**, this system also handles higher-level platform operations.
* The system covers both **resource provisioning** and **day-2 operational tasks**.
* These operational tasks include actions such as **template cloning, repository resets, and other resource lifecycle operations**.



## User Analysis

* **DevOps / Platform Engineers**: Primary users who write glue code (Python, Go, Bash scripts) or combine CLI workflows based on tools such as `gh`, `aws`, and `kubectl`. They need a unified interface to reduce script maintenance and standardize provisioning across environments.

* **Developers**: Secondary users who need simple, self-service provisioning without requiring deep knowledge of the underlying infrastructure mechanics.

* **System Administrators / SREs**: Need consistent day-2 operational commands to manage resources across multi-cloud and multi-layer environments without needing to understand provider-specific details.



## Existing Solutions Analysis

* **Terraform / OpenTofu**: Excellent for declarative infrastructure via cloud APIs, but cumbersome for lightweight operations, local file manipulation, or executing operational tasks (e.g., resetting Git history).
* **Ansible**: Strong at host configuration and task execution, but procedural and heavy for simple API or CLI-driven workflows.
* **Crossplane**: Kubernetes-native control plane approach, but requires a running Kubernetes cluster and complex Custom Resource Definitions (CRDs), which is overly complex for local/standalone CLI operations.
* **Ad-hoc Custom Scripts**: Current status quo; highly tailored but fragmented, hard to maintain, lacking a common schema or audit trail.

## Assumptions

1. **Abstraction Overhead**: A common model can be defined without sacrificing critical provider-specific parameters.
2. **Pluggable Mechanisms**: Existing CLI tools (`gh`, `aws`, `ovh`) or native APIs can be wrapped as modular driver/mechanism plugins.
3. **Brownfield Compatibility**: The system can inspect and adopt existing resources without requiring them to be recreated.
4. **Stateless vs. Stateful Control**: The system can maintain a minimal state tracking layer or rely on real-time discovery of resources in the environment.

## Constraints

* **Heterogeneity**: Must work across wildly different operational scales (single local file up to bare-metal OpenStack clusters).
* **Environment Polysemy**: Must cleanly separate lifecycle stages (`dev`, `prod`) from target infrastructures (`VM`, `S3`, `bare-metal`).
* **Tool Dependability**: Wrapping external CLIs means relying on external binaries being present or handling missing dependencies gracefully.

## Risks & Uncertainties

* **Over-Abstraction Risk**: Attempting to hide too much provider detail might make complex configurations impossible or inflexible.
* **State Drift & Discovery**: Managing pre-existing resources without taking full ownership of their underlying state can lead to drift or conflicts.
* **Mechanism Maintenance**: Wrapping third-party CLIs or APIs introduces risk when underlying tools update breaking changes.



# Phase 04 - Design Principles

Derived from the vision and problem:

1. **Common model, not common implementation.** Unify the *interface*, not the *backends*.
1. **Include, don't replace.** Existing resources and tools are first-class citizens.
1. **Composition over monolith.** Resources and operations compose into plans.
1. **Declarative where possible, imperative where necessary.** Support both.
1. **Idempotent by default.** Re-running a plan converges to the desired state.
1. **Dry-run first.** Every operation can be previewed.
1. **Provider-agnostic core.** Adding a provider must not require core changes.
1. **Escape hatches.** When abstraction leaks, allow native tool access.
1. **Secure by default.** Least privilege, no secret leakage, auditable.
1. **Observable.** Structured logs, traces, and audit records for every action.

**Non-Goals (Explicit)**

1. **Not** a replacement for Terraform, Ansible, Pulumi, or Helm.
1. **Not** an application deployment or release system.
1. **Not** a runtime orchestrator (scheduling, autoscaling apps).
1. **Not** a new cloud provider or hypervisor.
1. **Not** a day-2 application operations platform (though cluster day-2 *is* in scope).


**To resolve in later phases:**

1. **Abstraction level**: lowest-common-denominator vs. layered (portable core + provider extensions)?
1. **State model**: external state file, live reconciliation, or hybrid?
1. **Execution model**: agentless CLI, agent-based daemon, or central controller?
1. **Interface form**: library (Go/Python), DSL (YAML/HCL/CUE), or hybrid?
1. **Provider contract**: what is the minimal interface every provider implements?
1. **Idempotency scope**: per-resource, per-operation, or per-plan?
1. **Error taxonomy**: unified model across HTTP, CLI, and SDK failures?
1. **Secrets**: integrate with Vault/SOPS/cloud KMS, or own the store?
1. **Git operations**: first-class primitive or just another resource provider?
1. **Multi-tenancy**: single-user CLI vs. shared service with RBAC?

**Success Criteria** (Phase 01 Exit)

1. A single provisioning definition can target **≥2 environments** and **≥3 resource types** without core changes.
1. Adding a new provider requires **only** implementing a documented interface.
1. Operations are **idempotent** and **dry-runnable**.
1. Secrets never appear in logs or state in plaintext.
1. Provisioning actions are **auditable** end-to-end.
1. One workflow can **reset Git history**, **provision a VM**, **bootstrap a cluster**, and **place files in S3**.


# Phase 04 - Requirements

## Functional Requirements

**FR-01: Uniform Resource Definition**

The system must allow users to define resources and target environments using a single, unified declarative schema.

**FR-02: Multi-Mechanism Execution**

The system must support pluggable execution mechanisms, wrapping shell scripts, CLI binaries (e.g., `gh`, `aws`), or direct REST/gRPC APIs.

**FR-03: Multi-Granularity Resource Support**

The system must handle resources of varying operational scales:

* Files (local filesystem, S3, remote storage).
* Compute units (VMs on OVH/AWS, bare-metal nodes).
* Clusters (Kubernetes on VMs/containers, OpenStack on bare metal).
* Code repositories (GitHub, GitLab, local/SSH Git repos).

**FR-04: Polysemic Environment Mapping**

The system must support dual-dimension environment declarations:

* Lifecycle stage (`dev`, `stage`, `preprod`, `prod`).
* Physical or logical substrate (`bare-metal`, `hypervisor`, `container`, `cloud-provider`).

**FR-05: Adoption of Existing Resources**

The system must be able to discover, import, and operate on resources that were provisioned outside of this system.

**FR-06: Day-2 Operations Execution**

Beyond initial provisioning, the system must support operational workflows (e.g., `reset-history`, `apply-template`, `health-check`).

## Non-Functional Requirements

**NFR-01: Extensibility**

Adding a new resource type or environment mechanism must not require modifying the core orchestration engine.

**NFR-02: Portability & Minimal Footprint**

The core tool must run standalone on local developer workstations or CI/CD runners without mandatory heavy dependencies.

**NFR-03: Composability**

Resources must be composable so that high-level resources (e.g., a Kubernetes cluster) can declare dependencies on lower-level resources (e.g., a set of VMs).

**NFR-04: Idempotency**

Provisioning and configuration operations should be idempotent where the underlying mechanism allows.

## Business Rules & Constraints

**BR-01: Single Source of Truth**

Resource configurations and operational state mappings must remain explicit and versionable in code.

**BR-02: Non-Destructive Adoption**

Importing pre-existing resources into the system must default to read-only discovery before executing any state-modifying operation.

## Acceptance Criteria

**AC-01**

A user can define a single local file and a remote S3 object using the same syntax structure and execute provisioning via a single command.

**AC-02**

A user can run an operation on an existing GitHub repository using the common system interface without invoking `gh` or raw API requests directly.

**AC-03**

The system cleanly validates configuration syntax when target environments differ only by lifecycle tag (`dev` vs. `prod`) while sharing substrate types.


# Phase 05 - Specification

## Product Core Concept

The system provides a CLI client and core engine (provisionally named `rctl`) that parses declarative resource specifications, maps them to an execution environment context, and delegates operational tasks to modular mechanisms (drivers/providers).

## Features

**FE-01: Declarative Manifest Parser**

Parses resource files defining desired state, target environment attributes, and explicit mechanisms.

**FE-02: Environment Context Selector**

Evaluates environmental parameters to resolve target substrates (e.g., local vs cloud) and lifecycle target tags (`dev` vs `prod`).

**FE-03: Mechanism Driver Router**

Dispatches operation execution to the appropriate driver binary, API SDK, or wrapper script based on resource type and operational capability.

**FE-04: Resource Dependency Graph**

Resolves evaluation order for composite resources (e.g., ensures VMs exist before attempting cluster installation on those VMs).

**FE-05: Adoption Engine**

Scans and binds existing unmanaged infrastructure into the `rctl` tracking framework without forcing state re-creation.

**FE-06: Command Safety & Capability Contract**  
Every executable operation must expose a mandatory self-describing contract detailing its inputs, flags, side effects, destructive warnings, required confirmations, environment variables, and exit codes. The engine enforces this contract prior to execution (e.g., triggering interactive confirmation for destructive actions unless `--force` is provided).


**FE-07: Dual Execution Driver Model**
The engine must support both 
- in-process drivers (compiled Go functions) for core/built-in capabilities
- external drivers (standalone binaries communicating via Stdio JSON-RPC) for community/extensible capabilities.

## Core Workflows

```
   Declarative Manifest (YAML/JSON)
               │
               ▼
   [ rctl Core Engine ]
               │
               ├── 1. Resolve Environment & Substrate Context
               ├── 2. Build Dependency Tree
               │
               ▼
   [ Driver Router ] ─── Select Mechanism
               │
   ┌───────────┼───────────────┬────────────────┐
   ▼           ▼               ▼                ▼
[Shell/Go]  [gh CLI]     [Cloud APIs]    [Ansible/SSH]
   │           │               │                │
   └───────────┴───────┬───────┴────────────────┘
                       ▼
          Target Environment Substrate
 (Local FS / S3 / VMs / Bare-Metal / K8s / GitHub)

```

```
                       ┌────────────────────────────────┐
                       │       rctl Core Engine         │
                       └───────────────┬────────────────┘
                                       │
                         Driver Interface (Go Interface)
                                       │
               ┌───────────────────────┴───────────────────────┐
               ▼                                               ▼
┌─────────────────────────────┐                 ┌─────────────────────────────┐
│    In-Process Go Driver     │                 │   Stdio External Driver     │
│   (Local Files, Manifests)  │                 │    (Subprocess Wrapper)     │
└─────────────────────────────┘                 └──────────────┬──────────────┘
                                                               │
                                                               │
                                                       (stdin / stdout)
                                                               │
                                                               │
                                                               ▼
                                                       External Subprocess
                                                       (rctl-driver-git)
```
Meaning:
- The Engine only interacts with a `Go` interface.
- **Built-in drivers:** 
  - Are used for core system primitives (file:, manifest:).  
  - are written as pure Go functions
  - are compiled directly into the binary.
  - Execute with zero IPC overhead 
- **External (Stdio) drivers** (like git: or ovh:)
  - Are Independent binaries on $PATH wrapped by a Go Stdio adapter
  - Receive JSON payloads via stdin
  - return JSON results via stdout.
  - Are wrapped by a single Go adapter inside the `CLI` 
  - Handles the stdin/stdout JSON RPC communication under the hood.
  - Can be written in any language



### Workflow 1: Provisioning a New Resource

1. User invokes the system specifying a target manifest and environment context.
2. Core engine parses the manifest and builds the resource dependency graph.
3. Engine checks environment target (resolves substrate and lifecycle context).
4. Engine invokes the designated mechanism driver for each node in the graph.
5. Driver interacts with target environment to bring resource to desired state.

### Workflow 2: Operating on an Existing Resource

1. User invokes an operational task targeting a specific resource.
2. Engine verifies the existence/binding of the targeted resource.
3. Engine passes operational parameters to the bound mechanism (e.g., GitHub API driver or `gh` wrapper).
4. Operation result is returned and logged in a standard output format.


# Phase 06 - Design


## Driver Model Specification

A **Driver** is an execution module responsible for translating `rctl` operations into target infrastructure actions.

### Driver Execution Interfaces
The core engine interacts with all drivers through a single unified Go interface:

```go
type Driver interface {
    // Returns the command contracts, flags, warnings, and exit codes
    Capabilities(ctx context.Context) (CapabilityManifest, error)
    
    // Returns the live state of a target resource URI
    Inspect(ctx context.Context, target string) (ResourceState, error)
    
    // Executes an operational verb against a target resource
    Execute(ctx context.Context, req ExecutionRequest) (ExecutionResult, error)
}
```

## Product Architecture & Interfaces

The system uses a layered architecture decoupling the user interface, the core orchestration engine, and the execution modules (drivers/mechanisms).

```
   ┌─────────────────────────────────────────────────────────┐
   │                  CLI / User Interface                   │
   │            (Command Grammar: Open Design)               │
   └───────────────────────────┬─────────────────────────────┘
                               │
   ┌───────────────────────────▼─────────────────────────────┐
   │                     Core Engine                         │
   │  ┌──────────────────┐ ┌──────────────────────────────┐  │
   │  │ Manifest Parser  │ │ Environment & Context Solver │  │
   │  └──────────────────┘ └──────────────────────────────┘  │
   │  ┌──────────────────┐ ┌──────────────────────────────┐  │
   │  │ Dependency Graph │ │ Driver Router & Dispatcher   │  │
   │  └──────────────────┘ └──────────────────────────────┘  │
   └───────────────────────────┬─────────────────────────────┘
                               │
   ┌───────────────────────────▼─────────────────────────────┐
   │                  Mechanism Driver Layer                 │
   │ ┌───────────────┐ ┌───────────────┐ ┌─────────────────┐ │
   │ │  CLI Wrappers │ │ Native Plugins│ │ Custom Scripts  │ │
   │ │ (gh, aws...)  │ │ (Go/APIs)     │ │ (Bash/Python)   │ │
   │ └───────────────┘ └───────────────┘ └─────────────────┘ │
   └───────────────────────────┬─────────────────────────────┘
                               │
   ┌───────────────────────────▼─────────────────────────────┐
   │                   Target Environments                   │
   │ (Local FS, Cloud Providers, Bare Metal, Git Hosts, K8s) │
   └─────────────────────────────────────────────────────────┘

```

## Workflows & Technical Interaction

### 1. Conceptual Manifest Structure (Schema Syntax Open)

```yaml
version: "v1alpha1"
metadata:
  name: "dev-environment-setup"

environment:
  lifecycle: "dev"
  substrate: "mixed"

resources:
  - id: "app-config"
    type: "file"
    environment: "local-fs"
    mechanism: "builtin:file"
    spec:
      path: "/etc/app/config.json"
      content: "..."

  - id: "cluster-vms"
    type: "compute-group"
    environment: "ovh-cloud"
    mechanism: "wrapper:openstack-cli"
    spec:
      count: 3
      flavor: "b2-7"

  - id: "k8s-cluster"
    type: "kubernetes-cluster"
    environment: "ref:cluster-vms"
    mechanism: "script:ansible"
    depends_on:
      - "cluster-vms"
    spec:
      version: "1.30"

```

### 2. User Interface Design Requirements

The CLI command grammar, flag structure, and operational verbs are explicitly left open to be determined during design exploration and validated via PoC.

Key capabilities that the eventual command line interface must expose include:

* Declarative application of resource manifests.
* Direct invocation of ad-hoc operations on a specified resource.
* Adoption and binding of existing external resources into system management.
* Inspection and discovery of managed resource status across environments.

## Command Operation Contract (Single Source of Truth)

- All **drivers** declare command specifications via a structured capability manifest. 
- This manifest acts as the sole source of truth for 
  - dynamic `--help` generation
  - engine runtime safety guards
  - auto-generated documentation.

### Contract Schema Structure
* **Command Purpose & Arguments:** Explicit positional inputs and named flags with defaults.
* **Safety & Warnings:** Destructive operation flags, required safety overrides (e.g., `--force`), and side-effect declarations.
* **Environment Dependencies:** Required tokens, keys, or local binary requirements.
* **Exit Code Mapping:** Standardized code declarations (e.g., `0`: Success, `1`: Operational Failure, `2`: Invalid Arguments).
* **Examples & Usage:** Canonical execution patterns.


```yaml
# Driver Capability Output (e.g., rctl-driver-git capabilities)
operation: "reset-history"
summary: "Remove remote branch history"
warning: "DESTRUCTIVE OPERATION: Irreversibly overwrites remote Git commit history."

inputs:
  arguments:
    - name: "target"
      type: "resource-uri"
      required: true
  options:
    - name: "--force"
      type: "boolean"
      default: false
      description: "Bypasses interactive safety confirmation"

environment:
  required_vars:
    - "GITHUB_TOKEN"

safety:
  interactive_confirmation: true
  side_effects:
    - "Overwrites remote branch HEAD with local commit state."

exit_codes:
  0: "Success - Remote history replaced"
  1: "Operational failure - Network or auth error"
  2: "Invalid arguments"

examples:
  - command: "rctl git:my-org/my-repo reset-history"
    description: "Prompts for confirmation before rewriting remote history"
  - command: "rctl git:my-org/my-repo reset-history --force"
    description: "Executes non-interactively in CI/CD pipelines"
```

# Phase 07 - Architecture

## System Structure & Principles

**Modularity**: The core engine (`rctl-core`) contains no cloud-provider or third-party tool logic. All execution is delegated via a unified driver interface (`Driver` interface).

**Stateless Engine with State Mirroring**: The system favors real-time discovery via drivers, while maintaining a minimal state mapping file (`rctl-state.json`) to track bindings to existing resources.

## Key Decisions (ADRs)
cf. [ADRs][adr list]
# Phase 08 - Development

## 1. Roadmap & Milestones

* **Milestone 01: Core Engine & Single File Resource (PoC)**
* Implement the Go core engine to parse basic YAML manifests.
* Validate driver communication over stdio using a simple local file driver.


* **Milestone 02: Multi-Mechanism & CLI Wrapper (PoC)**
* Add support for external CLI execution (e.g., wrapping `gh` for GitHub repository operations).
* Validate operational task execution (`rctl run reset-history`).


* **Milestone 03: Minimum Viable Product (MVP)**
* Introduce dependency graph resolution for composite resources.
* Support environment context resolution (`lifecycle` vs `substrate`).
* Add the `rctl adopt` command to bind pre-existing resources.

## 1. Roadmap & Milestones

The project will be built incrementally, starting with validation through targeted **Proof of Concepts (PoCs)** before locking in the initial **MVP (Minimum Viable Product)**.

```
PoC-001 (CLI Grammar) ──┐
                         ├──▶ PoC-003 (Core Engine & Graph) ──▶ MVP Release (v0.1.0)
PoC-002 (Driver Stdio) ──┘
```

## 2. Proof of Concepts (PoCs)

Before building the full engine, two critical uncertainties must be validated through minimal experiments:

### PoC-001: CLI Grammar & UX Exploration

* **Objective:** Test and validate different command-line interface patterns to find the most intuitive syntax.
* **Scope:** Explore options like:
* Verb-Noun (e.g., `rctl apply -f manifest.yaml`, `rctl run reset-history ...`)
* Noun-Verb (e.g., `rctl resource apply ...`, `rctl resource operate ...`)


* **Success Criteria:** Select a clear, predictable CLI pattern that works across both declarative state management and ad-hoc operations.

### PoC-001: Stdio JSON-RPC Driver Interface - TODO

* **Objective:** Validate that the core Go engine can execute an external script or binary driver using stdin/stdout JSON-RPC without performance or blocking issues.
* **Scope:** Implement a minimal `builtin:file` driver (written in Bash or Python) that creates or modifies a local file upon receiving JSON instructions from `rctl`.
* **Success Criteria:** Core engine successfully invokes the driver, passes parameters, and captures return codes and output logs.



### PoC-002: Stdio Driver Protocol

* **Objective:** Verify that the core engine can invoke an external mechanism driver (e.g., a simple Bash script or Go binary) using JSON over stdin/stdout.
* **Scope:** Implement a tiny runner that passes a JSON payload to a script wrapping the `gh` CLI or local file operations, and parses its JSON output.
* **Success Criteria:** Prove that drivers can be written in any language without recompiling the core tool.

## 3. MVP Definition (v0.1.0)

Once the PoCs validate the grammar and driver communication, the **MVP** will deliver the minimum functional engine:

* **Core Engine:** Single Go binary parsing a basic YAML manifest and resolving a simple resource dependency list.
* **Supported Mechanisms (Initial):**
1. Built-in local file driver (create/update local files).
2. One external wrapper driver (e.g., basic Git or GitHub operation).


* **Target Outcome:** Demonstrate provisioning a local file and performing an operation on a Git repository using a single unified model.

## 3 MVP Definition (v0.1.0) - TODO

The MVP aims to prove the core value proposition: **managing two radically different resources on two different substrates using a single manifest and common CLI syntax.**

* **MVP Scope:**
1. Core CLI binary (`rctl apply`, `rctl run`, `rctl list`).
2. Support for 2 driver mechanisms:
* Local File Driver (`builtin:file` or Python script).
* GitHub Repository Driver (wrapping `gh` CLI or REST API).


3. Execution across 2 distinct environments:
* `local-fs` substrate.
* `github-cloud` substrate.


4. Operational command support (e.g., executing a repo reset operation).



# Phase 09 - Validation

## Objective

Verify that the `rctl` system accurately parses manifests, executes operations across heterogeneous drivers, handles environment context correctly, and manages error states gracefully without damaging target infrastructure.

## Test Strategy

### 1. Unit & Schema Testing

* **Manifest Parsing:** Validate that valid YAML/JSON manifests parse correctly and invalid syntax yields helpful diagnostic errors.
* **Environment Context Resolution:** Test that context evaluation correctly isolates `lifecycle` tags (`dev` vs `prod`) and `substrate` parameters.

* **Dependency Graph Evaluation:** Ensure cyclic dependencies in resource manifests are detected and rejected before execution.
* **Unit Testing:** Core engine manifest parsing, schema validation, and dependency graph sorting algorithms.
* **Integration Testing:** Driver communication via stdio/JSON-RPC using mock driver executables.
* **End-to-End (E2E) Testing:** Real-world execution of `rctl apply` against test local file systems and test Git/GitHub environments.

### 2. Integration & Driver Testing

* **Stdio Protocol Compliance:** Verify that drivers correctly read JSON inputs from `stdin` and return standard JSON results to `stdout`.
* **Idempotency Checks:** Run provisioning workflows sequentially to confirm that repeated executions do not cause unintended side effects or state drift.
* **Failure & Rollback Handling:** Simulate driver failures during execution to ensure the core engine reports exact step failures and halts dependent downstream resources.

### 3. Acceptance Criteria Verification

* **AC-01 Validation:** Provision a local file resource and a remote object/resource through a single engine execution.
* **AC-02 Validation:** Execute a day-2 operation (e.g., repository template initialization or history reset) on a remote Git resource using the unified interface without raw CLI/API invocation.
* **AC-01-01 (Multi-Resource Apply):** Run `rctl apply` on a manifest containing both a local file creation and a GitHub repo setup. Verify both resources are brought to the desired state in a single execution.
* **AC-02-02 (Operational Run):** Execute `rctl run reset-history --resource repo:test-app` and verify the action completes via the underlying mechanism without invoking `gh` manually.


# Phase 10 - Release

## Objective

Package, distribute, and document production-ready releases of `rctl` as a single portable binary across major operating systems.

## Readiness Checklist

* [ ] Core engine binaries compiled for Linux (`amd64`/`arm64`), macOS (`darwin`), and Windows.
* [ ] Built-in drivers bundled or verified accessible in path.
* [ ] Stdio driver protocol specification documented for community driver authors.
* [ ] Integration test suite passing across supported platforms.
* [ ] Basic user documentation, getting started guides, and sample manifests published.

## Deployment & Distribution

* **Artifacts:** Single static binary releases generated via automated CI/CD pipelines (e.g., GitHub Releases).
* **Install Mechanisms:** Shell installation script, direct binary download, or package manager distribution (e.g., Homebrew tap, AUR).

## Rollback & Safety Plan

* Fast binary deprecation strategy if critical engine bugs are discovered.
* Breaking changes to manifest schemas or driver Stdio protocols will follow strict Semantic Versioning (`vX.Y.Z`).


# Phase 11 - Operate & Evolve

## Objective

Maintain, monitor, and continuously improve `rctl` based on operational usage, driver ecosystem expansion, and community feedback.

## Maintenance & Monitoring

* **Diagnostics & Logging:** Provide verbose debugging modes (e.g., `--debug` flag) printing raw Stdio JSON payloads exchanged between the core engine and external drivers.
* **Telemetry & Analytics:** Zero default phone-home telemetry to guarantee privacy in restricted/air-gapped enterprise environments.

## Evolution Cycle

```
  OPERATE (Daily usage across projects)
     │
     ▼
  LEARN (Identify new resource types & missing mechanisms)
     │
     ▼
  EVOLVE (Add driver capabilities or refine core engine)
     │
     ▼
  RELEASE (Version bump & distribution)
     │
     ▼
  OPERATE

```

### Future Evolution Roadmap

* **Community Driver Ecosystem:** Maintain an index/registry of community-contributed mechanism drivers.
* **State Drift Auto-Remediation:** Introduce optional background/scheduled sync commands to detect and reconcile out-of-band state changes.
* **Interactive TUI:** Consider an optional Terminal User Interface (TUI) for real-time visualization of complex resource dependency graphs during execution.



# TODO TODO Interface Mockups (CLI)

```bash
# Provision resources defined in manifest
rctl apply -f infra-setup.yaml --env stage

# Inspect tracked resources across environments
rctl list --env dev

# Execute specific operation on an existing resource
rctl run reset-history --resource github:org/repo-name

# Import pre-existing resource without recreation
rctl adopt --type vm --id ovh:instance-12345 --name build-node-01
## TODO TODO CLI Commands


* `rctl apply -f <manifest>`: Parses, resolves dependency graph, and applies target state.
* `rctl run <operation> --resource <id>`: Executes an ad-hoc operation on a target resource.
* `rctl adopt --resource <type> --provider-id <id>`: Binds an existing resource to the `rctl` model.
* `rctl list`: Displays managed resources and their statuses across environments.

---

```
