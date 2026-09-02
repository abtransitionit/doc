[//]: #(home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[res whatis]:       ../whatis/res.md
[host concept]:     ../list/concept.md#
[rctl whatis]:      ../whatis/ep.md
[provision whatis]: ../../../whatis/provision.md
[manage howto]:     ../howto/manage.md

[←][home] 

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is rctl][rctl whatis] |
|[What is a resource ][res whatis] |
|[What is a provisioning ][provision whatis] |
|[How-to manage ][manage howto] |




<h1 align="center">Operate</h1>



# Definition

## Operate
* The action of operating on a [resource][res whatis].
* Is Possible **only** when a resource is ready
* **Operating on a resource** means acting upon that [resource][res whatis] so that it produce a response.  
* Depending on the context, **operate** generally means: 
  - **start, stop, restart, execute, run, invoke or trigger**
  - **query, read, list, get or fetch** (for read operations)
  - **update, modify, patch or edit** (for write operations)
  - **delete, remove, destroy or terminate** (for delete operations)
  - **monitor, observe, log or trace** (for observability operations)


## Operator
### Context 1: Generic Automation Concept
- An **Automation** concept
- Something that operates on infrastructure/resource
- By extension: something that manages the **lifecycle** of a resource after it is provisioned
- Example
  - **VM Operator** manages VMs (start, stop, snapshot, resize, migrate)
  - **Backup Operator** manages scheduled backups of databases or file systems (backup, restore, verify, rotate)
  - **Scaling Operator** manages auto-scaling of application instances based on metrics (scale up, scale down, rebalance)
  - **Logging Operator** manages log collection and rotation across a fleet of servers (collect, rotate, archive, forward)
  - **Network Operator** manages network configuration and routing rules (assign IP, update firewall rules, configure load balancers, manage DNS records)

### Context 2: Kubernetes Operator Pattern (Specific)
- An **Automation** concept popularized by Kubernetes
- Something that manages the **entire lifecycle** of a resource, **including provisioning**.
- Uses a control loop to **continuously** reconcile the desired state with the actual state.
- Example
  - **Kubernetes Operator** manages a Kubernetes application (**deploy**, scale, update, backup, recover)
  - **Database Operator** manages database clusters (**provision**, backup, failover, upgrade)
  - **Message Queue Operator** manages message brokers like Kafka or RabbitMQ (**provision**, partition rebalance, upgrade, scaling, mirroring)
  - **Certificate Operator** manages TLS/SSL certificates (**provision**, renew, revoke, rotate)
  - **Storage Operator** manages persistent storage volumes (**provision**, resize, snapshot, restore, replication)
  - **Service Mesh Operator** manages service mesh infrastructure (Istio/Linkerd) (**provision**, injection, configuration, upgrade, observability)

# Kind

An arbitrary classification of operation
## Lifecycle operations
  - start, stop, restart, pause, resume

## Execution operations
  - execute, run, invoke, trigger, deploy

## Read operations
  - query, read, list, get, fetch, describe

## Write operations
  - update, modify, patch, edit, set, assign

## Delete operations
  - delete, remove, destroy, terminate, purge

## Observability operations
  - monitor, observe, log, trace, inspect, audit


# Example
**Provision a host** could mean
  - create a host
  - install resources on a host

# Example
A provisioning system might interact with:
- VMware
- KVM
- Hyper-V
- OpenStack
- AWS
- OVHcloud

The provisioner doesn't necessarily run the VM. It asks the infrastructure system to create it.
