
# Conceptual Model

The vision implies a small number of **core concepts** that must be defined precisely:

## Resource
A **thing** that can be provisioned or operated. Has:
- a **type** (file, VM, cluster, Git repo, …),
- a **location** (local, remote, cloud, container, …),
- a **state** (absent, present, configured, running, …),
- a **lifecycle** (create, configure, operate, reset, destroy).

## Target
A **context** in which resources exist and operations run. Characterized by:
- **reachability** (local, SSH, API endpoint),
- **authentication** (keys, tokens, IAM, OIDC),
- **capabilities** (what resource types it can host),
- **constraints** (quotas, networking, air-gap).

## Mechanism (Provider)
A **means** by which a resource type in an environment is manipulated. Examples:
- CLI wrapper (`gh`, `aws`, `kubectl`).
- API client (REST, GraphQL, gRPC).
- SDK binding (boto3, client-go).
- Native protocol (SSH, S3 API, libvirt).

## Operation
A **unit of intent** applied to a resource. Examples:
- `create`, `configure`, `start`, `stop`, `reset`, `destroy`, `import`.
- Operations must be **idempotent** and **dry-runnable** where possible.

## Provisioning Plan
A **composition** of resources and operations with dependencies, forming a directed graph that can be planned, applied, and rolled back.
