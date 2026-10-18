[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[container runtime list]: ../list/container.runtime.md
[container whatis]: ../whatis/container.md
[containerisation whatis]: ../whatis/containerisation.md
[cotainer runtime list]: ../list/container.runtime.md
Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[List of Container Runtime][container runtime list]|
|[What is a Container][container whatis]|
|[What is a Containerisation][containerisation whatis]|

<h1 align="center">What is a Container Runtime</h1>

The concept of Container Runtime


# Definition

- A system
- Manage [Containers][container whatis]
- Virtualize the harware resource of the **Host** 

```
        └── ⚙️ CONTAINER RUNTIME     ← manage the containers
             │                        (creates & runs containers)        
             │                        (pulls images, sets up isolation)        

```


```
🐧 LINUX KERNEL
 │
 └── 📦 CONTAINER PRIMITIVES          ← the REAL mechanism
      ├── namespaces  (view isolation)
      ├── cgroups     (resource limits)
      ├── capabilities, seccomp, LSM (security)
      └── pivot_root / chroot (filesystem)
           │
           └── 🏗️  CONTAINER RUNTIME    ← uses those primitives
                │
                └── 🚀 ORCHESTRATOR / CLI  ← what users type
```


# Key idea
- the kernel does the isolation
- The container runtime just uses the kernel services.

# Kind
- Low level CR
- High level CR
- Container orcherstrator
- CLI manager

cf. list of [container runtime][cotainer runtime list]



# CR on mac
- tools like `Docker` or `Colima` on `Mac`, work by running a **lightweight Linux VM** in the background. 
