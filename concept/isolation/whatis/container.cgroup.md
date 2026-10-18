[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[container whatis]: ../whatis/container.md
[containerisation whatis]: ../whatis/containerisation.md
[cgroup howto]: ../howto/container.cgroup.md
[namespace whatis]: ../whatis/container.namespace.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a Container][container whatis]|
|[What is a Containerisation][containerisation whatis]|
|[How-to for Cgroup][cgroup howto]|
|[What is a Namespace][namespace whatis]|

<h1 align="center">What is a Cgroup</h1>

The concept of Cgroup


# Definition
- Aka. **C**ontrol **Groups**
- A set of processes (a **parent** process and its **descendants** - Tree)
- A mechanism implemented in the Linux OS Kernel

# Kind
**version**
- cgroup v1: multiple hierarchies
- cgroup v2: single unified hierarchy

**nature**
- root
- non-root
# What Cgroup provide
- Control/Limit the resources a group of processes can use.

# Cgroup as a set
- It is possible to create Cgroup

# Cgroup as a mechanism
The linux Kernel ensure isolation by:
- **creating** cgroups:it places a **parent** process and its **descendants** (aka. process tree) into a cgroup
- **Limiting** resource usage per cgroup through controllers (subsystems)
  - cpu — CPU shares / bandwidth
  - memory — memory + swap limits
  - blkio — block I/O throttling
  - cpuset — pin to specific CPUs / NUMA nodes
  - pids — max number of processes
- **tracking** (aka. accounting) the amount of resource each cgroup consume
  - cpuacct — CPU usage accounting
  - memory — usage + statistics (memory.stat, memory.failcnt)


# Configuration

**Path**: 
- The cgroup v2 filesystem is mounted at `/sys/fs/cgroup/`
- It is a special filesystem through which you interact with the Linux kernel.

**Config files**

| File                 | Simple meaning                                     |
| -------------------- | -------------------------------------------------- |
| `cgroup.procs`       | Shows processes belonging directly to this cgroup. |
| `cgroup.controllers` | Shows controllers available to this cgroup.        |
| `memory.current`     | Shows the cgroup’s current memory usage.           |
| `memory.max`         | Sets or reports the cgroup’s memory limit.         |
| `cpu.max`            | Controls the cgroup’s CPU bandwidth.               |

