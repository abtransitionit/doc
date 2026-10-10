[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Cluster][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[host whatis]: /concept/machine/whatis/host.md
[openstack whatis]:    https://canonical.com/openstack
[openstack 02 whatis]: https://docs.openstack.org

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is OpenStack][openstack whatis]|external|



<h1 align="center">What is a OpenStack Cloud</h1>

The concept of OpenStack Cluster

# Definition
- Aka. OpenStack cluster
- Distrinuted plaform
- a General-purpose cloud computing environment on premise
- Orchestrates [VMs](#) lifecycle by delegating VM lifecycle to hypervisors on compute nodes
- written in **Python**
- **Modular** by design
- **Uses both declarative** (Heat templates, Terraform) and **imperative** (CLI, API calls) modes
- Allow to create
  - Custom private/public cloud (infrastructure)
  - Sovereign cloud for digital sovereignty
  - An alternative to proprietary virtualization solutions
  - Local/regional public cloud for customers



# Concept
**Node Role**: Is defined by the components it hosts

| Node role  | Main responsibility               | Example components                    |
| ---------- | --------------------------------- | ------------------------------------- |
| Compute    | Creates and runs Runs VMs         | `Nova` Compute, `              |
| Controller | <li>Hosts OpenStack services <li>Manages and coordinating the cloud          | `Keystone`, Nova API, Placement         |
| Network    | Provides network connectivity     | `Neutron` agents or networking services |
| Storage    | <li>Provides persistent storage <li>E.g. block storage, object storage       | `Cinder`, `Swift`, `Ceph`       |

The exact roles and component placement depend on the 
- OpenStack release, 
- networking backend, 
- storage architecture, 
- deployment tool. 

For example, a controller node may also run networking or storage services.

**OpenStack deployment** 
- A complete installation and configuration of OpenStack services
- Provide a cloud computing environment.

**controller** 
- Often a replicated physical server (in production).
- Hosts the services responsible for managing the cloud.

**Service**
- A daemon that manages a specific resource type
- Has its own **API**, **database**, and **agents**

**Project**
- A logical grouping and administrative scope for cloud resources (e.g. VM, networks, storage).
- Allows resources to be organized by team, department, or application.
- Works with Keystone users, roles, and service policies to control access to resources.
- Provides a basis for applying resource quotas and tracking resource usage.

# OpenStack as a Cluster
OpenStack is by design distributed. It must be installed on a set of [hosts][host whatis] (aka. **nodes**).


| Environment | Node type | Notes |
|-|-|-|
|Production-like| Bare-Metal |
|Dev, Test| VM | cf. [DevStack], [OpenStack-Ansible](#)

# OpenStack as a Platform

OpenStack is composed of elements of different types.

| Element type          | Examples                                        | Purpose                                                                        |
| --------------------- | ----------------------------------------------- | ------------------------------------------------------------------------------ |
| Command-line tools    | `openstack`, `nova`, `neutron`                  | Allow users and administrators to interact with OpenStack services.            |
| Services              |` Nova`, `Neutron`, `Keystone`, `Glance`, `Cinder`  | Provide the functionality of the cloud. |
| Service components    | API servers, schedulers, workers, daemons       | Handle requests and perform specific operational tasks.                        |
| Databases             | `MariaDB`, `MySQL`                              | Store service configuration and operational metadata.                          |
| Message queues        | `RabbitMQ`                                        | Enable communication between distributed service components.                   |
| Configuration files   | `nova.conf`, `neutron.conf`, `keystone.conf`    | Define service settings and behavior.                                          |
| Environment variables | `OS_AUTH_URL`, `OS_USERNAME`, `OS_PROJECT_NAME` | Supply authentication and other settings to client tools.                      |


> ⚠️ `Nova`, `Neutron`, and `Keystone` are OpenStack services or projects. 

> 🚧 `API server`, `scheduler`, or `worker` is a component within a service architecture. 

> ⚠️ Databases and message queues are supporting infrastructure components.

# OpenStack is Modular by dessign

- OpenStack is, by design, built from independent **components** that communicate.
- communicate is done through APIs and messaging systems.
- Each component has a clear **responsibility** and defined **capabilities**.
- Each component/Service exposes its own API endpoint (e.g. `Nova` API, `Neutron` API, `Glance` API)
- Each component/service (Nova, Neutron, Cinder, Glance, Keystone) has its **own API and database**, connected by a message queue.
- Components can be deployed on different nodes and work together to provide the **cloud computing services**.




**Core components** include:

| Component  | Service            | Responsibilities                                                           |
| ---------- | ------------------- | -------------------------------------------------------------------------- |
| Keystone   | Identity            | **Authentication**, authorization, and service catalog management.             |
| Nova       | Compute             | Creates, schedules, and manages **VM instances**.                              |
| Neutron    | Networking          | Manages **networks**, subnets, routers, IP addresses, and connectivity.        |
| Glance     | Image               | Stores, discovers, and retrieves **VM images**.                                |
| Cinder     | Block Storage       | Provides **persistent** block storage volumes for VM instances.                   |
| Swift      | Object Storage      | Stores and retrieves objects, files, and unstructured data.                |
| Placement  | Resource Management | Tracks resource inventories and **allocations** to support resource selection. |
| Horizon    | Dashboard           | Provides a **web interface** for users and administrators.                     |
| Heat       | Orchestration       | Creates and manages cloud resources using templates.                       |
| Ironic     | Bare Metal          | **Provisions** and manages **physical** machines.                                  |
| Octavia    | Load Balancing      | **Provisions** and manages **load balancers**.                                     |
| Manila     | Shared File Systems | Provides shared file storage accessible by multiple clients.               |
| Barbican   | Key Management      | Manages **secrets**, encryption keys, and certificates.                        |
| Designate  | DNS                 | Manages DNS zones and record sets.                                         |
| Ceilometer | Telemetry           | Collects measurements and events for monitoring and metering.              |

> ⚠️ Not every deployment includes every OpenStack component. The components installed depend on the cloud's requirements.

**Supporting infrastructure** components (i.e.component needed by Core Components) include:

| Component | Function                      | Responsibilities                                                              |
| --------- | ----------------------------- | ----------------------------------------------------------------------------- |
| MariaDB, PostgesDB   | Database           | Stores service state, metadata, and other persistent information.             |
| RabbitMQ  | Message Queue                 | Enables communication and coordination between distributed service processes. |
| HAProxy   | Load Balancer / Reverse Proxy | Distributes API requests, forwards traffic, and can provide TLS termination.  |



## Keystone — Identity service

Authenticates users and provides the service catalog containing service endpoints.

handles:
* authentication
* users
* projects (tenants)
* API tokens

**Example flow**:

```
Agent → Keystone → authentication token
```

> ⚠️ All OpenStack services trust Keystone.


## Nova — Compute service

Manages **VMs**. Capabilities/Responsabilities:
* create instances
* schedule them on compute nodes
* start/stop/reboot VMs

> ⚠️ Nova interacts with the **hypervisor** (by default `KVM/QEmu`)

**Example**:

```sh
# Using the cli - it create and launch a VM
openstack server create
```


## Glance — Image service

Stores **VM images**.

**Examples of images**:
```
Ubuntu cloud image
Fedora cloud image
Alpine image
```

**Example flow**:

```
Glance → provides OS image → Nova boots VM (with that image)
```

> ⚠️ Without `Glance`, `Nova` would have **no OS to start**.


## Neutron — Networking service

Creates virtual networks. Mmanages:
* tenant networks
* routers
* floating IP
* DHCP
* security groups

**Example**:

```
VM → virtual network → router → internet
```

## Core Compute & Bare Metal
Main feature: Provision and manage virtual machines, bare-metal nodes, and instance lifecycles.
- [Nova](https://docs.openstack.org/nova/): Core compute engine managing virtual machine instances and hypervisors.
- [Zun](https://docs.openstack.org/zun/): Container management service for launching containers natively without managing VMs.

## Networking & Traffic Routing
Main feature: Provide Software-Defined Networking (SDN), IP address management, and load balancing.
- [Neutron](https://docs.openstack.org/neutron/): Core SDN component handling network topologies, subnets, routers, and floating IPs.
- [Octavia](https://docs.openstack.org/octavia/): Scalable load balancer service (LBaaS) for OpenStack environments.
- [Designate](https://docs.openstack.org/designate/): Multi-tenant DNS-as-a-Service for dynamic domain updates across instances.

## Storage Infrastructure
Main feature: Supply persistent block, object, and shared file storage backends.
- [Cinder](https://docs.openstack.org/cinder/): Persistent block storage service for volume attachments to VMs.
- [Swift](https://docs.openstack.org/swift/): Massively scalable distributed Object Storage system (S3-compatible).
- [Manila](https://docs.openstack.org/manila/): Shared File Systems-as-a-Service (e.g., NFS, CIFS).

## Identity, Security & Image Catalog
Main feature: Centralize authentication, secret management, authorization, and base image registries.
- [Keystone](https://docs.openstack.org/keystone/): Central identity management, authentication (AuthN), authorization (AuthZ), and API catalog.
- [Glance](https://docs.openstack.org/glance/): Virtual machine and container image discovery, registration, and delivery.
- [Barbican](https://docs.openstack.org/barbican/): Secure key management service for certificates, passwords, and encryption keys.

## Orchestration, Automation & Web UI
Main feature: Provision multi-component application stacks, manage resources through code, and present user dashboards.
- [Heat](https://docs.openstack.org/heat/): Native template-based orchestration engine (similar to AWS CloudFormation).
- [Horizon](https://docs.openstack.org/horizon/): Canonical web-based user interface and management dashboard for OpenStack services.
- [Magnum](https://docs.openstack.org/magnum/): API service to automate production Kubernetes cluster deployments directly on top of OpenStack.

## Telemetry & Monitoring
Main feature: Collect usage metrics, measure resource consumption, and trigger alerts.
- [Ceilometer](https://docs.openstack.org/ceilometer/): Data collection service tracking usage for billing and performance metering.
- [Aodh](https://docs.openstack.org/aodh/): Alarm service that evaluates metrics from Ceilometer to trigger autoscaling events.


# Openstack Deployment Use cases

**A Minimal OpenStack architecture**

```
agent (User / CLI / API / Script)
        │
        ▼
   Keystone
 (Identity)
        │
        ▼
      Nova ────────────────┐
 (Compute / VM manager)    │
        │                  │
        │                  ▼
        │              Neutron
        │            (Networking)
        │
        ▼
      Glance
   (Images / OS)
```


## Minimal single node deployment

```yaml
Server
└── OpenStack services
    ├── Keystone
    ├── Nova
    ├── Glance
    └── Neutron
        │
        ▼
     KVM hypervisor
        │
        ▼
     VM instances
```

# Typical VM Creation Flow

```sh
# 1. Authenticate with OpenStack
Agent → Keystone → Authenticate and obtain token

# 2. Request VM creation
Agent → Nova API → Request instance creation

# 3. Schedule the VM
Nova → Placement → Select suitable compute resources

# 4. Obtain the VM image
Nova Compute → Glance → Retrieve image information and image data as needed

# 5. Configure networking
Nova → Neutron → Create or attach network ports

# 6. Create and start the VM
Nova Compute → Hypervisor (KVM) → Create and start VM

# 7. Complete networking configuration
Neutron agents or backend → Configure network connectivity

# Result
Running VM instance with network connectivity
```
# How it works

## From Request to VM

1. **You** → request an instance via API/CLI.
1. **Nova scheduler** → selects a compute node .
1. **nova-compute agent** → calls **libvirt**.
1. **Hypervisor** (KVM/QEMU) → **starts the VM**.


## What Requests can be scoped to a project?

- Create or delete a VM using Nova.
- Create a network using Neutron.
- Create a volume using Cinder.
- List the VMs belonging to the project.

# Imperative vs. Declarative

## Imperative

You tell OpenStack **what to do**, step by step:
```bash
openstack server create --flavor m1.medium --image debian-13 --network private my-vm
openstack volume create --size 10 my-volume
openstack server delete my-vm
```
- **You** → issue a command.
- **CLI** → sends an API request.
- **Service** → executes the action.

**Examples of CLI**

| IT concept | OpenStack equivalent | API / Template | Notes |
|---|---|---|---|
| **Running VM** | **Instance** | `openstack server create` | T |
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

### From common resources to OpenStack resources

| IT / Cloud concept | OpenStack equivalent | API command | Notes |
|---|---|---|---|
| **Run VM** | **Instance** | `openstack server create` | he smallest deployable compute unit |
| **VM template** | **Image** | `openstack image create` | OS disk image (qcow2, etc.) |
| **VM size** | **Flavor** | `openstack flavor create` | vCPU, RAM, disk |
| **Block device** | **Volume** | `openstack volume create` | Attachable storage |
| **Virtual network** | **Network** | `openstack network create` | L2/L3 network |
| **IP range** | **Subnet** | `openstack subnet create` | CIDR within a network |
| **Firewall** | **Security Group** | `openstack security group create` | Rules for VM traffic |
| **SSH access** | **Keypair** | `openstack keypair create` | Injected into VM |
| **Identity** | **Project** | `openstack project create` | Tenant isolation |
| **Declarative stack** | **Heat Stack** | `openstack stack create` | Orchestrates multiple resources |


## Declarative
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

## Conclusion

| | Imperative | Declarative |
|---|---|---|
| You provide | **commands** (how) | **template** (what) |
| OpenStack does | executes the action | orchestrates the resources |
| Idempotent | ❌ not really | ✅ Heat templates are |
| Best for | quick tasks | repeatable deployments |

# Openstack Tenant

- Isolation works by combining **projects**, **users**, **roles**, and **policies** to control who can access which cloud resources.
- `Keystone` manages identities, **projects**, and **role** assignments. 
- OpenStack services, such as `Nova` and `Neutron`, enforce authorization through their policies.

## key concepts

| Concept | Meaning                                                  | Example                       |
| ------- | -------------------------------------------------------- | ----------------------------- |
| Project | A logical space for grouping resources                   | `team_A`                      |
| User    | A person or service account                              | `alice`                       |
| Role    | Defines the permissions granted to a user within a scope | `member`                      |
| Policy  | Rules that determine whether an operation is allowed     | Who can create or delete a VM |
||
| Keystone| Handles authentication, tokens, projects, and role assignments|
| OpenStack services |Enforce authorization when users access or manage resources|

## How-to

1. Create separate projects to organize resources separately.
1. Use `Keystone` **roles** and **service** policies so users can access only the resources they are authorized to manage.
1. Configure `Neutron` networks to isolate networks if needed. where appropriate, security groups to control network connectivity.
1. Limit how many resources each project can consume (i.e. quota).


# Openstack resource

| Category | Purpose | Common resources |
|---|---|---|
| **Compute** | Run VMs | `Instance`, `Flavor`, `Server Group` |
| **Networking** | Provide connectivity | `Network`, `Subnet`, `Router`, `Security Group` |
| **Storage** | Persistent data | `Volume`, `Snapshot`, `Object`, `Container` |
| **Images** | VM templates | `Image` |
| **Identity** | Auth and tenancy | `Project`, `User`, `Role` |
| **Orchestration** | Declarative stacks | `Stack` (Heat) |

# Modeling VMs

A VM needs:
- **Image** (from Glance) — the OS template
- **Flavor** — CPU, RAM, disk size
- **Network** — connectivity
- **Security group** — firewall rules
- **Keypair** — SSH access


# Tools around OpenStack


# Todo

# Todo

| Connection                                    | Purpose                                                                       |
| --------------------------------------------- | ----------------------------------------------------------------------------- |
| Horizon / CLI → Keystone                      | Authenticate and obtain a token.                                              |
| Horizon / CLI → Nova, Neutron, Glance, Cinder | Send authenticated requests to the appropriate API.                           |
| Nova → Placement                              | Select suitable compute resources.                                            |
| Nova → Glance                                 | Obtain image information and image data as needed to launch an instance.      |
| Nova → Neutron                                | Request network ports and connectivity for an instance.                       |
| Nova → Cinder                                 | Attach or detach persistent block-storage volumes when requested.             |
| OpenStack services ↔ Message queue            | Coordinate operations between distributed service processes where applicable. |
| OpenStack services ↔ Database                 | Read and store service state and metadata.                                    |


# Todo
```
Controller node
    ├ API
    ├ DB
    ├ scheduler
    └ message queue

Compute nodes
    └ hypervisor (KVM)

Network nodes
    └ Neutron agents
```    



# Todo

- **Heat templates** provide declarative orchestration for stacks of resources
- Most operations are driven by **API calls** or **CLI commands**

# Todo
- Nova **Scheduler** places VMs on compute nodes
- Nova **Conductor** coordinates database operations
- **Compute agent** (`nova-compute`) runs on each compute node
