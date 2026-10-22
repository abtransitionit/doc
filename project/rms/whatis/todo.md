
# Todo 
## List
- **Provision** resources: create files, VMs, Clusters, Git repositories, and other resources.
- **Operate** resources: update files, configure hosts, manage repositories, install packages.
- **Abstract** implementations: use scripts, CLIs, protocols, or APIs without exposing their implementation details to the Agent.
- Compose operations: combine multiple operations into higher-level workflows spanning multiple resources and environments.
- Report outcomes: return execution status, results, and errors through a consistent interface.


## Abstract implementations


- Create a file: use local filesystem operations, SSH commands, or an S3 API.
- Create a VM: use the OVH API, AWS API, OpenStack CLI, or a local hypervisor.
- Execute a command: use SSH, WinRM, or a container runtime interface.
- Manage a Git repository: use local Git commands, `gh`, `glab`, or GitHub/GitLab APIs.
- Install a package: use `apt`, `dnf`, or `winget`, locally or remotely.
- Deploy a workload: use `kubectl`, a Kubernetes API client, or a provider-specific deployment interface.

