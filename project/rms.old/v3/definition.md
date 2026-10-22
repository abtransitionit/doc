# Agent

- An entity that interacts with the System to:
  - Express an intent.
  - Provide input.
  - Receive results.
- **Example:**
  - A user who intends to install a package on an existing remote VM.

**Kind**

- **Human user**
- **Script**
- **AI agent**
- **CI/CD pipeline**
- **External system or application**

# Intent

- Expresses what an Agent wants the System to achieve.
- Describes the desired outcome, not the mechanism or the implementation.
- **Example:**
  - Install NGINX on an existing remote VM.

# Interface

- Defines **how** an Agent interacts with the System.
- **Examples:**
  - CLI
  - API
  - Web UI
  - SDK

# Input

- Information provided to the System by an Agent.
- **Example:**

  **Intent:** Install NGINX on an existing remote VM.

  **Inputs may include:**
  - The target VM's connection details.
  - The package name.
- Input requirements may depend on:
  - The requested resource capability.
  - The mechanism selected to implement the resource capability.

1. **Initial input:** The Agent provides the information required to express the intent and identify the requested operation, such as the target host and the package to install.
2. **Capability-dependent input:** The System determines whether additional information is required by the requested capability.
3. **Mechanism-dependent input:** After selecting a mechanism, the System determines whether additional information is required by that mechanism. If necessary, the Agent may be asked to provide it.
4. **Execution readiness:** Before execution, the System verifies that all required inputs are available and valid.

# Request

- A structured representation of an Agent's intent and the input provided to the System.
- **Process:**
  - The Agent expresses the intent.
  - The System builds a request from the intent and inputs.

# Execution

- The runtime invocation of a selected mechanism to perform a requested capability.

An execution may involve:

- **An existing resource:** The mechanism performs a capability on a resource hosted on a target host.
- **Resource creation:** The mechanism performs a capability to create a resource, which may then be associated with a host.

**Examples:**

- Install the `nginx` package on an existing remote `Host` (VM).
- Create a `Host` resource (VM) using a cloud API mechanism.

# Result

- The outcome returned by the System to the Agent after an execution.
- Indicates whether the requested capability succeeded or failed and provides relevant output or error information.
- **Example:**
  - After installing `nginx` on an existing remote `Host` (VM), the System returns a success status or an error describing why the installation failed.

# Resource

- An identifiable entity of a given kind.
- It can be:
  - Physical or virtual.
  - Atomic or composite.
  - Nested within another resource.

## Resource Kind

- Classifies resources in a hierarchical structure.
- For example, `file/txt/json` is a more specific kind than `file/txt`.

## Resource Root Kind

- The first item in a hierarchy path.

## Resource Properties

- Resources may have properties that describe their characteristics or state.
- The properties associated with a resource depend on its kind.
- How properties are defined, represented, and managed is left to the system model.

## Composite Resource

- A resource made up of other resources, potentially of different kinds.

## Physical Resource

A resource that represents a tangible physical entity.

**Examples:**

- CPU
- RAM module
- Disk
- Physical host

## Logical Resource

A resource that represents an entity defined or organized through software or data.

**Examples:**

- File
- Folder
- Variable
- Kernel parameter
- Software package
- Git repository

## Virtual Resource

A resource that represents a software-defined instance of a resource, often abstracting or emulating an underlying resource.

**Examples:**

- Virtual machine
- vCPU
- vDisk
- vNetwork

## Resource Capability

- A characteristic that describes what a resource is capable of providing or supporting.
- Before determining a resource's available capabilities, checks may be required. Examples include:
  - State
  - Dependencies
  - Availability
  - Limits
  - Permissions
  - Access rights
  - Health
  - Operational status

# Mechanism

A **Mechanism** defines how a resource capability is implemented or executed by the System.

A mechanism provides a concrete means of performing an operation on a resource. It may rely on a specific tool, protocol, API, service, or technology.

A mechanism may implement multiple capabilities, and a capability may be supported by multiple mechanisms.

### Relationship Between Concepts

- **Resource:** An identifiable entity managed by the System.
- **Capability:** An operation or function that can be performed on a resource.
- **Mechanism:** The means by which a capability is implemented or executed.

### Examples

| Resource   | Capability         | Mechanism                     |
| ---------- | ------------------ | ----------------------------- |
| File       | Read data          | Local filesystem, HTTP        |
| Package    | Install            | APT, DNF                      |
| Repository | Retrieve artifacts | Git, HTTP, S3                 |
| Host       | Provision          | Terraform, Ansible, cloud API |

# Resource Modeling Principle

The System models resources, their kinds, and their relationships.

It does not impose a predefined classification of resources as physical, logical, or virtual. Such distinctions may be introduced **later if required**.

# System

## Resource Configuration

Resource capabilities may depend on:

- **Intrinsic capabilities:** Inherent to the resource kind.
  - **Example:** A VM can execute workloads.
- **Configuration-dependent capabilities:** Determined by the resource's configuration.
  - **Example:** A VM may support nested virtualization when enabled.
- **Context-dependent capabilities:** Determined by the resource's environment or context.
  - **Example:** A VM can access a network when connected to it.
- **State-dependent capabilities:** Determined by the resource's current state.
  - **Example:** A stopped VM cannot execute workloads.

## System Input Requirements

**The System** defines and validates the input required to process a request.

## Resource Configuration

Resource capabilities may depend on:

- **Intrinsic capabilities:** Inherent to the resource kind.
- **Configuration-dependent capabilities:** Determined by the resource's configuration.
- **Context-dependent capabilities:** Determined by the resource's environment or context.
- **State-dependent capabilities:** Determined by the resource's current state.

## System Responsibility

- **Provisioning:** Create, install, deploy, or make a resource available in an environment.
- **Lifecycle and state management:** Inspect, configure, start, stop, update, or delete a resource.

**Examples:**

- The System manages packages inside an environment: install, upgrade, remove, inspect.
- The System manages package **artifacts** and **repositories**: build, publish, store, retrieve.

## System Extensibility

The System can be extended by:

- Defining new resources and their associated kinds.
- Extending the kind hierarchy by defining new kinds.

## System Scope

The System does not distinguish between physical, logical, and virtual resources **at this stage**.

## External Resources

The System may rely on any existing tool, protocol, API, service, or technology.

External resources are treated as **first-class citizens** within the System. This means they can be explicitly:

- **Identified:** Each resource can be uniquely distinguished.
- **Represented:** Each resource can be described within the System's model.
- **Referenced:** Each resource can be referenced by other resources or System components.
- **Managed:** Each resource can be managed according to its defined capabilities.
- **Extended:** New resource kinds and their associated capabilities can be introduced as needed.

The VM does not need to have been created or provisioned by the System. It can be managed as a resource because the System can identify, represent, reference, and operate on it through its supported capabilities and mechanisms.

**Example:**

- A user wants to install `nginx` on an existing remote VM.
- The System can represent that VM as a `Host` resource, identify it, and reference it.
- The System then uses an appropriate mechanism (such as SSH and APT) to perform the `Install Package` capability.
- The VM does not need to have been created or provisioned by the System to be managed as a resource.

Remove the duplicated Resource Configuration section