[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Project Blue][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[project software howto]: /project/blueprj/howto/boostrap.md
[res whatis]:             /concept/machine/whatis/res.md
Related topics

| Topic | Location| Kind |
|-|-|-|
|[How-to for Software Project][project software howto]|


**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Project: RCtl / Rpro</h1>

a System to provision and control Resources


# Phase 01 - Vision
Build a system that can provision and operate resources in environment through a common model.

The system should eventually be able to work with different kinds of resources and different kinds of environments, including resources that already exist.

## Problem
Provisioning resources usually requires different systems, tools, commands, configurations, and procedures for each environment.

* **Files**: May need to be created on a local filesystem, remote filesystem, or object storage (e.g., S3).
* **Virtual Machines**: May need to be created through different cloud or virtualization systems (e.g., OVH, AWS, local virtualization).
* **Clusters**: May be created or operated in very different ways (e.g., OpenStack on bare metal, Kubernetes on VMs, Kubernetes in containers).
* **Git Repositories**: May be managed through different mechanisms (e.g., GitHub, GitLab, SSH, local repositories).
* **Operations**: Include tasks beyond initial setup, such as resetting repository history or instantiating fresh repos from templates.

Currently, these tasks rely on disparate mechanisms:
* Custom scripts (Go, Python, Shell).
* Dedicated CLI tools (e.g., `gh`, `aws`).
* Direct API calls (e.g., GitHub REST/GraphQL API).

## Goals & Target Outcome
Provide a **common way** to **provision** and **operate** resources, independently of:
1. The environment in which they exist.
2. The underlying mechanism used to manage them.



---

# Phase 02 - Terminology

## Glossary

* [Resource][res whatis]: A managed entity with a defined state and lifecycle (e.g., a file, a VM, a Kubernetes cluster, a Git repository).
* **Environment**: The target execution context, substrate, or platform where a resource is hosted or operated (e.g., local filesystem, S3 bucket, set of bare-metal servers, AWS, OVH cloud).
* **Mechanism**: The underlying tool, client, driver, or API used to execute operations on a resource (e.g., `gh` CLI, custom Python script, AWS SDK, OpenStack API, Ansible playbook).
* **Operation**: An action performed on or against a resource to alter its state, trigger a workflow, or inspect its status (e.g., `provision`, `destroy`, `reset-history`, `get-status`).
* **Existing Resource**: A pre-existing piece of infrastructure or state not originally created by this system, but brought under its control and operational scope.
* **Model**: The abstract schema or declarative structure used to represent resources, environments, and their relationships uniformly.

## Concepts

### Environment

The term **Environment** as 2 differents meanings:

1. **Lifecycle Environment**: The stage in the software delivery pipeline (e.g., `dev`, `stage`, `preprod`, `prod`).
2. **Infrastructure/Substrate Environment**: The underlying platform or target system hosting the resources (e.g., bare-metal, VM hypervisor, container engine, public cloud provider).

### Granularity of a Resource

Resources vary drastically in scale and composition. A **Resource** can range from atomic primitives (a single file on a disk or S3) to complex multi-node platforms (an OpenStack cluster deployed over bare metal). The system treats both extremes through the same foundational model.


# Phase 03 - Discovery

## Domain Analysis

The domain centers on **declarative resource lifecycle management** across heterogeneous infrastructure layers. It sits at the intersection of Infrastructure-as-Code (IaC), configuration management, and developer platform orchestration. Unlike standard IaC tools (e.g., Terraform) that focus heavily on cloud API state management, or configuration tools (e.g., Ansible) focused on host configuration, this system bridges cross-domain actions—ranging from cloud infrastructure provisioning to day-2 operational tasks (such as template cloning or repository resets).

## User Analysis

* **DevOps / Platform Engineers**: Primary users who currently write glue code (Python, Go, Bash scripts) or compose CLI workflows (`gh`, `aws`, `kubectl`). They need a unified interface to eliminate redundant script maintenance and standardize provisioning across team environments.
* **System Administrators / SREs**: Need consistent day-2 operational commands to inspect, operate, and maintain resources across multi-cloud and multi-layer environments without learning provider-specific quirks.
* **Developers**: Secondary consumers who need simple, self-service provisioning of development resources without needing deep knowledge of the underlying infrastructure mechanics.

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

The system provides a CLI client and model engine (provisionally named `rctl`) that parses declarative resource specifications, maps them to an execution environment, and delegates operational tasks to modular mechanisms (drivers/providers).

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

## Core Workflows

```
   Declarative Manifest (YAML)
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

### Workflow 1: Provisioning a New Resource

1. User executes `rctl apply -f manifest.yaml --env dev`.
2. Core engine parses `manifest.yaml` and builds the resource graph.
3. Engine checks environment target (resolves substrate and lifecycle context).
4. Engine invokes the designated mechanism driver for each node in the graph.
5. Driver interacts with target environment to bring resource to desired state.

### Workflow 2: Operating on an Existing Resource

1. User executes an operational command (e.g., `rctl run reset-history --resource repo:my-app`).
2. Engine verifies the existence/binding of `repo:my-app`.
3. Engine passes operational parameters to the bound mechanism (e.g., GitHub API driver or `gh` wrapper).
4. Operation result is returned and logged in a standard output format.

## Interface Mockups (CLI)

```bash
# Provision resources defined in manifest
rctl apply -f infra-setup.yaml --env stage

# Inspect tracked resources across environments
rctl list --env dev

# Execute specific operation on an existing resource
rctl run reset-history --resource github:org/repo-name

# Import pre-existing resource without recreation
rctl adopt --type vm --id ovh:instance-12345 --name build-node-01

```



# Phase 06 - Design

## Product Architecture & Interfaces

The system uses a layered architecture decoupling the user interface (CLI), the core orchestration engine, and the execution modules (drivers/mechanisms).

```
   ┌─────────────────────────────────────────────────────────┐
   │                   rctl CLI / Interface                  │
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

### 1. Unified Manifest Schema (YAML Example)

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

### 2. Interface Specifications

**CLI Commands**:

* `rctl apply -f <manifest>`: Parses, resolves dependency graph, and applies target state.
* `rctl run <operation> --resource <id>`: Executes an ad-hoc operation on a target resource.
* `rctl adopt --resource <type> --provider-id <id>`: Binds an existing resource to the `rctl` model.
* `rctl list`: Displays managed resources and their statuses across environments.

---

# Phase 07 - Architecture

## System Structure & Principles

**Modularity**: The core engine (`rctl-core`) contains no cloud-provider or third-party tool logic. All execution is delegated via a unified driver interface (`Driver` interface).

**Stateless Engine with State Mirroring**: The system favors real-time discovery via drivers, while maintaining a minimal state mapping file (`rctl-state.json`) to track bindings to existing resources.

## Key Decisions (ADRs)

#### ADR-001 Architecture & Engine Language Selection

* **Context**: The engine must compile into a single portable binary, runnable on local workstations or CI/CD pipelines, with efficient subprocess invocation.
* **Decision**: Develop the core engine in **Go**.
* **Rationale**: Static binary with no external runtime dependencies, strong filesystem and subprocess management, and strong typing for data models.
* **Consequences**: Easy deployment and distribution, while retaining the ability to invoke Python, Bash scripts, or external CLI tools (`gh`, `aws`).

#### ADR-002 Plugin & Driver Execution Mechanism

* **Context**: The system must support third-party CLIs (`gh`, `aws`), scripts (`python`, `bash`), and native APIs.
* **Decision**: Adopt an external driver interface communicating via **Stdio (JSON RPC / stdin-stdout)**.
* **Rationale**: Avoids locking driver development into a single language. Any tool or script that reads and writes JSON can serve as an `rctl` driver.
* **Consequences**: Simplifies writing new drivers without recompiling the `rctl` core engine.

#### ADR-003 Dual-Dimension Environment Management

* **Context**: Environment refers to both the lifecycle stage (`dev`, `prod`) and technical substrate (`bare-metal`, `AWS`, `k8s`).
* **Decision**: Explicitly separate `lifecycle` and `substrate` fields in metadata and context resolution.
* **Rationale**: Allows reusing the same resource manifest across different substrates depending on the lifecycle phase.
* **Consequences**: Clearer definitions and elimination of ambiguity during target context resolution.

---

### Next Step

If these revised English versions look good to you, we can move forward to **Phase 08 - Development** to structure the roadmap, milestones, PoCs (such as testing Stdio JSON-RPC driver execution), and MVP scope!# Phase 08 - Development

## Roadmap & Milestones

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



## Proofs of Concept (PoCs)

#### PoC-001: Stdio JSON-RPC Driver Interface

* **Objective:** Validate that the core Go engine can execute an external script or binary driver using stdin/stdout JSON-RPC without performance or blocking issues.
* **Scope:** Implement a minimal `builtin:file` driver (written in Bash or Python) that creates or modifies a local file upon receiving JSON instructions from `rctl`.
* **Success Criteria:** Core engine successfully invokes the driver, passes parameters, and captures return codes and output logs.

## Minimum Viable Product (MVP) Definition

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



---

# Phase 09 - Validation

## Test Strategy

* **Unit Testing:** Core engine manifest parsing, schema validation, and dependency graph sorting algorithms.
* **Integration Testing:** Driver communication via stdio/JSON-RPC using mock driver executables.
* **End-to-End (E2E) Testing:** Real-world execution of `rctl apply` against test local file systems and test Git/GitHub environments.

## Acceptance Criteria Verification

* **AC-01 (Multi-Resource Apply):** Run `rctl apply` on a manifest containing both a local file creation and a GitHub repo setup. Verify both resources are brought to the desired state in a single execution.
* **AC-02 (Operational Run):** Execute `rctl run reset-history --resource repo:test-app` and verify the action completes via the underlying mechanism without invoking `gh` manually.

---

### Next Step

How does this look for the **Development** and **Validation** phases?

If you are happy with this, we can wrap up the initial `project.md` draft by adding **Phase 10 - Release** and **Phase 11 - Operate & Evolve**!