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


<h1 align="center">Project - Phase2: Terminology</h1>


# Rquest
- An expression of intent sent by an **agent** to the system, asking for an operation on a resource.
- Has a **lifecycle**: Lifecycle phases include, at minimum:
  - **requested** — the agent has emitted the request.
  - **accepted** — the system has admitted the request (it is valid and corresponds to a capability).
  - **rejected** — the system has refused the request (e.g. the operation does not match a capability).
  - **ignored** — the system has neither accepted nor rejected it.
  - **running** — the operation is executing.
  - **succeeded** / **failed** — the operation has finished.
  - **Acceptance ≠ success.** Acceptance means the request was valid and admitted. Success depends on execution.

  - **Answers**: *What did the agent ask for, and what happened to it?*
  - **Contrast**: 
    - An **operation** is *what is requested*. 
    - A **request** is *the act of asking for it, plus its lifecycle*.

# Resource
- cf. [Resource][res whatis] 
- **Contrast**: 
  - A **Target** hosts a resource. 
  - A **Mechanism** acts on it
  - An agant request an **Operation** on it.
  - The resource (kind) has a (specific) set of **capabilities** (often verb, but not mandatory - find use case).

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


# Mechanism

The underlying tool, client, driver, or API used to execute operations on a resource.

- **Answers**: *How is the action carried out?*
- **May be**:
  - custom scripts (Go, Python, Shell, Ansible playbook)
  - dedicated CLI tools (e.g., `gh`, `aws`, `terraform`, `ansible`)
  - direct API calls (e.g., GitHub REST/GraphQL API, OpenStack API, AWS SDK)
  - Any CLIs or APIs.
- **Contrast**: A **Resource** is what gets acted upon. A **Target** is where it lives. A **Mechanism** is *how* the operation is executed.



# Target

The underlying platform or system hosting a resource.

- **Answers**: *Where does it live?*
- **May be**:
  - a standalone container, VM, bare-metal host, or a set/cluster of them
  - a cloud (e.g., AWS, OVH, Azure, GCP)
  - a local filesystem or an S3 bucket
  - a CI/CD runner or a sandbox
  - an edge device or an IoT node
  - local or remote, public or private
  - Container Runtime: e.g; CRI-o, containerd, Docker
  - Hypervisor: e.g; VMware, KVM, Hyper-V
  - platform: e.g. OpenStack, AWS, OVHcloud, Kubernetes
  - Any CLIs or APIs.

- **Contrast**: A **Resource** is what is hosted. A **Mechanism** is how it's acted upon. A **Target** is the execution context — the *where*.



# Resource vs Target

The same thing can be a resource in one operation and a target in another.

| Thing | As resource | As target |
| ----- | ----------- | --------- |
| A VM | when rebuilt, reset, destroyed | when a package is installed on it |
| A Kubernetes cluster | when provisioned, destroyed | when a workload is deployed onto it |
| A filesystem | when formatted, resized | when a file is written to it |

The distinction is not intrinsic to the thing; it is relative to the **operation** being performed.



# Granularity

The scale and composition of a resource — how atomic or how composite it is.

- **Answers**: *How big or how composed is the thing?*
- **May range from**:
  - atomic primitives — a single file on a filesystem or on S3
  - to complex multi-node platforms:
    - an OpenStack cluster (deployed over several bare-metal hosts)
    - a Kubernetes cluster (deployed over several VMs or containers)
- **Contrast**: **Kind** is *what* a resource is (a VM, a cluster). **Granularity** is *how large or how composed* it is.

# Operation

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



# Model

The abstract schema or declarative structure used to represent resources, targets, and their relationships uniformly.

- **Answers**: *How are things represented in a common way?*
- **May be**: 
  - a schema
  - a declarative structure
  - a type system
  - anything that lets the same terms describe any resource in any target.
- **Contrast**: The **Model** is the *representation*. **Mechanisms** and **Targets** are the *reality* it describes. The model is common; the underlying things vary in **kind** and **granularity**.

# Provisioning

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

# Composing

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


# Expose / Adopt / Import

Bring a pre-existing resource under the system's model.

- **Answers**: *How does the system gain control of something it didn't create?*
- **Context**: The resource already exists outside the system (e.g., an AWS-created DB, a pre-existing remote repo).
- **Initial State**: The system does not own, provision, or manage it yet.
- **By Exposing It**: The system makes it discoverable, addressable, and inspectable within its model.
- **Result**: Any agent can reference, query, and interact with it just like a native resource created by the system.
- **Contrast**: Provision creates a resource. **Adopt** takes an existing one and makes it a first-class citizen — the system can manage it as if it had created it.
