[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[cgroup whatis]: ../whatis/container.cgroup.md
[namespace whatis]: ../whatis/container.namespace.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is Cgroup][cgroup whatis]|
|[What is Namespace][namespace whatis]|

<h1 align="center">How-to for Namespace</h1>

The concept of Namespace


# Quick examples
```bash
# create a new network namespace and run a shell in it
unshare --net --pid --fork --mount-proc /bin/bash

# list namespaces
lsns

# enter a container's namespaces
nsenter -t <pid> -m -u -i -n -p
```


# `unshare()`
- creates a new namespace context for the caller

```
        SHARED LINUX KERNEL
                 |
          NETWORK NAMESPACE A
          ┌──────────────────┐
          │ eth0: 10.0.0.2   │
          │ lo               │
          │ Routes A         │
          │                  │
          │ Process A        │
          │ Process C        │
          └──────────────────┘
```
Process C calls unshare(CLONE_NEWNET) → The kernel creates a new network namespace for Process C.
```
        SHARED LINUX KERNEL
                 |
          +------+------+
          |             |
   NAMESPACE A     NAMESPACE C
   ┌───────────┐   ┌────────────┐
   │ eth0      │   │ lo         │
   │ 10.0.0.2  │   │ (initially │
   │           │   │  down)     │
   │ Process A │   │            │
   └───────────┘   │ Process C  │
                   └────────────┘
```


# `Setns()`

moves 1 process from 1 namespace to another. Some requirements must be met.

```
BEFORE setns()
────────────────────────────────
Network Namespace A
├── Process A
└── Process C  ← here

Network Namespace B
└── Process B


        setns(fd_for_net_B)
                 │
                 ▼

AFTER setns()
────────────────────────────────
Network Namespace A
└── Process A

Network Namespace B
├── Process B
└── Process C  ← now here
```