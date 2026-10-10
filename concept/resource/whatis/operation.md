[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ resource][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[res whatis]:  /concept/resource/whatis/ep.md
[ope list]:    ../list/operation.md
[host whatis]: /concept/machine/whatis/host.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Host][host whatis]|see|
|[What is a Resource][res whatis]|see|
|[List of Operations][ope list]|see|


<h1 align="center">What is a Resource Operation</h1>





# Definition
## Operation
- An action performed on a resource.
- Usually a verb.

## Operate
* The action of operating on a [resource][res whatis].
* **Operating on a resource** 
  - means acting upon that resource so that it produce a response.  
  - Is Possible **only** when a resource is available and ready for operations

## Operator
- An **Automation** component
- Manage the lifecycle and state of a resource
- sometimes Uses a control loop (aka. **controller**) to **continuously** reconcile the desired state with the actual state



# Key ideas
- Resource-specific operations are defined in the resource's own doc.


# Kind


Operation can be classified in this categories

| Class | Applies to |
|-|-|
| Generic     | nearly all resources kinds |
| Atomic      | atomic nodes only |
| Collection  | collection nodes only |


Operation can be classified in this categories

| Category | Example |
|-|-|
| Lifecycle | start, stop, restart, pause, resume, instanciate, init|
| Execution | execute, run, invoke, trigger, deploy|
| Read |query, read, list, get, fetch, describe|
| Write | update, modify, patch, edit, set, assign|
| Delete | delete, remove, destroy, terminate, purge|
| Observability | monitor, observe, log, trace, inspect, describe, audit, info|

# Example of Operation
See [List of Operations][ope list]

# Example of Operator

**Examples 01**: operator that manage **resource lifecycle** after it is provisioned


|Operator|Resource Managed|Operation|
|-|-|-|
|VM Operator|VMs|start, stop, snapshot, resize, migrate|
|Backup Operator|Scheduled backups (DBs, files)|backup, restore, verify, rotate|
|Scaling Operator|manages auto-scaling of application instances based on metrics|scale up, scale down, rebalance|
|Logging Operator|Log collection and Rotation across a fleet of servers|collect, rotate, archive, forward|
|Network Operator|Network configuration and routing rules| assign IP, update firewall rules, configure load, balancers, manage DNS records|

**Examples 02**: operator that manage **entire resource lifecycle** including "resource **creation**"

|Operator|Resource Managed|Operation|
|-|-|-|
| Kubernetes Operator | Kubernetes application | **deploy**, scale, update, backup, recover|
| Deployment Operator | Kubernetes deployment | **deploy**, rollback, promote, canary|
| Database Operator | database clusters | **provision**, backup, failover, upgrade|
|Message Queue Operator | message brokers like Kafka or RabbitMQ | **provision**, partition rebalance, upgrade, scaling, mirroring|
| Certificate Operator | TLS/SSL certificates | **provision**, renew, revoke, rotate|
| Storage Operator | persistent storage volumes | **provision**, resize, snapshot, restore, replication|
| Service Mesh Operator | service mesh infrastructure (Istio/Linkerd) | **provision**, injection, configuration, upgrade, observability|


