






# The Resource
## Classification of resource

```
Execution Environment
└── Container

Host
├── can contain/run → Execution Environment
│                      └── operate on → Resource
└── can be provisioned with → Resource
```  


# Use case
## Provision a physical host


**The roles**
```
                      ┌── Resource   → is provisioned through → Bare-metal Provider
                      │
Physical host ─── As ─┼── Execution Environment → runs 
                      │
                      └── Host       → is provisioned with Resources 
                                                 ├── Package
                                                 ├── User
                                                 └── File
```
**Example**
- physical Ubuntu server provisioned through OpenStack Ironic
- then configured as a VM host:

```text
Physical Host
│
├── as a Host
│   └── is provisioned with Resources
│        ├── Package: qemu-kvm
│        ├── Package: libvirt
│        ├── User: libvirt
│        └── File: /etc/libvirt/...
│
└── as an Execution Environment
    └── operates on → VM
```

- Or configured as a container host:

```text
Physical Host
│
├── as a Host
│   └── is provisioned with Resources
│        ├── Package: docker / containerd / CRI-O
│        ├── User: app
│        └── File: /etc/docker/daemon.json
│
└── as an Execution Environment
    └── operates on → Container
```


From the tool's perspective, provisioning might consist of implementing this through:
```
provision(physical_machine_provider, host)
provision(host, package)
provision(host, user)
provision(host, file)
```
**Todo**
> The Bare-Metal provider is not a Host or Resource (in this model). It is an implementation/provider through which the tool performs the provisioning operation.



Yes. I'd rewrite the old use case so it follows the **same structure and terminology** as the new one, while making the key distinction that the physical host already exists.

## Provision an existing Physical host



**The roles**

```text
                      ┌── Host       → is provisioned with Resources
                      │                       ├── Package
                      │                       ├── User
Physical host ─── As ─┤                       └── File
                      │
                      └── Execution Environment → operates on (the provisioned) Resources
```

**Example**
- A bare-metal Ubuntu server is already available and accessible through SSH.
- Then configure the server with:

```text
Physical Host
│
├── as a Host
│   └── is provisioned with Resources
│        ├── Package: qemu-kvm
│        ├── Package: libvirt
│        ├── User: libvirt
│        └── File: /etc/libvirt/...
│
└── as an Execution Environment
    └── operates on → VM
```

Or:

```text
Physical Host
│
├── as a Host
│   └── is provisioned with Resources
│        ├── Package: docker / containerd / CRI-O
│        ├── User: app
│        └── File: /etc/docker/daemon.json
│
└── as an Execution Environment
    └── operates on → Container
```

From the tool's perspective, provisioning might consist of:

```text
provision(host, package)
provision(host, user)
provision(host, file)
```

Yes — I agree. **“Provision a container from an image, then install nginx inside it”** is often artificial because the image is normally the immutable unit containing the software.

A more realistic use case is that the tool provisions the **container as an execution environment**, while the resources it operates on are external to the container.

For example, a static-site container:

## Provision a Container

**The flow**

```text
Tool
│
├──> provisions → Resource: Container
│                     └──> on Host → Where lives the container runtime
│                     └──> from    → Container Image: nginx/jekyll
│
└──> provisions → Resource: Volume Mount
                    ├── source → Host: /srv/www
                    └── target → Container: /usr/share/nginx/html

└──> provisions → Resource: File
                    │
                    └──> on Host: Physical / Virtual Host
                                      │
                                      └──> made available to Container
```

**Result**
* An nginx/jekyll container exists.
* Host files are made available to the container.
* nginx/jekyll serves those files.

**The roles**

```text
Container
│
├── as a Resource
│   └── is provisioned from → Container Image: nginx
│
├── as a Host
│   └── is provisioned with → external Resources
│
└── as an Execution Environment
    └── operates on → mounted Files
```

**Example**

A static website hosted by an nginx container:

```text
Host
│
├── as a Host
│   └── is provisioned with
│        ├── Directory: /srv/www
│        ├── File: website files
│        └── Container: nginx/jekyll (from container image)
│
└── as an Execution Environment
    └── runs → Container

Container
│
├── as a Resource
│   └── is provisioned from → Image: nginx/jekyll
│
├── as a Host
│   └── is provisioned with
│        └── access to → /srv/www
│
└── as an Execution Environment
    └── operates on → Website Files
Host: Physical / Virtual Host
│
├── as a Host
│   └── is provisioned with
│        └── Directory: /srv/www
│             └── Files: website files
│
└── runs → Container: nginx
              │
              └── as an Execution Environment
                  └── operates on → /usr/share/nginx/html
                                      │
                                      └── mounted from → /srv/www
```

From the tool's perspective:

```text
provision(host, directory)
provision(host, file)

provision(container_runtime, container)
provision(container, volume_mount)
```

This is a much more interesting case for your model because **the container image provides the software, while the host provides the data/resource the software operates on**. It also tests your distinction between **Host, Resource, and Execution Environment** much better.


## Provision a Container

**Goal**:
* provision a container from a container image

**Given**:
* A container runtime is available.
* A container image is accessible to the container runtime.

**The flow**

```text
Tool
│
└──> provisions → Resource: Container
                    │
                    └──> from → Container Image
```

**Result**

* A container exists.
* The container is usable as a provisioning target.

**The roles**

```text
Container
│
├── as a Resource
│   └── is provisioned from → Container Image
│
├── as a Host
│   └── is provisioned with Resources
│        ├── Package
│        ├── User
│        └── File
│
└── as an Execution Environment
    └── runs → Software
```

**Example**

- An Ubuntu container is created from an Ubuntu container image
- then configured with application resources

```text
Host: Container
│
├── as a Host
│   └── is provisioned with Resources
│        ├── Package: nginx
│        ├── User: app
│        └── File: /etc/app/config.yaml
│
└── as an Execution Environment
    └── runs → nginx
```

From the tool's perspective:

```text
provision(container_runtime, container)
provision(container, package)
provision(container, user)
provision(container, file)
```



## Provision an existing Container

**The flow**

```text
Tool
│
└──> provisions → Resources: Package, User, File, ...
                    │
                    └── on Host: Container
```

**Result**

* An existing container is used as a provisioning target.
* Resources are provisioned in the container.

**The roles**

```text
                      ┌── Resource   → is provisioned on → Host
                      │
Container ─────── As ─┼── Host       → is provisioned with Resources
                      │                       ├── Package
                      │                       ├── User
                      │                       └── File
                      │
                      └── Execution Environment → operates on Resources
```

**Example**

* An existing Ubuntu container is available and accessible through `docker exec`.
* Then configure the container with:

```text
Container
│
├── as a Host
│   └── is provisioned with Resources
│        ├── Package: nginx
│        ├── User: app
│        └── File: /etc/app/config.yaml
│
└── as an Execution Environment
    └── operates on → File
```

From the tool's perspective, provisioning might consist of:

```text
provision(host, package)
provision(host, user)
provision(host, file)
```

## Container example

```
Container
├── as a Resource
│   └── Host → is provisioned with → Container
│
├── as a Host
│   └── is provisioned with resources → Package, User, File, ...
│
└── as an Execution Environment
    └── operates on resources → File, ...
```
a concrete example would be an `Ubuntu Container` provisioned with resource
```    
Container
│
└── as a Host
    └── is provisioned with resources
         ├── Package: nginx
         ├── User:    app
         └── File:    /etc/app/config.yaml
```
From the tool's perspective, provisioning the container might consist of connecting to that container using `docker exec` and provision it exactly as any other host:
```
provision(container, package)
provision(container, user)
provision(container, file)
```
The same container can conceptually participate in the model as:
```
                    ┌── Resource
                    │
Container ──────────┼── Execution Environment
                    │
                    └── Host
```   

   
## VM example

```
Tool
│
├── provisions → VM
│                 └── VM is a Resource
│                     └── provisioning delegated to VM Provider
│
└── provisions → resources on VM
                  └── VM is a Host
                      └── is provisioned with resources → Package, User, File, ...
```
> the VM Provider is not a Host or Resource (in this model). It is an implementation/provider through which the tool performs the provisioning operation.

```
VM
├── as a Resource
│   └── provisioning delegated to → VM provider
│
├── as a Host
│   └── is provisioned with resources → Package, User, File, ...
│
└── as an Execution Environment
    └── operates on resources when software executes in → File, ...
```    

a concrete example would be an `Ubuntu VM` provisioned with resource
```    
VM
│
└── as a Host
    └── is provisioned with resources
         ├── Package: nginx
         ├── User:    app
         └── File:    /etc/app/config.yaml
```

From the tool's perspective, provisioning the VM might consist of implementing this through:
```
provision(vm_provider, vm) // where the implementation uses the provider's CLI or API.
provision(vm, package)
provision(vm, user)
provision(vm, file)
```
The same VM can therefore participate as:
```
                    ┌── Resource
                    │
VM ─────────────────┼── Execution Environment
                    │
                    └── Host
```

## Kubernetes Pod example

```text
Pod
├── as a Resource
│   └── Host / Kubernetes node → is provisioned with → Pod
│
├── as an Execution Environment
│   └── operates on → File
│
└── as a Host
    ├── is provisioned with → Package, User, File, ...
    │
    └── concrete example would be a Pod/container environment
        provisioned with → nginx, app user, /etc/app/config.yaml
```

From the tool's perspective, depending on the implementation, provisioning the Pod could mean executing operations through the container runtime or Kubernetes API:

```text
provision(pod, package)
provision(pod, user)
provision(pod, file)
```

The same Pod can therefore participate as:

```text
                    ┌── Resource
                    │
Pod ────────────────┼── Execution Environment
                    │
                    └── Host
```

### Why I think this is a particularly useful example

It demonstrates something your **Container** and **VM** examples don't quite show:

> The role doesn't depend on whether the entity looks like a traditional "machine."

A VM naturally looks like a host. A container can reasonably be considered a host from your tool's perspective. But a **Pod** is primarily an orchestration abstraction, yet your model can still assign it the Host role if your tool treats the Pod as a provisioning target.

I'd therefore slightly change your key-points wording:

```text
# Key points

The symmetry is intentional.

Container
├── can be provisioned as a Resource
├── can provide an Execution Environment
└── can act as a Host

VM
├── can be provisioned as a Resource
├── can provide an Execution Environment
└── can act as a Host

Pod
├── can be provisioned as a Resource
├── can provide an Execution Environment
└── can act as a Host
```

And then your final statement is excellent:

> **Machine, VM, container, Pod, etc. are concrete entities. Host, Execution Environment, and Resource are roles that an entity can fulfill.**

One caveat: **don't imply that every concrete entity must fulfill all three roles.** The important property is that an entity *may* fulfill multiple roles when the relationships in your provisioning model make those roles meaningful.


## Kubernetes Pod example

```text
Pod
├── as a Resource
│   └── Host / Kubernetes node → is provisioned with → Pod
│
├── as an Execution Environment
│   └── operates on → File
│
└── as a Host
    ├── is provisioned with → Package, User, File, ...
    │
    └── concrete example would be a Pod/container environment
        provisioned with → nginx, app user, /etc/app/config.yaml
```

From the tool's perspective, depending on the implementation, provisioning the Pod could mean executing operations through the container runtime or Kubernetes API:

```text
provision(pod, package)
provision(pod, user)
provision(pod, file)
```

The same Pod can therefore participate as:

```text
                    ┌── Resource
                    │
Pod ────────────────┼── Execution Environment
                    │
                    └── Host
```

## Openstack cluster example
Assume:
* 3 bare-metal servers are OpenStack infrastructure hosts
* one of them is dedicated to the compute service on which users subsequently VM instances will lives.
```
Physical Server 1
└── Host
    ├── is provisioned with → OpenStack services
    └── contains/runs → OpenStack Execution Environments

Physical Server 2
└── Host
    ├── is provisioned with → OpenStack services
    └── contains/runs → OpenStack Execution Environments

Physical Server 3
└── Host
    ├── is provisioned with → OpenStack Compute
    └── contains/runs → VM instances
```

Then, after the user creates a VM:
```
Physical Server 3
└── Host
    └── is provisioned with → VM
                              │
                              ├── as Resource (from OpenStack's perspective)
                              │
                              ├── as Host (from the provisioning tool's perspective.)
                              │   ├── is provisioned with → Package
                              │   ├── is provisioned with → User
                              │   └── is provisioned with → File
                              │
                              └── as Execution Environment
                                  └── operates on → File
```
## Kubernetes cluster example
Assume:
* the tool as access to 4 VMs
* the VM can be of any kind (AWS, VMWare, ...)

```
→ VM 1
→ VM 2
→ VM 3
→ VM 4
```                    
Each VM is a Kubernetes Node:
```
VM 1
└── Host
    └── is provisioned with → Kubernetes node components

VM 2
└── Host
    └── is provisioned with → Kubernetes node components

VM 3
└── Host
    └── is provisioned with → Kubernetes node components

VM 4
└── Host
    └── is provisioned with → Kubernetes node components     
```

Then you decide how to customize the kubernetes nodes:
```
├── worker
├── control plane
└── ...
```

Example
```
Kubernetes Cluster
├── VM 1
│   └── Kubernetes Node
│       └── Control Plane
│           ├── kube-apiserver
│           ├── etcd
│           ├── kube-scheduler
│           └── kube-controller-manager
│
├── VM 2
│   └── Kubernetes Node
│       └── Control Plane
│           ├── kube-apiserver
│           ├── etcd
│           ├── kube-scheduler
│           └── kube-controller-manager
│
├── VM 3
│   └── Kubernetes Node
│       └── Worker
│           ├── kubelet
│           ├── kube-proxy
│           └── container runtime
│
└── VM 4
    └── Kubernetes Node
        └── Worker
            ├── kubelet
            ├── kube-proxy
            └── container runtime

```

This gives a multi-level example of the role model:
```
VM
├── as a Host
│   └── is provisioned with → Kubernetes Node components
│
└── as a Resource
    └── is provisioned by → another Host

Pod
├── as a Resource
│   └── is provisioned on → Kubernetes Node / VM
│
└── as an Execution Environment
    └── contains/runs → Container
```


And this gives you the multi-level example of your role model:
```
Host
└── is provisioned with → VM
                          │
                          └── acts as Host
                              │
                              ├── is provisioned with → Kubernetes node components
                              │
                              └── is provisioned with → Pod
                                                        │
                                                        └── Container
                                                            │
                                                            └── Execution Environment
                                                                │
                                                                └── operates on → Resource
```
```
Physical / Cloud Host
└── Resource: VM
    └── Host: VM
        └── Resource: Kubernetes Node components
            └── Resource: Pod
                └── Execution Environment: Container
                    └── operates on → Resource
```

- "Kubernetes Node", "Control Plane", and "Worker" don't have to become new fundamental concepts in the model. They can be roles/attributes applied to the VM/Host depending on what you're modeling.

### Todo
Then Kubernetes can provision Pods onto the worker nodes:
```
VM 3
└── Host
    └── is provisioned with → Pod
                              │
                              └── Container
                                  └── Execution Environment
                                      └── operates on → Resource
```


## key points
the symlettry is total
```
Physical host, Container, VM, Pod
├── can be provisioned as a Resource
└── can act as a Host and be provisioned with resource
├── can provide an Execution Environment

```
- Machine, VM, Pod, container are the concrete entities
- Host, Execution Environment, and Resource are roles that an entity can fulfill
- an entity **may** fulfill multiple roles when the relationships in your provisioning model make those roles meaningful.
- It does not imply that every concrete entity must fulfill all roles.


# The big picture
```

Tool
 │
 └── provisions → Resources
                    │
                    └── on → Host

Host
 │
 ├── is provisioned with / provides / makes available ──→ Resource
 │
 └── contains / runs ──→ Execution Environment
                      │
                      └── operates on ──→ Resource
                                           │
                                           └── exposes resource-specific operations


```

Examples:
```
Execution Environment
    └── operate on → File
                       ├── read
                       └── write

Execution Environment
    └── operate on → Service
                       ├── start
                       ├── stop
                       └── configure
```

```
Execution Environment
└── operate on → CPU
                  ├── consume
                  └── allocate
```
works equally well whether CPU means:
* a physical CPU core,
* a VM's vCPU,
* a container's CPU quota,
* or some higher-level CPU allocation.

# The code

## `Go` structures

used to describe a resource

```go
type Resource struct {
    Kind string
    Name string
}

type Resource interface {
    Kind() string
}
```

### Concrete resourse
```go
type VM struct {
    Name string
}

type Package struct {
    Name    string
    Version string
}

type File struct {
    Path    string
    Content string
}
```

# Todo
## The process
- define a resource class (VM, OS, or member of it)
- provision a resource
  - onboard a resource (concept of parent/context)

## Onboard a resourse
- define it in a ddatabase of things (as long as you know how to treat it **COMPLETLY** withhout resolution )
- define it in a ddatabase of things (as long as you know how to treat it **COMPLETLY**)
- VM, Mac, PC
- Resource


## In provisioning
- no one exist without a parent (concept from linux process)
- every resource class or instance needs to be onBoard .. know it context
