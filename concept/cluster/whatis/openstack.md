[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Cluster][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[host whatis]: /concept/machine/whatis/host.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |



# TODO TODO TODO
this is just a completly created from deepseek ... just delete and rewrite it

**I provide this prompt**:
- I will give you my doc of kubernetes, and I want you do do the same kind of short but accurate doc for openstack. do you think it is possible ?

# TODO TODO TODO


<h1 align="center">What is a OpenStack Cluster</h1>

The concept of OpenStack Cluster

- It's modular
- Each service managing its own API and database
- The core idea that maps to your K8s doc is: 
- A set of services that 
  - model infrastructure resources
  - delegates the actual VM lifecycle to hypervisors on compute nodes

# Definition

- **Aka** OpenStack, OpenStack Cloud
- **Orchestrates** 
  - the lifecycle of **virtual machines (instances)** 
  - the infrastructure that supports them (networking, storage, images)
- **Uses both declarative** (Heat templates, Terraform) and **imperative** (CLI, API calls) modes

# Key Idea

- Infrastructure resources (compute, storage, networking) are modeled as **OpenStack resources**.
- OpenStack doesn't manage VMs directly — it **defines APIs** and delegates the low-level work to external components.
- The **control plane** (controller nodes) makes decisions
- **compute nodes** run the actual workloads via **hypervisors**.
- Each service (Nova, Neutron, Cinder, Glance, Keystone) has its **own API and database**, connected by a message queue.

### Concept

**Node Role**
- Each node has a role
- It may be a
  - **controller**: runs the shared services (APIs, scheduler, database, message queue)
  - **compute**: runs the actual VMs via a hypervisor
  - **storage**: hosts persistent data (Cinder, Swift, Ceph)

**Resource**
- A piece of infrastructure managed by OpenStack (e.g. `Instance`, `Volume`, `Network`, `Image`)

**Object**
- An **instance** of a resource (e.g. a specific VM named `web-01`, a volume named `data-vol`)
- Has a unique **UUID** and a name

**Service**
- A daemon that manages a specific resource type
- Has its own **API**, **database**, and **agents**

**Manifest**
- In OpenStack, there is **no universal manifest** like K8s YAML for all resources
- **Heat templates** provide declarative orchestration for stacks of resources
- Most operations are driven by **API calls** or **CLI commands**

**State**
- Each resource has a state:
    - **Current/Actual state** = what's running now
    - **Desired state** = what the API request specified

**Controller / Agent**
- A background process that carries out operations
- **Scheduler** (Nova) places VMs on compute nodes
- **Conductor** (Nova) coordinates database operations
- **Compute agent** (`nova-compute`) runs on each compute node

### How it works

**Modeling as OpenStack resources**
1. **You** → declare what you want using API calls (`openstack server create`, `openstack volume create`, etc.) or Heat templates.
2. **Service API** → receives the request, validates it, stores it in the service's database.
3. **Scheduler / Conductor** → decides which compute node should handle the request.

**From desired state to running VMs**
1. **API** → receives the request (e.g. "create an instance").
2. **Scheduler** → selects a compute node based on resources, filters, and weights .
3. **Conductor** → coordinates the build with the selected compute node.
4. **Compute agent** (`nova-compute`) → receives the build request.
5. **Hypervisor** (via **libvirt**, e.g. KVM, QEMU) → **starts / stops / migrates VMs**.

### Imperative vs. Declarative

**Imperative**
You tell OpenStack **what to do**, step by step:
```bash
openstack server create --flavor m1.medium --image debian-13 --network private my-vm
openstack volume create --size 10 my-volume
openstack server delete my-vm
```
- **You** → issue a command.
- **CLI** → sends an API request.
- **Service** → executes the action.

**Declarative**
You describe **what you want**, and Heat figures out how:
```yaml
resources:
  my_server:
    type: OS::Nova::Server
    properties:
      flavor: m1.medium
      image: debian-13
```
- **You** → write a Heat template.
- **Heat engine** → creates the resources in the right order.

### The key difference

| | Imperative | Declarative |
|---|---|---|
| You provide | **commands** (how) | **template** (what) |
| OpenStack does | executes the action | orchestrates the resources |
| Idempotent | ❌ not really | ✅ Heat templates are |
| Best for | quick tasks | repeatable deployments |

### From common concepts to OpenStack resources

| IT concept | OpenStack equivalent | API / Template | Notes |
|---|---|---|---|
| **Running VM** | **Instance** | `openstack server create` | The smallest deployable compute unit |
| **VM image** | **Image** (Glance) | `openstack image create` | No `kind: Image` — it's a resource in Glance |
| **VM sizing** | **Flavor** | `openstack flavor create` | Defines CPU, RAM, disk |
| **Multiple identical VMs** | **Server group** (affinity/anti-affinity) | `openstack server group create` | No direct "Deployment" equivalent |
| **Block storage** | **Volume** (Cinder) | `openstack volume create` | Persistent block device for a VM |
| **Object storage** | **Container / Object** (Swift) | `openstack object create` | For unstructured data |
| **Network** | **Network** (Neutron) | `openstack network create` | Virtual network |
| **Subnet** | **Subnet** (Neutron) | `openstack subnet create` | IP range within a network |
| **Router** | **Router** (Neutron) | `openstack router create` | Connects networks |
| **Security rules** | **Security Group** | `openstack security group create` | Firewall rules for VMs |
| **SSH key** | **Keypair** | `openstack keypair create` | Injected into VMs |
| **Identity** | **Project / User** (Keystone) | `openstack project create` | Multi-tenancy and auth |
| **Template orchestration** | **Heat Stack** | `openstack stack create` | Declarative grouping of resources |

### Modeling VMs inside OpenStack

> ⚠️ You don't manage VMs directly — you request them from the API, and agents handle the low-level work

**1. The Instance is the smallest deployable unit**

A VM is always created through a service API (Nova), never directly on a hypervisor.

**2. An Instance needs supporting resources**

A VM needs:
- **Image** (from Glance) — the OS template
- **Flavor** — CPU, RAM, disk size
- **Network** — connectivity
- **Security group** — firewall rules
- **Keypair** — SSH access

**3. You rarely create VMs directly on a hypervisor**

In practice:
1. **You** → request an instance via API/CLI.
2. **Nova scheduler** → selects a compute node .
3. **nova-compute agent** → calls **libvirt**.
4. **Hypervisor** (KVM/QEMU) → **starts the VM**.

**4. Why this design exists**

- **Multi-tenancy:** projects isolate resources
- **Modularity:** each service can scale independently
- **Abstraction:** you describe *what* you want; OpenStack handles *how* the VM is actually launched

### Classifying OpenStack resources

| Category | Purpose | Common resources |
|---|---|---|
| **Compute** | Run VMs | `Instance`, `Flavor`, `Server Group` |
| **Networking** | Provide connectivity | `Network`, `Subnet`, `Router`, `Security Group` |
| **Storage** | Persistent data | `Volume`, `Snapshot`, `Object`, `Container` |
| **Images** | VM templates | `Image` |
| **Identity** | Auth and tenancy | `Project`, `User`, `Role` |
| **Orchestration** | Declarative stacks | `Stack` (Heat) |

### From common resources to OpenStack resources

| IT / Cloud concept | OpenStack equivalent | API command | Notes |
|---|---|---|---|
| **Running VM** | **Instance** | `openstack server create` | The actual virtual machine |
| **VM template** | **Image** | `openstack image create` | OS disk image (qcow2, etc.) |
| **VM size** | **Flavor** | `openstack flavor create` | vCPU, RAM, disk |
| **Block device** | **Volume** | `openstack volume create` | Attachable storage |
| **Virtual network** | **Network** | `openstack network create` | L2/L3 network |
| **IP range** | **Subnet** | `openstack subnet create` | CIDR within a network |
| **Firewall** | **Security Group** | `openstack security group create` | Rules for VM traffic |
| **SSH access** | **Keypair** | `openstack keypair create` | Injected into VM |
| **Identity** | **Project** | `openstack project create` | Tenant isolation |
| **Declarative stack** | **Heat Stack** | `openstack stack create` | Orchestrates multiple resources |

---

This gives you the same conceptual skeleton as your K8s doc — Definition, Key Idea, Concept, How it works, Imperative vs Declarative, and equivalence tables — while staying accurate to OpenStack's very different architecture (multiple APIs, VMs instead of containers, hypervisors instead of container runtimes).
