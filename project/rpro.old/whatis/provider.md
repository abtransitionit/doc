[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(functional)
[env whatis]: ../whatis/host.md
[res whatis]: ../whatis/res.md

[←][home] 

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is an Environment][env whatis]|internal
|[What is a Resource][res whatis]|internal



<h1 align="center">RPro Provider</h1>


# Definition
```
Provider
   ├── provisions  → Resource
   └── operates in → Environment
```   

# Example of basic providers
```
Provider
   │
   │
   ├── Local Provider
   │      ├── provisions → Filesystem Resources
   │      └── operates in → Local Host
   │
   ├── Docker Provider
   │      ├── provisions → Container Resources
   │      └── operates in → Docker Engine
   │
   └── Kubernetes Provider
          ├── provisions → Kubernetes Resources
          └── operates in → Kubernetes Cluster
```
# Example of more sophiticated basic providers


```
Provider
   │
   │
   ├── Container Provider
   │       ├── provisions  → Container resources
   │       └── operates in → Cloud / Infrastructure      
   │
   ├── Container Runtime Provider
   │       ├── provisions  → Container Runtime
   │       └── operates in → Cloud / Infrastructure / Remote or Local Host / Remote or Local VM
   │
   ├── Container Provider
   │       ├── provisions  → Container Resource
   │       └── operates in container in → Cloud / Infrastructure / Remote or Local Host/Vm
   │
   ├── VM Provider
   │       ├── provisions  → VMs
   │       ├── provisions  → VM resources
   │       └── operates in → Cloud / Infrastructure      
   │ 
   ├── Kubernetes Provider
   │       ├── provisions → Kubernetes cluster
   │       ├── provisions → Kubernetes resources (Pod, Service, Deployment, Volume, ConfigMap, Secret, ...)
   │       └── operates in → Cloud / Infrastructure      
   │
   └── Kubernetes Provider
           └── provisions → Kubernetes Cluster

Local Filesystem Provider (Local Provider)
   ├── provisions → Filesystem Resources (directory, file, mount, volume, permissions, ownership)
   └── operates in → Local Host

Remote Filesystem Provider (SSH Provider)
   ├── provisions → Filesystem Resources (directory, file, mount, volume, permissions, ownership)
   └── operates in → Remote Host

Kubernetes Provider
   ├── provisions → Kubernetes Cluster
   └── operates in → Cloud / Infrastructure      

Kubernetes Provider
   ├── provisions → Kubernetes resources 
   └── operates in → Kubernetes cluster   

Local Provider
   ├── provisions → Filesystem / Process
   └── operates in → Local Machine

SSH Provider
   ├── provisions  → Filesystem / Process
   └── operates in → Remote Host


Docker Provider
   ├── provisions → Docker Resource (Container / Volume / Network)
   └── operates in → Docker Engine

Kubernetes Provider
   ├── provisions → Kubernetes Resources
   └── operates in → Kubernetes Cluster   
```


# Question concerning the Model of a Resource

* What exactly is a `Resource`?
- is `Filesystem` itself a resource or a resource category.
* Is `Filesystem` a resource or a category of resources?
- is `Kubernetes Cluster` an environment or something that the system itself can provision.
* Is `Directory`  a resource?
* Is `Volume`     a resource?
* What is a `Provider` exactly?
- Does `VM Provider`provisions `Virtual Machine` or `Virtual Machine Resources`.
* Can one provider provision several resource types?
* Can a resource be provisioned by several providers?
* What exactly is an `Environment`?
* Is a Kubernetes cluster an environment or a resource?
* Can a provider operate in multiple environments?



### The useful separation

Think of our tutorial like this:

```text
DOMAIN
"What exists in the problem?"

    Resource
    Environment
    Provider
    Provisioning
    Configuration


MODEL
"How do these concepts work together?"

    Resource
       ↑
    Provider → Environment
       ↑
    Provisioning
       ↑
    Configuration
```

So your digging was **not wasted at all**.

In fact, you've just discovered why the lifecycle has separate:

```text
Domain → Model
```

The **Domain** tells us *what we need to understand*.

The **Model** will tell us *how we represent and relate it*.

I'd therefore **not add all those provider variations to the tutorial yet**. Keep the Domain section clean, and save this material for Step 03.
