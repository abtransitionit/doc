
Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Resource ](../whatis/resource.md) |concept
|[What is provisioning](../whatis/provision.md)|concept




<h1 align="center">Operate</h1>



# Definition

## Operate
* The action of operating on a [resource](../whatis/resource.md).
* **Operating on a resource** 
  - means acting upon that resource so that it produce a response.  
  -  Is Possible **only** when a resource is available and ready for operations
* Depending on the context, **operate** generally means: 
  - **start, stop, restart, execute, run, invoke or trigger**
  - **query, read, list, get or fetch** (for read operations)
  - **update, modify, patch or edit** (for write operations)
  - **delete, remove, destroy or terminate** (for delete operations)
  - **monitor, observe, log or trace** (for observability operations)


## Operator
An **Automation** concept with 2 contexts

### Context 1: Generic Automation Concept
- Something that operates on infrastructure or resource
- Something that manages the **lifecycle** of a resource **after it is provisioned**
- Example

  |Operator|Resource Managed|Actions Operate|
  |-|-|-|
  |VM Operator|VMs|start, stop, snapshot, resize, migrate|
  |Backup Operator|Scheduled backups (DBs, files)|backup, restore, verify, rotate|
  |Scaling Operator|manages auto-scaling of application instances based on metrics|scale up, scale down, rebalance|
  |Logging Operator|Log collection and Rotation across a fleet of servers|collect, rotate, archive, forward|
  |Network Operator|Network configuration and routing rules| assign IP, update firewall rules, configure load, balancers, manage DNS records|

### Context 2: Generalization of the concept popularized by Kubernetes
- Something that manages the **entire lifecycle** of an infrastructure or resource, **including provisioning**.
- Typically, uses a control loop to **continuously** reconcile the desired state with the actual state.
- Example

  |Operator|Resource Managed|Actions Operate|
  |-|-|-|
  | Kubernetes Operator | Kubernetes application | deploy**, scale, update, backup, recover|
  | Deployment Operator | Kubernetes deployment | deploy**, rollback, promote, canary|
  | Database Operator | database clusters | provision**, backup, failover, upgrade|
  |Message Queue Operator | message brokers like Kafka or RabbitMQ | **provision**, partition rebalance, upgrade, scaling, mirroring|
  | Certificate Operator | TLS/SSL certificates | **provision**, renew, revoke, rotate|
  | Storage Operator | persistent storage volumes | **provision**, resize, snapshot, restore, replication|
  | Service Mesh Operator | service mesh infrastructure (Istio/Linkerd) | **provision**, injection, configuration, upgrade, observability|

# Kind

Operation can be classified in this categories

| Category | Example |
|-|-|
| Lifecycle | start, stop, restart, pause, resume|
| Execution | execute, run, invoke, trigger, deploy|
| Read |query, read, list, get, fetch, describe|
| Write | update, modify, patch, edit, set, assign|
| Delete | delete, remove, destroy, terminate, purge|
| Observability | monitor, observe, log, trace, inspect, audit|

# Example
**Provisioning a host** could mean
  - create a host
  - install resources on a host

A provisioning system might interact with or rely on:
- VMware
- KVM
- Hyper-V
- OpenStack
- AWS
- OVHcloud

The provisioner doesn't necessarily runs the VM. It asks the infrastructure system to create it.
