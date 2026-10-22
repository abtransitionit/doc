# List of Use Cases

## From User Intent to System Execution

All use cases follow the same process.

1. **The Agent**
   - Expresses its intent through the System interface. For example, "Install a package on an existing remote VM."
   - Provides the input required by the System.

2. **The System**
   - Builds a structured request from the Agent's intent and supplied input.
   - Validates the request to ensure that the required information is provided and that the request is well-formed and consistent.
   - Resolves the request by identifying the target host, the resource to manage, the requested capability, and the information required for execution.
   - Selects an available mechanism capable of performing the requested capability on the resource hosted by the target host.

3. **The System**
   - Executes the validated request by invoking the selected mechanism to perform the requested operation on the target resource.

4. **The System**
   - Returns a result by communicating the execution outcome to the Agent.

1. **The Agent:**
   - Expresses its intent through the System interface. For example, "Install a package on an existing remote VM."
   - Provides the input required by the System to perform the required task.
     - For example, the target VM's connection details and the package to install.

3. **The System**
   - Translates the Agent's intent and supplied input into a request.
   - Selects an available mechanism capable of performing the requested capability on the resource hosted on that host.

4. **The System**
   - Executes the request.
   - Invokes the selected mechanism to perform the requested operation on the resource hosted on that host.

5. **The System**
   - Returns a result.
   - Communicates the execution outcome to the Agent.

## Install a Package on an Existing Remote VM

0. The Agent is a user invoking the System with the required input.
0. The Agent is a user invoking the System with the required input.

1. **Agent intent:** Install the `nginx` package on a remote VM.
1. **Identify the resource:** The Agent provides the required inputs: the VM's connection details and the package name.
2. **Represent the resource:** The System registers or references the VM as a `Host` resource that acts as a target.
3. **Select the capability:** The user requests the `Install Package` capability for that host.
4. **Select the mechanism:** The System uses SSH to connect to the VM and APT to install the package.
5. **Execute the capability:** The System runs the appropriate installation command, such as `apt install nginx`.
6. **Report the result:** The System reports whether the installation succeeded or failed.

# Todo

## Install the Same `nginx` Package Artifact on Ten Different Hosts, Potentially at Different Versions

### Package Management

- Provision a package repository in an environment.
- Provision package artifacts into an environment.
- Manage packages, package repositories, and package artifacts.
  - Install, upgrade, and remove packages.
  - Inspect installed packages and their versions.
- Other:
  - Retrieve packages from repositories.
  - Publish packages to repositories.

### Resource Provisioning

- Create and provision resources in an environment.
- Allocate resources to an environment.
- Discover existing resources.
- Import resources already present in an environment.

### Resource Lifecycle Management

- Inspect resource state.
- Configure resources.
- Start and stop resources where applicable.
- Update resources.
- Delete or decommission resources.
- Track resource lifecycle transitions.

### Resource Composition

- Represent composite resources.
- Represent relationships between resources.
- Model resources containing resources of different kinds.
- Navigate resource hierarchies.

### Resource Kind Management

- Define resource kinds.
- Extend the kind hierarchy.
- Discover the kinds supported by the System.
- Identify the kind of a resource.

## Discovery Questions

- What operations can the System perform on resources?
- Which resource kinds must the System support?
- Which resources can contain other resources?
- How are resources related to environments?
- Does the System manage resources directly or delegate operations to external tools?
- Does the System track desired state, actual state, or both?

## Assumptions and Open Decisions

- The System may manage both resource artifacts and resources provisioned into environments.
- Resource provisioning and resource lifecycle management are distinct but potentially related responsibilities.
- The distinction between a resource artifact and an installed or provisioned instance remains undecided.
- The System's interface (CLI, API, or both) remains undecided.