[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(functional)
[containerisation whatis]: ../whatis/containerisation.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is Containerisation][containerisation whatis]|


<h1 align="center">What is Workload</h1>

The concept of Workload


# Definition
- everything a system is running, not just one application or process.
- The computing activity taht is runned, managed, isolatee, or limited.
- Might involve multiple processes, several containers, or even several virtual machines.
- Can span multiple containers, VMs and processes
- The thing being run and managed.
- **Contrast**:
    - **Application**: The software, such as a website.
    - **Process**: One running instance of a program.


# Example

```

🖥️  PHYSICAL COMPUTER (Linux)
 │
 ├── ⚙️  HARDWARE                    ← CPU • RAM • Disk
 │
 ├── 🐧 LINUX HOST OS (Kernel)        ← schedules ALL processes on CPU
 │    │                                 manages memory + isolation
 │    │
 │    └── 🐳 DOCKER ENGINE            ← software on the host OS
 │         │                            creates & manages containers
 │         │
 │         └── 📦 WEBSITE CONTAINER   ← isolated env, NO own kernel
 │              │
 │              ├── 🌐 Web server process   ← handles HTTP requests
 │              │
 │              └── 🔧 Worker process       ← background jobs
 │
 └── ⚠️  Key: web + worker are ordinary Linux processes
          running on the HOST kernel — the container is
          just an isolated environment around them.
```          
